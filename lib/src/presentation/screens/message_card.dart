import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kb_chat_module/kb_chat.dart';

import 'package:kb_chat_module/src/api/apis.dart';
import 'package:kb_chat_module/src/models/message_model.dart';
import 'package:kb_chat_module/src/presentation/widgets/recived_msg_card.dart';
import 'package:kb_chat_module/src/presentation/widgets/send_msg_card.dart';

class MessageCard extends StatefulWidget {
  final MesssageModel message;
  final MessageBox recivesMsgBoxDesign;
  final MessageBox sendMsgBoxDesign;
  const MessageCard({
    Key? key,
    required this.message,
    required this.recivesMsgBoxDesign,
    required this.sendMsgBoxDesign,
  }) : super(key: key);

  @override
  State<MessageCard> createState() => _MessageCardState();
}

class _MessageCardState extends State<MessageCard> {
  @override
  Widget build(BuildContext context) {
    bool isMe = Apis.user.uid == widget.message.fromId;
    return isMe
        ? SendMsgCard(
            message: widget.message,
            sendMsgBoxDesign: widget.sendMsgBoxDesign,
          )
        : RecivedMsgCard(
            message: widget.message,
            recivesMsgBoxDesign: widget.recivesMsgBoxDesign,
          );
  }
}
