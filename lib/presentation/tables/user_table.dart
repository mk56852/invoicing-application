import 'package:flutter/material.dart';
import 'package:flutter_debouncer/flutter_debouncer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:management_app/configuration/app_config.dart';
import 'package:management_app/models/user.dart';
import 'package:management_app/presentation/providers/user_data_provider.dart';
import 'package:management_app/presentation/widgets/add_user_modal.dart';
import 'package:management_app/presentation/widgets/app_button.dart';
import 'package:management_app/presentation/widgets/item_selection_counter.dart';
import 'package:management_app/utils/pdf_builder.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:panara_dialogs/panara_dialogs.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

final GlobalKey<SfDataGridState> key = GlobalKey<SfDataGridState>();

class UserTable extends ConsumerStatefulWidget {
  UserTable({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserTableState();
}

class _UserTableState extends ConsumerState<UserTable> {
  PdfBuilder builder = PdfBuilder(gridKey: key);
  final TextEditingController _searchController = TextEditingController();
  final Debouncer _debouncer = Debouncer();
  List<User> _filteredUsers = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    Future.microtask(
        () async => await ref.read(userNotifierProvider.notifier).fetchData());
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _debouncer.debounce(
        duration: Duration(milliseconds: 400),
        onDebounce: () {
          setState(() {});
        });
  }

  @override
  Widget build(BuildContext context) {
    List<User> users = ref.watch(userNotifierProvider);
    final selectedIds = ref.watch(selectedIdsProvider);

    if (_searchController.text.isEmpty) {
      _filteredUsers = users;
    } else {
      final searchLower = _searchController.text.toLowerCase();
      _filteredUsers = users.where((user) {
        return user.name.toLowerCase().contains(searchLower) ||
            user.ref.toLowerCase().contains(searchLower) ||
            user.title.toLowerCase().contains(searchLower) ||
            user.id.toString().contains(searchLower) ||
            user.price.toString().contains(searchLower);
      }).toList();
    }

    UserDataSource dataSource = UserDataSource(
      ref: ref,
      rowsData: generateGridRows(_filteredUsers),
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
        color: SimpleAppColors.blueColor,
        barrierDismissible: false,
      ),
    );

    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: SizedBox(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Rechercher un propriétaire',
                    hintText: 'taper le nom, ref, ...',
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 100,
            ),
            AppOutlinedButton(
              text: "Ajouter propriétaire",
              icon: Icons.person_add,
              onClick: () => showMaterialModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) => AddUserModal(ref: ref)),
              height: 50,
              borderColor: SimpleAppColors.blueColor,
              fontColor: SimpleAppColors.blueColor,
              width: 200,
            ),
            SizedBox(
              width: 5,
            ),
            AppOutlinedButton(
              borderColor: SimpleAppColors.blueColor,
              fontColor: SimpleAppColors.blueColor,
              text: "Exporter pdf",
              icon: Icons.download,
              onClick: () async {
                await builder.build(users, selectedIds);
              },
              height: 50,
              width: 180,
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: _filteredUsers.isEmpty
              ? Center(child: Text('No users found'))
              : SfDataGrid(
                  key: key,
                  allowEditing: true,
                  navigationMode: GridNavigationMode.cell,
                  selectionMode: SelectionMode.single,
                  columnWidthMode: ColumnWidthMode.fill,
                  source: dataSource,
                  columns: [
                    GridColumn(
                      columnName: "select",
                      width: 60,
                      label: Container(
                          color: SimpleAppColors.blueColor,
                          alignment: Alignment.center,
                          child: ItemSelectionCounter()),
                    ),
                    generateColumn("id", "ID", false),
                    generateColumn("name", "Nom du Propriétaire"),
                    generateColumn("ref", "Ref.CFE"),
                    generateColumn("title", "Titre Foncier"),
                    generateColumn("price", "Montant HT"),
                    generateColumn("action", "Action")
                  ],
                ),
        ),
        SfDataPagerTheme(
          data: SfDataPagerThemeData(
            itemColor: Colors.white,
            selectedItemColor: SimpleAppColors.blueColor,
            itemBorderRadius: BorderRadius.circular(5),
            itemBorderWidth: 0.5,
            itemBorderColor: Colors.grey.shade400,
          ),
          child: SfDataPager(
            delegate: dataSource,
            pageCount: _filteredUsers.length > 0
                ? (_filteredUsers.length / 7).ceilToDouble()
                : 1,
            direction: Axis.horizontal,
          ),
        ),
      ],
    );
  }

  List<DataGridRow> generateGridRows(List<User> users) {
    return users
        .map((item) => DataGridRow(cells: [
              DataGridCell(columnName: "select", value: false),
              DataGridCell(
                columnName: "id",
                value: item.id,
              ),
              DataGridCell(columnName: "name", value: item.name),
              DataGridCell(columnName: "ref", value: item.ref),
              DataGridCell(columnName: "title", value: item.title),
              DataGridCell(columnName: "price", value: item.price),
              DataGridCell(columnName: "action", value: item.id)
            ]))
        .toList();
  }

  GridColumn generateColumn(String columnName, String columnTitle,
      [bool editing = true]) {
    bool isEditable = true;
    if (editing != null) {
      isEditable = editing;
    }
    return GridColumn(
        allowEditing: isEditable,
        columnName: columnName,
        label: Container(
          color: SimpleAppColors.blueColor,
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
  WidgetRef ref;
  List<DataGridRow> allRows = [];
  List<DataGridRow> paginatedRows = [];
  Function deleteFunction;

  dynamic newCellValue;
  TextEditingController editingController = TextEditingController();

  UserDataSource(
      {required List<DataGridRow> rowsData,
      required this.deleteFunction,
      required this.ref}) {
    allRows = rowsData;
    paginatedRows = allRows.take(7).toList();
  }

  @override
  List<DataGridRow> get rows => paginatedRows;

  DataGridRowAdapter? buildRow(DataGridRow row) {
    final int id =
        row.getCells().firstWhere((c) => c.columnName == "id").value as int;
    final selectedIds = ref.read(selectedIdsProvider);
    return DataGridRowAdapter(
      cells: row.getCells().map((item) {
        if (item.columnName == "select") {
          return Center(
            child: Checkbox(
              value: selectedIds.contains(id),
              onChanged: (bool? value) {
                final newSelection = Set<int>.from(selectedIds);
                if (value == true) {
                  newSelection.add(id);
                } else {
                  newSelection.remove(id);
                }
                ref.read(selectedIdsProvider.notifier).state = newSelection;
                notifyListeners();
              },
            ),
          );
        } else if (item.columnName == "action") {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppIconButton(
                icon: Icons.delete_forever_outlined,
                color: SimpleAppColors.blueColor,
                onClick: () => deleteFunction(item.value as int),
              ),
            ],
          );
        } else {
          return Center(child: Text(item.value.toString()));
        }
      }).toList(),
    );
  }

  @override
  Future<bool> handlePageChange(int oldPageIndex, int newPageIndex) async {
    _updatePaginatedRows(newPageIndex);
    return true;
  }

  void _updatePaginatedRows(int pageIndex) {
    const int rowsPerPage = 7;
    int startIndex = pageIndex * rowsPerPage;
    int endIndex = startIndex + rowsPerPage;

    if (startIndex < allRows.length) {
      if (endIndex > allRows.length) endIndex = allRows.length;
      paginatedRows = allRows.getRange(startIndex, endIndex).toList();
      notifyListeners();
    }
  }

  @override
  bool onCellBeginEdit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column) {
    if (column.columnName == 'id') {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget? buildEditWidget(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
    // Text going to display on editable widget
    final String displayText = dataGridRow
            .getCells()
            .firstWhere((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            .value
            ?.toString() ??
        '';

    newCellValue = null;

    final bool isNumericType = column.columnName == 'price';

    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: isNumericType ? Alignment.centerRight : Alignment.centerLeft,
      child: TextField(
        autofocus: true,
        controller: editingController..text = displayText,
        textAlign: isNumericType ? TextAlign.right : TextAlign.left,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 16.0),
        ),
        keyboardType: isNumericType ? TextInputType.number : TextInputType.text,
        onChanged: (String value) {
          if (value.isNotEmpty) {
            if (isNumericType) {
              newCellValue = double.parse(value);
            } else {
              newCellValue = value;
            }
          } else {
            newCellValue = null;
          }
        },
        onSubmitted: (String value) {
          submitCell();
        },
      ),
    );
  }

  @override
  Future<void> onCellSubmit(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column) async {
    final dynamic oldValue = dataGridRow
            .getCells()
            .firstWhere((DataGridCell dataGridCell) =>
                dataGridCell.columnName == column.columnName)
            .value ??
        '';

    if (newCellValue == null || oldValue == newCellValue) {
      return;
    }
    User user = User.fromDataGridRow(dataGridRow);
    user.updateField(column.columnName, newCellValue);
    ref.read(userNotifierProvider.notifier).updateUser(user);
    return;
  }
}
