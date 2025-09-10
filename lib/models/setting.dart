class Setting {
  String name;
  String lastName;
  String email;
  String phone1;
  String phone2;
  int tva;
  int factureNumber;
  String dbDirectory;
  String factureDirectory;

  Setting(
      {required this.name,
      required this.lastName,
      required this.email,
      required this.phone1,
      required this.phone2,
      required this.tva,
      required this.factureDirectory,
      required this.dbDirectory,
      required this.factureNumber});
}
