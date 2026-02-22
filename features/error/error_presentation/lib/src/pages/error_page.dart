import 'package:error_presentation/src/router/router.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tt_i18n/i18n.dart';

class ErrorPage extends ConsumerWidget {
  final String? error;

  const ErrorPage({
    super.key,
    this.error,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.error)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            Text(
              context.l10n.pageNotFound,
              style: const TextStyle(fontSize: 24, fontWeight: .bold),
            ),
            if (error != null) ...[
              const SizedBox(height: 10),
              Padding(
                padding: const .symmetric(horizontal: 16),
                child: Text(
                  error!,
                  textAlign: .center,
                  style: const TextStyle(color: Colors.grey),
                ),
              ),
            ],
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => ref.read(getErrorNavigatorProvider).goHome(context),
              child: Text(context.l10n.homePage),
            ),
          ],
        ),
      ),
    );
  }
}
