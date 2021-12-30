import 'package:flutter/material.dart';

import 'package:data_table_2/data_table_2.dart';

import 'package:competition_software_frontend/api/i_backend.dart';
import 'package:competition_software_frontend/api/competitor.dart';

import 'package:competition_software_frontend/details/competitors/competitor_dialog.dart';
import 'package:competition_software_frontend/internals/logger.dart';

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
              source: MyData(
                context,
                widget._backend,
                setState,
              ),
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
          if (await competitorDialog(
            context,
            "Teilnehmer hinzufügen",
            widget._backend,
          )) {
            Logger.logSnackbar(context, "Teilnehmer angelegt!");
          }
          setState(() {});
        },
        child: const Icon(Icons.person_add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class MyData extends DataTableSource {
  final BuildContext _context;
  final IBackend _backend;
  final Function _setState;

  MyData(this._context, this._backend, this._setState);

  @override
  DataRow? getRow(int index) {
    Competitor competitor = _backend.getCompetitor(index)!;
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(
          Text(competitor.id.toString()),
        ),
        DataCell(Text(competitor.surename.toString())),
        DataCell(Text(competitor.forename.toString())),
        DataCell(Text(competitor.gender.toString3())),
        DataCell(Text(competitor.birthday.toString2())),
        DataCell(
          Wrap(
            spacing: 0, // space between two icons
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () async {
                  if (await competitorDialog(
                    _context,
                    "Teilnehmer bearbeiten",
                    _backend,
                    competitor.id,
                    competitor.surename,
                    competitor.forename,
                    competitor.gender,
                    competitor.birthday,
                  )) {
                    Logger.logSnackbar(_context, "Teilnehmer bearbeitet!");
                    _setState(() {});
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  _backend.removeCompetitor(competitor.id!);
                  Logger.logSnackbar(_context, "Teilnehmer entfernt!");
                  _setState(() {});
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _backend.getNumberOfCompetitors();

  @override
  int get selectedRowCount => 100;
}
