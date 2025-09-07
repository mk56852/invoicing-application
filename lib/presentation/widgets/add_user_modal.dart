import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:management_app/models/user.dart';
import 'package:management_app/presentation/providers/user_data_provider.dart';
import 'package:management_app/presentation/widgets/app_button.dart';
import 'package:management_app/repositories/user_repository.dart';
import 'package:management_app/repositories/user_repository_impl.dart';

final _formKey = GlobalKey<FormBuilderState>();

class AddUserModal extends StatelessWidget {
  final WidgetRef ref;
  const AddUserModal({super.key, required this.ref});

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
                key: _formKey,
                child: // Print the text value write into TextField
                    Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Text(
                      "Ajouter Propriétaire",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    generateField("name", "Nom du propriétaire"),
                    SizedBox(
                      height: 10,
                    ),
                    generateField("ref", "Ref CFE"),
                    SizedBox(
                      height: 10,
                    ),
                    generateField("title", "Titre Foncier"),
                    SizedBox(
                      height: 10,
                    ),
                    generateField("price", "Montant HT"),
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
                                text: "Ajouter Propriétaire",
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
    if (_formKey.currentState == null) {
      return;
    }
    _formKey.currentState?.saveAndValidate();
    values = _formKey.currentState!.value;
    await ref.read(userNotifierProvider.notifier).addUser(User(
        id: 0,
        name: values["name"] as String,
        ref: values["ref"] as String,
        title: values["title"] as String,
        price: double.parse(values["price"])));
    Navigator.pop(context);
  }
}
