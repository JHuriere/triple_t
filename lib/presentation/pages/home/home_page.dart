import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: .symmetric(horizontal: 40),
          child: Center(
            child: Column(
              mainAxisAlignment: .center,
              crossAxisAlignment: .stretch,
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  Theme.of(context).brightness == .light ? 'assets/images/logo.png' : 'assets/images/logo-dark.png',
                  height: kIsWeb ? 200 : null,
                  width: kIsWeb ? 200 : null,
                ),
                const SizedBox(height: 20),

                // Navigation
                ElevatedButton.icon(
                  onPressed: () => context.pushNamed('game'),
                  icon: const Icon(Icons.games),
                  label: const Text('Start game'),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () => context.pushNamed('user-list'),
                  icon: const Icon(Icons.person),
                  label: const Text('User list'),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () => context.pushNamed('global-statistics'),
                  icon: const Icon(Icons.leaderboard),
                  label: const Text('Statistics'),
                ),
                const SizedBox(height: 10),
                ElevatedButton.icon(
                  onPressed: () => context.pushNamed('settings'),
                  icon: const Icon(Icons.settings),
                  label: const Text('Parameters'),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
