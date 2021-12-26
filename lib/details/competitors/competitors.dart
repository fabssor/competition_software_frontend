import 'package:flutter/material.dart';

import 'package:data_table_2/data_table_2.dart';

import 'package:competition_software_frontend/api/i_backend.dart';
import 'package:competition_software_frontend/api/competitor.dart';

import 'package:competition_software_frontend/details/competitors/competitor_dialog.dart';

const _spaceBetweenColumnItems = 10.0;

class Competitors extends StatefulWidget {
  const Competitors(this._backend, {Key? key}) : super(key: key);
  final IBackend _backend;

  @override
  State<Competitors> createState() => _CompetitorsState();
}

class _CompetitorsState extends State<Competitors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PaginatedDataTable2(
              smRatio: 0.4,
              lmRatio: 0.99,
              columns: const [
                DataColumn2(
                  label: Text(
                    'ID',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  size: ColumnSize.S,
                ),
                DataColumn2(
                  label: Text('Name'),
                  size: ColumnSize.L,
                ),
                DataColumn2(
                  label: Text('Vorname'),
                  size: ColumnSize.L,
                ),
                DataColumn2(
                  label: Text('Geschlecht'),
                  size: ColumnSize.L,
                ),
                DataColumn2(
                  label: Text('Geburtsdatum'),
                  size: ColumnSize.L,
                ),
                DataColumn2(
                  label: Text(''),
                  size: ColumnSize.M,
                )
              ],
              source: MyData(context),
              showFirstLastButtons: true,
              fit: FlexFit.tight,
              autoRowsToHeight: true,
            ),
          ),
          const SizedBox(
            height: 60,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await competitorDialog(
            context,
            "Teilnehmer hinzufügen",
            _spaceBetweenColumnItems,
            widget._backend,
          );
        },
        child: const Icon(Icons.person_add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

DataRow setDummyEntry(
  BuildContext context,
) {
  return DataRow(
    cells: [
      const DataCell(
        Text('0'),
      ),
      const DataCell(Text('Sorkalla')),
      const DataCell(Text('Fabian')),
      const DataCell(Text('männlich')),
      const DataCell(Text('04.01.1995')),
      DataCell(
        Wrap(
          spacing: 0, // space between two icons
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () async {
                // await addCompetitorDialog(
                //   context,
                //   "Teilnehmer bearbeiten",
                //   _spaceBetweenColumnItems,
                //   _controller,
                //   widget._backend,
                // );
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {},
            ),
          ],
        ),
      ),
    ],
  );
}

class MyData extends DataTableSource {
  final BuildContext _context;

  MyData(this._context);

  @override
  DataRow? getRow(int index) {
    return setDummyEntry(_context);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => 100;

  @override
  int get selectedRowCount => 100;
}
