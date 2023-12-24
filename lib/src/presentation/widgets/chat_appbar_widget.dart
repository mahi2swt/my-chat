import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kb_chat_module/src/api/apis.dart';
import 'package:kb_chat_module/src/models/chat_user_model.dart';
import 'package:kb_chat_module/src/utils/my_date_util.dart';

class ChatScreenAppbar extends StatelessWidget implements PreferredSizeWidget {
  final ChatUserModel user;
  const ChatScreenAppbar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: InkWell(
          onTap: () {},
          child: StreamBuilder(
            stream: Apis.getUserInfo(user),
            builder: (context, snapshot) {
              final data = snapshot.data?.docs;
              final list = List.from(data?.map((e) {
                    return ChatUserModel.fromMap(e.data());
                  }).toList() ??
                  []);
              return Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      CupertinoIcons.back,
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(1000),
                    child: CachedNetworkImage(
                      width: 40,
                      height: 40,
                      imageUrl: list.isNotEmpty ? list[0].image : user.image,
                      errorWidget: (context, url, error) => const CircleAvatar(
                        child: Icon(CupertinoIcons.person),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //user name
                      Text(
                        list.isNotEmpty ? list[0].name : user.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 2),

                      Text(
                        list.isNotEmpty
                            ? list[0].isOnline
                                ? 'Online'
                                : MyDateUtil.getLastActiveTime(
                                    context: context,
                                    lastActive: list[0].lastActive,
                                  )
                            : user.about,
                        style: const TextStyle(
                          fontSize: 13,
                        ),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
