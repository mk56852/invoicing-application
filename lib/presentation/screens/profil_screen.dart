import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:management_app/presentation/widgets/app_button.dart';
import 'package:management_app/presentation/widgets/screen_title.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey2 = GlobalKey<FormBuilderState>();

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

                  FormBuilderTextField(
                    name: 'name',
                    decoration: const InputDecoration(
                      labelText: 'Nom',
                      hintText: 'Jonah',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  FormBuilderTextField(
                    name: 'lastName',
                    decoration: const InputDecoration(
                      labelText: 'Prénom',
                      hintText: 'Hobbs',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  FormBuilderTextField(
                    name: 'email',
                    decoration: const InputDecoration(
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
                            labelText: 'Numéro du télépohone',
                            hintText: '',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: FormBuilderTextField(
                          name: 'phone2',
                          decoration: const InputDecoration(
                            labelText: 'Deuxiéme Numéro du télépohone',
                            hintText: '',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
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

                  FormBuilderTextField(
                    name: 'tva',
                    decoration: const InputDecoration(
                      labelText: "Taux du TVA",
                      hintText: 'TVA',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  FormBuilderTextField(
                    name: 'db',
                    decoration: const InputDecoration(
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
                      onClick: print,
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
