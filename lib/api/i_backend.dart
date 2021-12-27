import 'competitor.dart';

abstract class IBackend {
  void createCompetitor(Competitor competitor);

  Competitor getCompetitor(int index);

  int getNumberOfCompetitors();

  Competitor editCompetitor(int id, Competitor competitor);
}
