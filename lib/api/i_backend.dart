import 'competitor.dart';

abstract class IBackend {
  Competitor createCompetitor(Competitor competitor);

  Competitor getCompetitor(int index);

  int getNumberOfCompetitors();

  Competitor editCompetitor(int id, Competitor competitor);

  Competitor removeCompetitor(int id);
}
