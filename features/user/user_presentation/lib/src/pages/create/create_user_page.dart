import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tt_i18n/i18n.dart';
import 'package:user_domain/user_domain.dart';
import 'package:user_presentation/src/pages/widget/select_emoticon.dart';

class CreateUserPage extends HookConsumerWidget {
  const CreateUserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final emoticonSelected = useState<String?>(null);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.createUser),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                autocorrect: false,
                autofocus: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return context.l10n.pleaseEnterName;
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: context.l10n.name),
              ),
              const SizedBox(height: 16),

              SelectEmoticon(
                user: UserEntity(),
                emoticonSelected: emoticonSelected,
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                child: Text(context.l10n.create),
                onPressed: () async => (formKey.currentState?.validate() ?? false) && emoticonSelected.value != null ? await _onAddUser(nameController, ref, context) : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onAddUser(TextEditingController nameController, WidgetRef ref, BuildContext context) async {
    final newUser = UserEntity(name: nameController.text);
    try {
      final isCreated = await ref.read(createUserUseCaseProvider(newUser).future);

      if (!isCreated) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.l10n.nameAlreadyExists)),
          );
        }
      } else {
        ref.invalidate(getAllUsersUseCaseProvider);

        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(context.l10n.userCreatedSuccessfully)),
          );
          context.pop();
        }
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${context.l10n.error} : $e'),
          backgroundColor: Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
