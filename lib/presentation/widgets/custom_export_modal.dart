import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:management_app/models/setting.dart';
import 'package:management_app/models/user.dart';
import 'package:management_app/presentation/providers/setting_data_provider.dart';
import 'package:management_app/presentation/providers/user_data_provider.dart';
import 'package:management_app/presentation/widgets/app_button.dart';

final _formKey4 = GlobalKey<FormBuilderState>();

class CustomExportModal extends StatelessWidget {
  final WidgetRef ref;
  const CustomExportModal({super.key, required this.ref});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.25),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.8,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(40))),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
              child: FormBuilder(
                key: _formKey4,
                child: // Print the text value write into TextField
                    Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Text(
                      "Exporter PDF sur mesure",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    generateField("tva", "TVA en entier"),
                    SizedBox(
                      height: 10,
                    ),
                    generateField("number", "Numéro du Facture"),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: generateField("dateJ", "jour en chiffre")),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: generateField("dateM", "mois en chiffre")),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: generateField("dateY", "année en chiffre")),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.08,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: AppButton(
                                height: 70,
                                text: "Retourner",
                                onClick: () => Navigator.pop(context))),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: AppButton(
                                height: 70,
                                text: "Générer PDF",
                                onClick: () => submit(context))),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  FormBuilderTextField generateField(String name, String text) {
    return FormBuilderTextField(
      name: name,
      decoration: InputDecoration(
        label: Text(
          text,
          style: const TextStyle(color: Colors.black),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.purple, width: 2.0),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        // ... and so on for other states
      ),
    );
  }

  void submit(BuildContext context) async {
    Map<String, dynamic> values;
    if (_formKey4.currentState == null) {
      return;
    }
    _formKey4.currentState?.saveAndValidate();
    values = _formKey4.currentState!.value;

    Setting setting = ref.read(settingNotifierProvider);
    var tva = int.parse(values["tva"]);
    var factureNumber = int.parse(values["number"]);
    Setting newSetting = Setting(
        name: setting.name,
        lastName: setting.lastName,
        email: setting.email,
        phone1: setting.phone1,
        phone2: setting.phone2,
        fax: setting.fax,
        matricule: setting.matricule,
        tva: tva,
        factureNumber: factureNumber,
        dbDirectory: setting.dbDirectory,
        factureDirectory: setting.factureDirectory,
        adress: setting.adress);

    DateTime fDate = DateTime(int.parse(values["dateY"]),
        int.parse(values["dateM"]), int.parse(values["dateJ"]));

    Navigator.pop(context, [newSetting, fDate]);
  }
}
