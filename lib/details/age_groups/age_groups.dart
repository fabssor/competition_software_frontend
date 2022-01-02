import 'package:competition_software_frontend/api/competitor.dart';
import 'package:competition_software_frontend/api/helper.dart';
import 'package:competition_software_frontend/api/i_backend.dart';
import 'package:competition_software_frontend/details/common/data_table_heading.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class AgeGroups extends StatefulWidget {
  const AgeGroups(this._backend, {Key? key}) : super(key: key);
  final IBackend _backend;

  @override
  State<AgeGroups> createState() => _AgeGroupsState();
}

class _AgeGroupsState extends State<AgeGroups> {
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
              source: YearsData(widget._backend),
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
              source: YearsData(widget._backend),
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
  final IBackend _backend;
  List<Year> _years = <Year>[];

  YearsData(this._backend) {
    var competitors = _backend.getCompetitors();
    _years = sortAgeGroups(competitors);
  }

  @override
  DataRow? getRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(Text(_years[index].year.toString())),
        DataCell(Text(_years[index].gender.toString3())),
        DataCell(Text(_years[index].competitors.toString())),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount {
    return _years.length;
  }

  @override
  int get selectedRowCount => 0;
}
