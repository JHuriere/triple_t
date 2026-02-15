// create user page
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:triple_t/domain/model/user/user_model.dart';
import 'package:triple_t/domain/use_case/user/create_user_use_case.dart';
import 'package:triple_t/domain/use_case/user/get_all_users_use_case.dart';
import 'package:triple_t/presentation/pages/user_list/widget/select_emoticon.dart';

class CreateUserPage extends HookConsumerWidget {
  const CreateUserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();

    final nameController = TextEditingController();
    final emoticonSelected = useState<String?>(null);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create user'),
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
                    return 'Please enter a name';
                  }
                  return null;
                },
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(height: 16),

              SelectEmoticon(
                user: UserModel(),
                emoticonSelected: emoticonSelected,
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                child: const Text('Create'),
                onPressed: () async => (formKey.currentState?.validate() ?? false) && emoticonSelected.value != null ? await _onAddUser(nameController, ref, context) : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onAddUser(TextEditingController nameController, WidgetRef ref, BuildContext context) async {
    final newUser = UserModel(name: nameController.text);
    final isCreated = await ref.read(createUserUseCaseProvider(newUser).future);

    if (!isCreated) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Name already exists, please choose another one')),
        );
      }
    } else {
      ref.invalidate(getAllUsersUseCaseProvider);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('User created successfully')),
        );
        context.pop();
      }
    }
  }
}
