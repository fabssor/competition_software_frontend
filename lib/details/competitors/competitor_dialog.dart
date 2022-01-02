import 'package:flutter/material.dart';
import 'package:competition_software_frontend/api/competitor.dart';
import 'package:flutter/services.dart';

const _spaceBetweenColumnItems = 10.0;
Gender _gender = Gender.female;
DateTime _birthday = DateTime.now();
final _formKey = GlobalKey<FormState>();

class CustomTextFormField extends TextFormField {
  CustomTextFormField(
      {Key? key,
      required String labelText,
      TextEditingController? controller,
      bool readOnly = false,
      Widget? suffixIcon,
      Future<void> Function()? onTap,
      List<TextInputFormatter>? inputFormatters})
      : super(
          key: key,
          controller: controller,
          readOnly: readOnly,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: labelText,
            suffixIcon: suffixIcon,
            counterText: ' ',
          ),
          onTap: onTap,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Bitte geben Sie einen Text ein!";
            }
            return null;
          },
          inputFormatters: inputFormatters,
        );
}

class GenderRadioButton extends Expanded {
  GenderRadioButton({
    Key? key,
    required String labelText,
    required Gender value,
    required StateSetter setState,
  }) : super(
          key: key,
          child: RadioListTile<Gender>(
            title: Text(labelText),
            value: value,
            groupValue: _gender,
            onChanged: (Gender? v) {
              setState(() => _gender = v!);
            },
          ),
        );
}

Future<DateTime?> getDate(BuildContext context) async {
  var now = DateTime.now();
  var date = await showDatePicker(
    context: context,
    initialDate: DateTime(
      now.year - 10,
      now.month,
      now.day,
    ),
    firstDate: DateTime(
      now.year - 100,
      now.month,
      now.day,
    ),
    lastDate: DateTime(
      now.year,
      now.month,
      now.day,
    ),
  );
  return date;
}

Future<List<Competitor>?> competitorDialog(
  BuildContext context,
  String dialogTitle, [
  int? id,
  String? surename,
  String? forename,
  Gender? gender,
  DateTime? birthday,
]) async {
  final TextEditingController birthdayController = TextEditingController();
  final TextEditingController forenameController = TextEditingController();
  final TextEditingController surenameController = TextEditingController();
  surename == null
      ? surenameController.text = ""
      : surenameController.text = surename;
  forename == null
      ? forenameController.text = ""
      : forenameController.text = forename;
  if (birthday != null) {
    birthdayController.text = birthday.toString2();
    _birthday = birthday;
  }
  if (gender != null) {
    _gender = gender;
  }
  bool isEdit = ((surename != null) ||
      (forename != null) ||
      (birthday != null) ||
      (gender != null) ||
      (id != null));

  List<Competitor> competitors = <Competitor>[];

  await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog(
            title: Text(dialogTitle),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(height: _spaceBetweenColumnItems),
                  CustomTextFormField(
                    controller: forenameController,
                    labelText: "Vorname",
                  ),
                  CustomTextFormField(
                    controller: surenameController,
                    labelText: "Nachname",
                  ),
                  const SizedBox(height: _spaceBetweenColumnItems),
                  CustomTextFormField(
                    controller: birthdayController,
                    readOnly: true,
                    labelText: "Geburtsdatum",
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        final DateTime? dateTime = await getDate(context);
                        if (dateTime == null) {
                          return;
                        } else {
                          _birthday = dateTime;
                          birthdayController.text =
                              "${dateTime.day}.${dateTime.month}.${dateTime.year}";
                        }
                      },
                    ),
                    onTap: () async {
                      final DateTime? dateTime = await getDate(context);
                      if (dateTime == null) {
                        return;
                      } else {
                        _birthday = dateTime;
                        birthdayController.text =
                            "${dateTime.day}.${dateTime.month}.${dateTime.year}";
                      }
                    },
                  ),
                  const SizedBox(height: _spaceBetweenColumnItems),
                  Row(
                    children: [
                      GenderRadioButton(
                        labelText: "männlich",
                        value: Gender.male,
                        setState: setState,
                      ),
                      GenderRadioButton(
                        labelText: "weiblich",
                        value: Gender.female,
                        setState: setState,
                      )
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  if (competitors.isEmpty) {
                    Navigator.of(context).pop(null);
                  } else {
                    // If there where some competitors already created do not
                    // dismiss them...
                    Navigator.of(context).pop(competitors);
                  }
                },
                child: const Text("Abbrechen"),
              ),
              if (isEdit)
                TextButton(
                  onPressed: () {
                    competitors.add(Competitor.withId(
                      id,
                      forenameController.text,
                      surenameController.text,
                      _gender,
                      _birthday,
                    ));
                    Navigator.of(context).pop(competitors);
                  },
                  child: const Text('Bestätigen'),
                )
              else ...[
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      competitors.add(Competitor(
                        forenameController.text,
                        surenameController.text,
                        _gender,
                        _birthday,
                      ));
                    }
                  },
                  child: const Text("Hinzufügen & Neu"),
                ),
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      competitors.add(Competitor(
                        forenameController.text,
                        surenameController.text,
                        _gender,
                        _birthday,
                      ));
                      Navigator.of(context).pop(competitors);
                    }
                  },
                  child: const Text("Hinzufügen"),
                )
              ]
            ],
          );
        });
      });
  return competitors;
}
