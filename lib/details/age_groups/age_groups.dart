import 'package:competition_software_frontend/details/common/data_table_heading.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class AgeGroups extends StatelessWidget {
  const AgeGroups({Key? key}) : super(key: key);

  static const double _spaceToButton = 60.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: PaginatedDataTable2(
              smRatio: 0.4,
              lmRatio: 1.5,
              columns: [
                DataTableHeading(
                  heading: 'Jahrgang',
                  size: ColumnSize.M,
                ),
                DataTableHeading(
                  heading: 'Geschlecht',
                  size: ColumnSize.M,
                ),
                DataTableHeading(
                  heading: 'Anzahl Teilnehmer',
                  size: ColumnSize.L,
                ),
              ],
              source: YearsData(),
              showFirstLastButtons: true,
              fit: FlexFit.tight,
              autoRowsToHeight: true,
            ),
          ),
          Expanded(
            flex: 4,
            child: PaginatedDataTable2(
              smRatio: 0.4,
              lmRatio: 1.5,
              columns: [
                DataTableHeading(
                  heading: 'Jahrgang',
                  size: ColumnSize.M,
                ),
                DataTableHeading(
                  heading: 'Geschlecht',
                  size: ColumnSize.M,
                ),
                DataTableHeading(
                  heading: 'Anzahl Teilnehmer',
                  size: ColumnSize.L,
                ),
              ],
              source: YearsData(),
              showFirstLastButtons: true,
              fit: FlexFit.tight,
              autoRowsToHeight: true,
            ),
          ),
          const SizedBox(height: 60),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.group_add),
        backgroundColor: Colors.blue,
        onPressed: () async {},
      ),
    );
  }
}

class YearsData extends DataTableSource {
  YearsData();

  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(
          Text("1992"),
        ),
        DataCell(Text("männlich")),
        DataCell(Text("5")),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 1;

  @override
  int get selectedRowCount => 0;
}
