import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class User {
  int id;
  String name;
  String ref;
  String title;
  double price;

  User(
      {required this.id,
      required this.name,
      required this.ref,
      required this.title,
      required this.price});

  factory User.fromDataGridRow(DataGridRow row) {
    Map<String, dynamic> values = {};

    for (var cell in row.getCells()) {
      values[cell.columnName] = cell.value;
    }

    return User(
      id: values['id'] as int,
      name: values['name'] as String,
      ref: values['ref'] as String,
      title: values['title'] as String,
      price: values['price'] as double,
    );
  }

  void updateField(String fieldName, dynamic newValue) {
    switch (fieldName) {
      case "name":
        this.name = newValue as String;
        break;
      case "ref":
        this.ref = newValue as String;
        break;
      case "title":
        this.title = newValue as String;
        break;
      case "price":
        this.price = newValue as double;
        break;
      default:
        return;
    }
  }

  @override
  String toString() {
    return "USer : $id,$name,$title,$ref,$price";
  }
}
