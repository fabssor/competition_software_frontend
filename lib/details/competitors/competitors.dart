import 'package:competition_software_frontend/details/common/data_table_heading.dart';
import 'package:flutter/material.dart';

import 'package:data_table_2/data_table_2.dart';

import 'package:competition_software_frontend/api/i_backend.dart';
import 'package:competition_software_frontend/api/competitor.dart';

import 'package:competition_software_frontend/internals/logger.dart';

import 'package:competition_software_frontend/details/competitors/competitor_dialog.dart';
import 'package:competition_software_frontend/details/common/accept_dialog.dart';

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
              lmRatio: 1.5,
              columns: [
                DataTableHeading(
                  heading: 'ID',
                  size: ColumnSize.S,
                ),
                DataTableHeading(
                  heading: 'Vorname',
                  size: ColumnSize.L,
                ),
                DataTableHeading(
                  heading: 'Nachname',
                  size: ColumnSize.L,
                ),
                DataTableHeading(
                  heading: 'Geschlecht',
                  size: ColumnSize.L,
                ),
                DataTableHeading(
                  heading: 'Geburtsdatum',
                  size: ColumnSize.L,
                ),
                DataTableHeading(
                  heading: '',
                  size: ColumnSize.M,
                )
              ],
              source: CompetitorsData(
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
          List<Competitor>? competitors =
              await competitorDialog(context, "Teilnehmer hinzufügen");

          setState(() {
            if (competitors == null) {
              // do nothing dialog was dismissed with no competitor created
            } else if (competitors.isNotEmpty) {
              if (competitors.length == 1) {
                widget._backend.createCompetitor(competitors[0]);
                Logger.logSnackbar(context, "Teilnehmer angelegt!");
              } else {
                for (Competitor competitor in competitors) {
                  widget._backend.createCompetitor(competitor);
                }
                Logger.logSnackbar(context, "Teilnehmer angelegt!");
              }
            }
          });
        },
        child: const Icon(Icons.person_add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}

class CompetitorsData extends DataTableSource {
  final BuildContext _context;
  final IBackend _backend;
  final Function _setState;

  CompetitorsData(this._context, this._backend, this._setState);

  @override
  DataRow? getRow(int index) {
    Competitor competitor = _backend.getCompetitor(index)!;
    return DataRow.byIndex(
      index: index,
      cells: [
        DataCell(
          Text(competitor.id.toString()),
        ),
        DataCell(Text(competitor.forename.toString())),
        DataCell(Text(competitor.surename.toString())),
        DataCell(Text(competitor.gender.toString3())),
        DataCell(Text(competitor.birthday.toString2())),
        DataCell(
          Wrap(
            spacing: 0, // space between two icons
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () async {
                  List<Competitor>? competitors = await competitorDialog(
                    _context,
                    "Teilnehmer bearbeiten",
                    competitor.id,
                    competitor.surename,
                    competitor.forename,
                    competitor.gender,
                    competitor.birthday,
                  );
                  _setState(() {
                    if (competitors == null) {
                      // do nothing dialog was dismissed with no competitor created
                    } else if (competitors.isNotEmpty) {
                      _backend.editCompetitor(competitors[0]);
                      Logger.logSnackbar(_context, "Teilnehmer bearbeitet!");
                    }
                  });
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () async {
                  if (await acceptDialog(_context, "Teilnehemer löschen",
                      "Soll der Teilnehmer gelöscht werden?")) {
                    _setState(() {
                      _backend.removeCompetitor(competitor.id!);
                      Logger.logSnackbar(_context, "Teilnehmer entfernt!");
                    });
                  }
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
  int get selectedRowCount => 0;
}
