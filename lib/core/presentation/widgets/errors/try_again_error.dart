import 'package:flutter/material.dart';

import '../../../core.dart';

class TryAgainError extends StatelessWidget {
  const TryAgainError({
    required this.onTryAgain,
    this.padding = const EdgeInsets.all(Dimens.d16),
    this.error,
    this.errorMessage,
    this.tryAgainText,
    super.key,
  }) : assert(
          error != null || errorMessage != null,
          'At least [error] or [errorMessage] should be set.',
        );

  final VoidCallback onTryAgain;
  final EdgeInsetsGeometry padding;
  final Failure? error;
  final String? errorMessage;
  final String? tryAgainText;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(errorMessage ?? error!.error),
            const SizedBox(height: Dimens.d8),
            TextButton(
              onPressed: onTryAgain,
              child: Text(tryAgainText ?? 'Try again'),
            ),
          ],
        ),
      ),
    );
  }
}
