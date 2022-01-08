import 'package:intl/intl.dart';

enum Gender { male, female }

extension ParseToString on Gender {
  String toString2() {
    return toString().split('.').last;
  }

  String toString3() {
    return (this == Gender.male) ? "männlich" : "weiblich";
  }
}

extension ParseToString2 on DateTime {
  String toString2() {
    final DateFormat formatter = DateFormat('dd.MM.yyyy');
    return formatter.format(this);
  }
}

class Competitor {
  int? id;
  final String _forename;
  final String _surename;
  final Gender _gender;
  final DateTime _birthday;

  String get forename => _forename;
  String get surename => _surename;
  Gender get gender => _gender;
  DateTime get birthday => _birthday;

  Competitor(
    String forename,
    String surename,
    Gender gender,
    DateTime birthday,
  )   : id = null,
        _forename = forename,
        _surename = surename,
        _gender = gender,
        _birthday = birthday;

  Competitor.withId(
    this.id,
    String forename,
    String surename,
    Gender gender,
    DateTime birthday,
  )   : _forename = forename,
        _surename = surename,
        _gender = gender,
        _birthday = birthday;

  Competitor.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        _forename = json['forename'],
        _surename = json['surename'],
        _gender = (json['gender'].toString().compareTo("female") == 0)
            ? Gender.female
            : Gender.male,
        _birthday = DateFormat("dd.MM.yyyy").parse(json['birthday']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "forename": _forename,
        "surename": _surename,
        "gender": _gender.toString2(),
        "birthday": _birthday.toString2(),
      };

  @override
  String toString() {
    return "ID: $id, Forename: $forename, Surename: $surename, Gender: ${gender.toString2()}, Birthday: ${birthday.toString2()}";
  }
}
