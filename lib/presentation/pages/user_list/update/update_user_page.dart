// update user page

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:triple_t/domain/helper/user_helper.dart';
import 'package:triple_t/domain/model/user/user_model.dart';
import 'package:triple_t/domain/use_case/user/delete_user_use_case.dart';
import 'package:triple_t/domain/use_case/user/get_all_users_use_case.dart';
import 'package:triple_t/domain/use_case/user/get_user_by_id_use_case.dart';
import 'package:triple_t/domain/use_case/user/update_user_use_case.dart';
import 'package:triple_t/presentation/pages/user_list/widget/select_emoticon.dart';

class UpdateUserPage extends HookConsumerWidget {
  final int userId;

  const UpdateUserPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(getUserByIdUseCaseProvider(userId));

    final emoticonSelected = useState<String?>(user?.emoticon);
    final nameController = TextEditingController.fromValue(
      TextEditingValue(
        text: user?.name ?? '',
        selection: TextSelection.fromPosition(TextPosition(offset: user?.name.length ?? 0)),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update user'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: user == null
            ? Text('User not found')
            : Column(
                crossAxisAlignment: .stretch,
                children: [
                  TextField(
                    controller: nameController,
                    autofocus: true,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  const SizedBox(height: 16),

                  SelectEmoticon(
                    user: user,
                    emoticonSelected: emoticonSelected,
                  ),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () => _updateUser(context, ref, user, nameController.text, emoticonSelected.value),
                    child: const Text('Update'),
                  ),
                  if (UserHelper.canRemoveUser(user.id)) ...[
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => _deleteUser(context, ref, user.id),
                      style: ButtonStyle(backgroundColor: .all(Colors.redAccent)),
                      child: const Text('Delete', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                  const SizedBox(height: 20),
                ],
              ),
      ),
    );
  }

  void _updateUser(BuildContext context, WidgetRef ref, UserModel user, String newName, String? emoticon) async {
    final updatedUser = user.copyWith(name: newName, emoticon: emoticon ?? user.emoticon);
    final success = await ref.read(updateUserUseCaseProvider(user: updatedUser).future);
    ref.invalidate(getAllUsersUseCaseProvider);

    if (!context.mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User updated successfully')));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Name already exists')));
    }
  }

  Future<void> _deleteUser(BuildContext context, WidgetRef ref, int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm deletion'),
        content: const Text('Are you sure you want to delete this user?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('Ok')),
        ],
      ),
    );

    if (confirm != true) return;

    await ref.read(deleteUserUseCaseProvider(id).future);
    ref.invalidate(getAllUsersUseCaseProvider);

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User deleted successfully')));
    context.pop();
  }
}
