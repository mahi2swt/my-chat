import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kb_chat_module/kb_chat.dart';
import 'package:kb_chat_module/src/models/message_model.dart';
import 'package:kb_chat_module/src/presentation/widgets/full_view_image.dart';
import 'package:kb_chat_module/src/utils/my_date_util.dart';
import 'package:kb_chat_module/src/utils/utility.dart';

class SendMsgCard extends StatelessWidget {
  final MessageBox sendMsgBoxDesign;
  final MesssageModel message;

  const SendMsgCard({
    super.key,
    required this.message,
    required this.sendMsgBoxDesign,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: sendMsgBoxDesign.outerPadding ??
          EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.3,
            bottom: 20,
          ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              padding: message.type == MsgType.text
                  ? const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
                  : const EdgeInsets.all(5),
              decoration: sendMsgBoxDesign.messageBoxStyle ??
                  const BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                  ),
              child: message.type == MsgType.text
                  ? Text(
                      message.msg,
                      style: sendMsgBoxDesign.textStyle ??
                          const TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                    )
                  : GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FullImageScreen(
                              imageUrl: message.msg,
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag: message.msg,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomLeft: Radius.circular(15),
                          ),
                          child: Utility.chacheImage(message.msg),
                        ),
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                MyDateUtil.getFormattedTime(
                  context: context,
                  time: message.sent,
                ),
                style: sendMsgBoxDesign.dateTimeTextStyle ??
                    const TextStyle(fontSize: 13),
              ),
              const SizedBox(width: 10),
              Icon(
                message.read.isNotEmpty
                    ? CupertinoIcons.checkmark_alt_circle_fill
                    : CupertinoIcons.checkmark_alt,
                color: message.read.isNotEmpty ? Colors.green : Colors.grey,
                size: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
