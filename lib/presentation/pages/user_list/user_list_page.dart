import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:triple_t/domain/use_case/user/get_all_users_use_case.dart';
import 'package:triple_t/presentation/pages/user_list/widget/user_tile.dart';

class UserListPage extends HookConsumerWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.watch(getAllUsersUseCaseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users list'),
      ),
      body: users.isEmpty
          ? const Center(child: Text('No user found'))
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
