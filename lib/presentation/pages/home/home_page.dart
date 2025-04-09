import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../widgets/cards/absence_card.dart';
import '../../widgets/forms/absence_filter_form.dart';
import 'view_model/home_page_vm.dart';

export 'view_model/home_page_vm.dart';

part 'widgets/absence_list.dart';
part 'widgets/body.dart';
part 'widgets/filter_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Absence Manager'),
      ),
      body: const _Body(),
    );
  }
}
