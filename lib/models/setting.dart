class Setting {
  String name;
  String lastName;
  String email;
  String phone1;
  String phone2;
  String fax;
  String adress;
  String matricule;
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
      required this.fax,
      required this.matricule,
      required this.tva,
      required this.factureNumber,
      required this.dbDirectory,
      required this.factureDirectory,
      required this.adress});

  Setting.empty()
      : this(
            name: "",
            adress: "",
            lastName: "",
            fax: "",
            email: "",
            matricule: "",
            phone1: "",
            phone2: "",
            tva: 19,
            factureDirectory: "",
            dbDirectory: "",
            factureNumber: 1);

  factory Setting.fromJson(Map<String, dynamic> json) {
    return Setting(
      fax: json["fax"] ?? '',
      adress: json["adress"] ?? '',
      matricule: json["matricule"] ?? '',
      name: json['name'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phone1: json['phone1'] ?? '',
      phone2: json['phone2'] ?? '',
      tva: json['tva'] ?? 0,
      factureNumber: json['factureNumber'] ?? 1,
      dbDirectory: json['dbDirectory'] ?? '',
      factureDirectory: json['factureDirectory'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'fax': fax,
      'adress': adress,
      'lastName': lastName,
      'matricule': matricule,
      'email': email,
      'phone1': phone1,
      'phone2': phone2,
      'tva': tva,
      'factureNumber': factureNumber,
      'dbDirectory': dbDirectory,
      'factureDirectory': factureDirectory,
    };
  }

  String getFullName() {
    return "$name $lastName";
  }
}
