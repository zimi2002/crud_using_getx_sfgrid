import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sfgrid/Model_class.dart';
import 'package:sfgrid/app/modules/home/views/DialogBox.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../controllers/home_controller.dart';

class SFGrid extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Column(
          children: [
            // Optional: Add a header or other widgets if needed.
            Expanded(
              child: SfDataGridTheme(
                data: SfDataGridThemeData(
                  gridLineColor: Colors.white,
                  gridLineStrokeWidth: 2.0,
                  headerColor: Colors.green,
                  headerHoverColor: Colors.yellow,
                ),
                child: SfDataGrid(
                  source: UserDataSource(
                    controller.list_users,
                    controller,
                  ),
                  columnWidthMode: ColumnWidthMode.fill,
                  columns: [
                    GridColumn(
                      columnName: 'ID',
                      label: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'ID',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'Name',
                      label: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'Age',
                      label: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Age',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'Mark',
                      label: GestureDetector(
                        onTap: () {
                          controller.sortByMarks();
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'Mark',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.arrow_upward, size: 16),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GridColumn(
                      columnName: 'Address',
                      label: Container(
                        alignment: Alignment.center,
                        child: const Text(
                          'Address',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                  gridLinesVisibility: GridLinesVisibility.both,
                  headerGridLinesVisibility: GridLinesVisibility.both,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class UserDataSource extends DataGridSource {
  UserDataSource(
    this.users,
    this.controller,
  ) {
    _dataGridRows = users
        .map<DataGridRow>(
          (user) => DataGridRow(
            cells: [
              DataGridCell<int>(columnName: 'ID', value: user.id),
              DataGridCell<String>(columnName: 'Name', value: user.name),
              DataGridCell<int>(columnName: 'Age', value: user.age),
              DataGridCell<double>(columnName: 'Mark', value: user.mark),
              DataGridCell<String>(columnName: 'Address', value: user.address),
            ],
          ),
        )
        .toList();
  }

  final List<ListUser> users;
  final HomeController controller;
  late List<DataGridRow> _dataGridRows;

  @override
  List<DataGridRow> get rows => _dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    TextStyle? getTextStyle(dynamic dataGridCell) {
      if (dataGridCell.columnName == 'Name') {
        return const TextStyle(color: Colors.pinkAccent);
      } else {
        return null;
      }
    }

    ;

    return DataGridRowAdapter(
      color: Colors.green[50],
      cells: row.getCells().map<Widget>((dataGridCell) {
        if (dataGridCell.columnName == 'Address') {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 75),
                    child: Text(
                      dataGridCell.value.toString(),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    final int id = row
                        .getCells()
                        .firstWhere((cell) => cell.columnName == 'ID')
                        .value as int;
                    controller.deleteUserById(id);
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.lightBlueAccent),
                  onPressed: () {
                    final int id = row
                        .getCells()
                        .firstWhere((cell) => cell.columnName == 'ID')
                        .value as int;

                    // Find the user by ID
                    final ListUser? userToEdit = controller.list_users
                        .firstWhereOrNull((user) => user.id == id);

                    if (userToEdit != null) {
                      // Set up the controller for editing
                      controller.setupControllers(user: userToEdit);

                      // Open the dialog using a valid context
                      Get.dialog(
                          DialogBox()); // Using Get.dialog for valid context
                    }
                  },
                ),
              ],
            ),
          );
        } else {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8.0),
            child: Text(
              dataGridCell.value.toString(),
              style: getTextStyle(dataGridCell),
            ),
          );
        }
      }).toList(),
    );
  }
}
