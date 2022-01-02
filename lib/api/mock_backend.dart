import 'package:competition_software_frontend/api/competitor.dart';

import 'package:competition_software_frontend/api/i_backend.dart';
import 'package:competition_software_frontend/internals/logger.dart';

List<Competitor> competitors = <Competitor>[
  Competitor.withId(0, "Max", "Mustermann", Gender.male, DateTime(1992, 6, 23)),
  Competitor.withId(1, "Emily", "Müller", Gender.female, DateTime(1990, 3, 12)),
  Competitor.withId(2, "Martin", "Bauer", Gender.male, DateTime(2010, 12, 12)),
  Competitor.withId(
      3, "Martina", "Bauer", Gender.female, DateTime(2005, 12, 24)),
  Competitor.withId(4, "Markus", "Roth", Gender.male, DateTime(2000, 5, 23)),
  Competitor.withId(5, "Jan-Torsten", "Rum", Gender.male, DateTime(1999, 6, 8)),
  Competitor.withId(6, "Star", "Maier", Gender.female, DateTime(1999, 6, 29)),
  Competitor.withId(7, "Emil", "Bäcker", Gender.male, DateTime(2009, 1, 1)),
  Competitor.withId(8, "Karmen", "Bäcker", Gender.female, DateTime(2010, 1, 3)),
];
int nextId = competitors.length;

class MockBackend implements IBackend {
  @override
  Competitor? createCompetitor(Competitor competitor) {
    competitor.id = nextId;
    nextId++;
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
  void createNewCompetition() {
    Logger.log("Creating new Competition.");
  }
}
