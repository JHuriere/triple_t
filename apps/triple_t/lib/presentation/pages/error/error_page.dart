import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:triple_t_i18n/i18n.dart';

class ErrorPage extends StatelessWidget {
  final String? error;

  const ErrorPage({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.error)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 80, color: Colors.red),
            const SizedBox(height: 20),
            Text(context.l10n.pageNotFound, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            if (error != null) ...[const SizedBox(height: 10), Text(error!, style: const TextStyle(color: Colors.grey))],
            const SizedBox(height: 20),
            ElevatedButton(onPressed: () => context.go('/'), child: Text(context.l10n.homePage)),
          ],
        ),
      ),
    );
  }
}
