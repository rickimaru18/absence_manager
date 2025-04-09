import 'package:flutter/material.dart';

import 'setup/router.dart';
import 'setup/theme.dart';

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Absence Manager',
      theme: theme,
      routerConfig: router,
    );
  }
}
