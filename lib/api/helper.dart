import 'package:competition_software_frontend/api/competitor.dart';

/// Some helper functions for the backend...

class Year {
  final int _year;
  final Gender _gender;
  int competitors;

  Year(this._year, this._gender, this.competitors);

  int get year => _year;
  Gender get gender => _gender;
}

List<Year> sortAgeGroups(List<Competitor> competitors) {
  List<Year> years = <Year>[];
  for (var competitor in competitors) {
    int index = years.indexWhere((year) {
      return (competitor.birthday.year == year.year) &&
          (competitor.gender == year.gender);
    });

    // not found
    if (index == -1) {
      years.add(Year(competitor.birthday.year, competitor.gender, 1));
    }
    // year already exists just increase number...
    else {
      years[index].competitors++;
    }
  }

  return years;
}
