import 'package:flutter/material.dart';

import 'data/data.dart';
import 'domain/domain.dart';
import 'presentation/app.dart';

void main() {
  _setupDi();
  runApp(const App());
}

void _setupDi() {
  setupDataDi();
  setupDomainDi();
}
