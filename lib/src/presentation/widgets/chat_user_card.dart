import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kb_chat_module/kb_chat.dart';
import 'package:kb_chat_module/src/api/apis.dart';
import 'package:kb_chat_module/src/models/chat_user_model.dart';
import 'package:kb_chat_module/src/models/message_model.dart';
import 'package:kb_chat_module/src/presentation/screens/chat_screen.dart';
import 'package:kb_chat_module/src/utils/my_date_util.dart';

class ChatUserCard extends StatefulWidget {
  final ChatUserModel user;
  final MessageBox recivesMsgBoxDesign;
  final MessageBox sendMsgBoxDesign;
  const ChatUserCard({
    super.key,
    required this.user,
    required this.recivesMsgBoxDesign,
    required this.sendMsgBoxDesign,
  });

  @override
  State<ChatUserCard> createState() => _ChatUserCardState();
}

class _ChatUserCardState extends State<ChatUserCard> {
  MesssageModel? _message;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ChatScreen(
                user: widget.user,
                recivesMsgBoxDesign: widget.recivesMsgBoxDesign,
                sendMsgBoxDesign: widget.sendMsgBoxDesign,
              ),
            ),
          );
        },
        child: StreamBuilder(
          stream: Apis.getLastMessage(widget.user),
          builder: (context, snapshot) {
            final data = snapshot.data?.docs;
            final list = List.from(data?.map((e) {
                  return MesssageModel.fromMap(e.data());
                }).toList() ??
                []);
            if (list.isNotEmpty) {
              _message = list[0];
            }
            return ListTile(
              leading: CircleAvatar(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: CachedNetworkImage(
                    imageUrl: widget.user.image,
                    placeholder: (context, url) =>
                        const Icon(CupertinoIcons.person),
                    errorWidget: (context, url, error) =>
                        const Icon(CupertinoIcons.person),
                  ),
                ),
              ),
              title: Text(widget.user.name),
              subtitle: Text(_message != null
                  ? _message!.type == MsgType.image
                      ? 'Image'
                      : _message!.msg
                  : widget.user.about),
              trailing: _message == null
                  ? null
                  : _message!.read.isEmpty && _message!.fromId != Apis.user.uid
                      ? Container(
                          width: 15,
                          height: 15,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.greenAccent,
                          ),
                        )
                      : Text(
                          MyDateUtil.getLastMessageTime(
                            context: context,
                            time: _message!.sent,
                          ),
                        ),
            );
          },
        ),
      ),
    );
  }
}
