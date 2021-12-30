import 'competitor.dart';

abstract class IBackend {
  /// Creates a [competitor] in the backend. If successfull will
  /// return the created [competitor]. If not will return [null].
  /// The returned competitor will have the assigned id.
  Competitor? createCompetitor(Competitor competitor);

  /// Get a competitor by [index] in the list. The [index] will not corresponed
  /// to the id of the competitor.
  Competitor? getCompetitor(int index);

  /// Returns the total number of competitors.
  int getNumberOfCompetitors();

  /// Edit a [competitor]. The backend will search for the [competitor] by using the
  /// supplied id. Will return the modified competitor on success or [null] on an error.
  Competitor? editCompetitor(Competitor competitor);

  /// Remove/ Delete a competitor by its id. On success will return the removed
  /// competitor else [null].
  Competitor? removeCompetitor(int id);

  /// Returns a List of all competitors.
  List<Competitor> getCompetitors();
}
