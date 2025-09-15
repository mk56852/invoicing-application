import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:management_app/configuration/app_config.dart';
import 'package:management_app/models/setting.dart';
import 'package:management_app/presentation/providers/setting_data_provider.dart';
import 'package:management_app/presentation/widgets/app_button.dart';
import 'package:management_app/presentation/widgets/screen_title.dart';
import 'package:panara_dialogs/panara_dialogs.dart';

class ProfilScreen extends ConsumerWidget {
  const ProfilScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _formKey2 = GlobalKey<FormBuilderState>();
    Setting setting = ref.watch(settingNotifierProvider);

    return Column(
      children: [
        ScreenTitle(title: "Gérer les données du profile"),
        SizedBox(
          height: 30,
        ),
        Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade500),
              borderRadius: BorderRadius.circular(16),
            ),
            child: FormBuilder(
              key: _formKey2,
              initialValue: {
                'adress': setting.adress,
                'name': setting.name,
                'lastName': setting.lastName,
                'email': setting.email,
                'phone1': setting.phone1,
                'phone2': setting.phone2,
                "matricule": setting.matricule,
                'tva': setting.tva.toString(),
                'fax': setting.fax,
                'db': setting.dbDirectory,
                'facture': setting.factureDirectory,
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Personal Information Section
                  Row(
                    children: const [
                      Icon(Icons.person_outline, size: 20),
                      SizedBox(width: 6),
                      Text(
                        "Informations personnelles",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Veuillez ajouter vos informations personnelles.",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'name',
                          decoration: const InputDecoration(
                            labelText: 'Nom',
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'lastName',
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person_outline),
                            labelText: 'Prénom',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  FormBuilderTextField(
                    name: 'adress',
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.map),
                      labelText: 'Adresse',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  FormBuilderTextField(
                    name: 'email',
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: 'Email',
                      hintText: 'Example@gmail.com',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'phone1',
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            labelText: 'Numéro du télépohone',
                            hintText: '',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'phone2',
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            labelText: 'Mobile',
                            hintText: '',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'fax',
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            labelText: 'Fax',
                            hintText: '',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Shipping Address Section
                  Row(
                    children: const [
                      Icon(Icons.book_outlined, size: 20),
                      SizedBox(width: 6),
                      Text(
                        "Informations de l'application",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Fournir les informations relatives à l'application",
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'tva',
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.money),
                            labelText: "Taux du TVA",
                            hintText: 'TVA',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'matricule',
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.data_array_rounded),
                            labelText: 'Matricule Fiscale',
                            hintText: '',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  FormBuilderTextField(
                    name: 'db',
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.data_object),
                      labelText: 'Dossier du base de données',
                      hintText: '',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),

                  FormBuilderTextField(
                    name: 'facture',
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.file_copy),
                      labelText: 'Dossier du factures',
                      hintText: '7529 E. Pecan St.',
                      border: OutlineInputBorder(),
                    ),
                  ),

                  SizedBox(
                    height: 25,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: AppButton(
                      text: "Enregistrer Les Modifications",
                      onClick: () async {
                        // Save + validate the form
                        if (_formKey2.currentState?.saveAndValidate() ??
                            false) {
                          // 👇 this contains a map of all field values
                          final formData = _formKey2.currentState!.value;
                          await ref
                              .read(settingNotifierProvider.notifier)
                              .update(
                                Setting(
                                  adress: formData['adress'],
                                  matricule: formData['matricule'],
                                  fax: formData['fax'],
                                  name: formData['name'],
                                  lastName: formData['lastName'],
                                  email: formData['email'],
                                  phone1: formData['phone1'],
                                  phone2: formData['phone2'],
                                  tva:
                                      int.tryParse(formData['tva'] ?? '0') ?? 0,
                                  dbDirectory: formData['db'],
                                  factureDirectory: formData['facture'],
                                  factureNumber: setting.factureNumber,
                                ),
                              );
                          await PanaraInfoDialog.show(context,
                              color: SimpleAppColors.blueColor,
                              panaraDialogType: PanaraDialogType.success,
                              buttonText: "Retourner",
                              message:
                                  "Modication effectuée \n Si vous avez modifier la base de données vous devez restarter l'application.",
                              onTapDismiss: () => Navigator.pop(context));
                        } else {
                          await PanaraInfoDialog.show(context,
                              color: SimpleAppColors.blueColor,
                              panaraDialogType: PanaraDialogType.error,
                              buttonText: "Retourner",
                              message: "Erreur",
                              onTapDismiss: () => Navigator.pop(context));
                        }
                      },
                      height: 50,
                      width: 250,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
