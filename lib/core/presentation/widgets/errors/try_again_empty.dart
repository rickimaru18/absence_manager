import 'package:flutter/material.dart';

import '../../../core.dart';

class TryAgainEmpty extends StatelessWidget {
  const TryAgainEmpty({
    required this.onRefresh,
    this.padding = const EdgeInsets.all(Dimens.d16),
    this.message,
    this.refreshText,
    super.key,
  });

  final VoidCallback onRefresh;
  final EdgeInsetsGeometry padding;
  final String? message;
  final String? refreshText;

  @override
  Widget build(BuildContext context) {
    return TryAgainError(
      onTryAgain: onRefresh,
      padding: padding,
      errorMessage: message ?? 'Empty',
      tryAgainText: refreshText ?? 'Refresh',
    );
  }
}
