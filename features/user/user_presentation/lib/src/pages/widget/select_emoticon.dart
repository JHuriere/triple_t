import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:user_domain/user_domain.dart';

class SelectEmoticon extends HookConsumerWidget {
  final UserModel user;
  final ValueNotifier<String?> emoticonSelected;

  const SelectEmoticon({
    super.key,
    required this.user,
    required this.emoticonSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AspectRatio(
      aspectRatio: 1,
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 6,
        crossAxisSpacing: 3,
        mainAxisSpacing: 3,
        children: kUserEmoticons
            .map<Widget>((gameEmoticon) {
              final canSelect = _canSelectEmoticon(ref, user, gameEmoticon);

              return InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: canSelect ? () => emoticonSelected.value = gameEmoticon : null,
                child: Container(
                  decoration: BoxDecoration(
                    color: canSelect ? Theme.of(context).colorScheme.primaryContainer : Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: emoticonSelected.value == gameEmoticon ? Theme.of(context).colorScheme.primary : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: Center(child: Text(gameEmoticon, style: const TextStyle(fontSize: 24))),
                ),
              );
            })
            .toList(growable: false),
      ),
    );
  }

  bool _canSelectEmoticon(WidgetRef ref, UserModel currentUser, String? emoticon) {
    final users = ref.read(getAllUsersUseCaseProvider);
    final isEmoticonTaken = users.any((user) => user.emoticon == emoticon && user.id != currentUser.id);

    return emoticon == null || emoticon.isEmpty || !isEmoticonTaken;
  }
}
