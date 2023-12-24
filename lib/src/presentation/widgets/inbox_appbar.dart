import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kb_chat_module/src/api/apis.dart';
import 'package:kb_chat_module/src/presentation/screens/profile_screen.dart';

class InboxAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final ValueNotifier<bool> isSearching;
  final VoidCallback onCancel;
  final Function(String) onChanged;
  const InboxAppbarWidget({
    super.key,
    required this.isSearching,
    required this.onCancel,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isSearching,
      builder: (context, value, child) {
        return AppBar(
          title: value
              ? TextField(
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search',
                  ),
                  autofocus: true,
                  style: const TextStyle(fontSize: 17, letterSpacing: 0.5),
                  //when search text changes then updated search list
                  onChanged: onChanged,
                )
              : const Text('Messages'),
          centerTitle: true,
          // leading: const Icon(CupertinoIcons.home),
          actions: [
            IconButton(
              onPressed: onCancel,
              icon: Icon(
                value ? CupertinoIcons.clear_circled_solid : Icons.search,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ProfileScreen(
                        user: Apis.me,
                      );
                    },
                  ),
                );
              },
              icon: const Icon(CupertinoIcons.ellipsis_vertical),
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
