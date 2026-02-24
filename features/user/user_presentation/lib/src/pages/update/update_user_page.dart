import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tt_i18n/i18n.dart';
import 'package:user_domain/user_domain.dart';
import 'package:user_presentation/src/pages/widget/select_emoticon.dart';

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
        title: Text(context.l10n.updateUser),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: user == null
            ? Text(context.l10n.userNotFound)
            : Column(
                crossAxisAlignment: .stretch,
                children: [
                  TextField(
                    controller: nameController,
                    autofocus: true,
                    decoration: InputDecoration(labelText: context.l10n.name),
                  ),
                  const SizedBox(height: 16),

                  SelectEmoticon(
                    user: user,
                    emoticonSelected: emoticonSelected,
                  ),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () => _updateUser(context, ref, user, nameController.text, emoticonSelected.value),
                    child: Text(context.l10n.update),
                  ),
                  if (UserHelper.canRemoveUser(user.id)) ...[
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () => _deleteUser(context, ref, user.id),
                      style: ButtonStyle(backgroundColor: .all(Colors.redAccent)),
                      child: Text(context.l10n.delete, style: const TextStyle(color: Colors.white)),
                    ),
                  ],
                  const SizedBox(height: 20),
                ],
              ),
      ),
    );
  }

  void _updateUser(BuildContext context, WidgetRef ref, UserEntity user, String newName, String? emoticon) async {
    final updatedUser = user.copyWith(name: newName, emoticon: emoticon ?? user.emoticon);
    final success = await ref.read(updateUserUseCaseProvider(user: updatedUser).future);
    ref.invalidate(getAllUsersUseCaseProvider);

    if (!context.mounted) return;

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.userUpdatedSuccessfully)));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.nameAlreadyExists)));
    }
  }

  Future<void> _deleteUser(BuildContext context, WidgetRef ref, int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.confirmDeletion),
        content: Text(context.l10n.areYouSureDeleteUser),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: Text(context.l10n.cancel)),
          TextButton(onPressed: () => Navigator.pop(context, true), child: Text(context.l10n.ok)),
        ],
      ),
    );

    if (confirm != true) return;

    await ref.read(deleteUserUseCaseProvider(id).future);
    ref.invalidate(getAllUsersUseCaseProvider);

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.userDeletedSuccessfully)));
    context.pop();
  }
}
