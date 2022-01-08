import 'dart:convert';
import 'dart:io';

import 'package:competition_software_frontend/api/competitor.dart';

import 'package:competition_software_frontend/api/i_backend.dart';
import 'package:competition_software_frontend/internals/logger.dart';
import 'package:file_picker/file_picker.dart';

// List<Competitor> competitors = <Competitor>[
//   Competitor.withId(0, "Max", "Mustermann", Gender.male, DateTime(1992, 6, 23)),
//   Competitor.withId(1, "Emily", "Müller", Gender.female, DateTime(1990, 3, 12)),
//   Competitor.withId(2, "Martin", "Bauer", Gender.male, DateTime(2010, 12, 12)),
//   Competitor.withId(
//       3, "Martina", "Bauer", Gender.female, DateTime(2005, 12, 24)),
//   Competitor.withId(4, "Markus", "Roth", Gender.male, DateTime(2000, 5, 23)),
//   Competitor.withId(5, "Jan-Torsten", "Rum", Gender.male, DateTime(1999, 6, 8)),
//   Competitor.withId(6, "Star", "Maier", Gender.female, DateTime(1999, 6, 29)),
//   Competitor.withId(7, "Emil", "Bäcker", Gender.male, DateTime(2009, 1, 1)),
//   Competitor.withId(8, "Karmen", "Bäcker", Gender.female, DateTime(2010, 1, 3)),
// ];
// int nextId = competitors.length;

class MockBackend implements IBackend {
  List<Competitor> competitors = <Competitor>[];
  bool _isOpen = false;
  File? _file;

  @override
  Competitor? createCompetitor(Competitor competitor) {
    competitor.id = competitors.length;
    competitors.add(competitor);
    Logger.log("Creating Competitor - " + competitor.toString());
    return competitor;
  }

  @override
  Competitor? getCompetitor(int index) {
    return competitors.elementAt(index);
  }

  @override
  int getNumberOfCompetitors() {
    return competitors.length;
  }

  @override
  Competitor? editCompetitor(Competitor competitor) {
    int index =
        competitors.indexWhere((element) => element.id == competitor.id);
    competitors[index] = competitor;
    Logger.log("Editing Competitor - " + competitors[index].toString());
    return competitors[index];
  }

  @override
  Competitor removeCompetitor(int id) {
    int index = competitors.indexWhere((element) => element.id == id);
    Logger.log("Removing Competitor - " + competitors[index].toString());
    return competitors.removeAt(index);
  }

  @override
  List<Competitor> getCompetitors() {
    return competitors;
  }

  @override
  Future<bool> createNewCompetition() async {
    _isOpen = false;
    String? path = await FilePicker.platform.saveFile(
        dialogTitle: 'Neuen Wettkampf anlegen',
        fileName: 'Wettkampf.wk',
        allowedExtensions: ['.wk']);

    if (path != null) {
      if (File(path).existsSync()) {
        Logger.log("File already exists. New competition not created!");
      } else {
        _file = await File(path).create();
        Logger.log("Created new competiton.");
        _isOpen = true;
      }
    }
    return Future<bool>.value(_isOpen);
  }

  @override
  bool isOpen() {
    return _isOpen;
  }

  @override
  void closeCompetition() {
    Logger.log("Close Competition ${_file?.path}");
    _file = null;
    _isOpen = false;
    competitors.clear();
  }

  @override
  Future<void> saveCompetition({bool createNew = false}) async {
    if (createNew) {
      await createNewCompetition();
    }
    _file?.writeAsStringSync(jsonEncode({"competitors": competitors}));
    Logger.log("Saved Competition.");
  }

  @override
  Future<void> openCompetition() async {
    FilePickerResult? res = await FilePicker.platform.pickFiles(
      dialogTitle: "Wettkampf öffnen",
      allowedExtensions: [".wk"],
      lockParentWindow: true,
    );
    if (res == null) {
      _isOpen = false;
      return;
    }
    _file = File(res.paths[0]!);

    competitors =
        (json.decode(_file!.readAsStringSync())['competitors'] as List)
            .map((data) => Competitor.fromJson(data))
            .toList();

    Logger.log("Competition ${_file?.path} opened.");

    _isOpen = true;
  }
}
