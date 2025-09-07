import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:management_app/models/user.dart';
import 'package:management_app/presentation/providers/user_data_provider.dart';
import 'package:management_app/presentation/widgets/app_button.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class UserTable extends ConsumerStatefulWidget {
  UserTable({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserTableState();
}

class _UserTableState extends ConsumerState<UserTable> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () async => await ref.read(userNotifierProvider.notifier).fetchData());
  }

  @override
  Widget build(BuildContext context) {
    List<User> users = ref.watch(userNotifierProvider);
    UserDataSource dataSource = UserDataSource(
      rowsData: generateGridRows(users),
      deleteFunction: (userId) async => await PanaraConfirmDialog.show(
        context,
        title: "Supprimer données",
        message: "Confirmez-vous la suppression de cet utilisateur",
        cancelButtonText: "Retourner",
        confirmButtonText: "Confirmer",
        onTapConfirm: () {
          ref.read(userNotifierProvider.notifier).deleteUser(userId);
          Navigator.pop(context);
        },
        onTapCancel: () => Navigator.pop(context),
        panaraDialogType: PanaraDialogType.custom,
        color: Colors.black,
        barrierDismissible: false,
      ),
    );
    return users.isEmpty
        ? Text("No Data Found")
        : SfDataGridTheme(
            data: SfDataGridThemeData(
                sortIconColor: Colors.white, headerColor: Colors.black),
            child: SfDataGrid(
                allowSorting: true,
                columnWidthMode: ColumnWidthMode.fill,
                source: dataSource,
                columns: [
                  generateColumn("id", "ID"),
                  generateColumn("name", "Nom du Propriétaire"),
                  generateColumn("ref", "Ref.CFE"),
                  generateColumn("title", "Titre Foncier"),
                  generateColumn("price", "Montant HT"),
                  generateColumn("action", "Action")
                ]),
          );
  }

  List<DataGridRow> generateGridRows(List<User> users) {
    return users
        .map((item) => DataGridRow(cells: [
              DataGridCell(columnName: "id", value: item.id),
              DataGridCell(columnName: "name", value: item.name),
              DataGridCell(columnName: "ref", value: item.ref),
              DataGridCell(columnName: "title", value: item.title),
              DataGridCell(columnName: "price", value: item.price),
              DataGridCell(columnName: "action", value: item.id)
            ]))
        .toList();
  }

  GridColumn generateColumn(String columnName, String columnTitle) {
    return GridColumn(
        columnName: columnName,
        label: Container(
          color: Colors.black,
          child: Center(
            child: Text(
              columnTitle,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ));
  }
}

class UserDataSource extends DataGridSource {
  List<DataGridRow> rowsData;
  Function deleteFunction;

  UserDataSource({
    required this.rowsData,
    required this.deleteFunction,
  });
  @override
  List<DataGridRow> get rows => rowsData;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map((var item) {
      if (item.columnName == "action") {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            AppIconButton(
              icon: Icons.delete_forever_outlined,
              color: Colors.redAccent,
              onClick: () => deleteFunction(item.value as int),
            ),
          ],
        );
      } else {
        return Center(
          child: Text(item.value.toString()),
        );
      }
    }).toList());
  }
}
