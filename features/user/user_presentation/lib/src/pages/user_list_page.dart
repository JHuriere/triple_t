import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tt_i18n/i18n.dart';
import 'package:user_domain/user_domain.dart';
import 'package:user_presentation/src/pages/widget/user_tile.dart';

class UserListPage extends HookConsumerWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(getAllUsersUseCaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.usersList),
      ),
      body: users.isEmpty
          ? Center(child: Text(context.l10n.noUserFound))
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) => UserTile(user: users[index]),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _goAddUser(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _goAddUser(BuildContext context) {
    context.pushNamed('add-user');
  }
}
