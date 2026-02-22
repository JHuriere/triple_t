import 'package:flutter/material.dart';
import 'package:user_domain/user_domain.dart';

class DropdownPlayer extends StatelessWidget {
  final String label;
  final List<UserModel> users;
  final int? value;
  final List<int> excludedUserIds;
  final Future<void> Function(int playerId) onChanged;
  final bool enabled;

  const DropdownPlayer({
    super.key,
    required this.label,
    required this.users,
    this.value,
    required this.excludedUserIds,
    required this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DropdownButtonFormField<int>(
      isExpanded: true,
      initialValue: value,
      items: users
          .where((user) => !excludedUserIds.contains(user.id))
          .map(
            (user) => DropdownMenuItem<int>(
              value: user.id,
              child: Text(user.name, overflow: TextOverflow.ellipsis),
            ),
          )
          .toList(growable: false),
      onChanged: enabled
          ? (playerId) async {
              if (playerId == null) {
                return;
              }
              await onChanged(playerId);
            }
          : null,
      icon: const Icon(Icons.keyboard_arrow_down),
      dropdownColor: theme.colorScheme.surface,
      borderRadius: const BorderRadius.all(Radius.circular(12)),
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: theme.colorScheme.surfaceContainerHighest,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.colorScheme.outlineVariant),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.colorScheme.outlineVariant),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: theme.colorScheme.primary, width: 1.5),
        ),
      ),
      style: theme.textTheme.bodyMedium,
    );
  }
}
