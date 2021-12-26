import 'competitor.dart';

abstract class IBackend {
  void createCompetitor(Competitor competitor);

  Competitor getCompetitor(int id);

  int getNumberOfCompetitors();
}
