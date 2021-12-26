import 'package:competition_software_frontend/api/competitor.dart';

import 'package:competition_software_frontend/api/i_backend.dart';
import 'package:competition_software_frontend/internals/logger.dart';
import 'package:flutter/material.dart';

List<Competitor> competitors = <Competitor>[];
int nextId = 0;

class MockBackend implements IBackend {
  @override
  void createCompetitor(Competitor competitor) {
    competitor.id = nextId;
    nextId++;
    competitors.add(competitor);
    Logger.log("Creating Competitor - " + competitor.toString());
  }

  @override
  Competitor getCompetitor(int id) {
    // TODO: implement getCompetitor
    throw UnimplementedError();
  }

  @override
  int getNumberOfCompetitors() {
    return competitors.length;
  }
}
