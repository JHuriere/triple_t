import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:triple_t/domain/model/user/user_model.dart';
import 'package:triple_t_i18n/i18n.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
    required this.user,
  });

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(
          user.emoticon.isNotEmpty
              ? user.emoticon
              : user.name.isNotEmpty
              ? user.name[0]
              : '#',
          style: const TextStyle(fontSize: 24),
        ),
      ),
      title: Text(user.name),
      subtitle: Text(context.l10n.userId(user.id)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            tooltip: context.l10n.statistics,
            onPressed: () => _goToStatistics(context),
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: context.l10n.editUser,
            onPressed: () => _goToUpdateUser(context),
          ),
        ],
      ),
    );
  }

  void _goToUpdateUser(BuildContext context) {
    context.pushNamed('edit-user', pathParameters: {'id': user.id.toString()});
  }

  void _goToStatistics(BuildContext context) {
    context.pushNamed('user-statistics', pathParameters: {'id': user.id.toString()});
  }
}
