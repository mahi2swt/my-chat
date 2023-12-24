import 'package:flutter/material.dart';
import 'package:kb_chat_module/kb_chat.dart';
import 'package:kb_chat_module/src/api/apis.dart';
import 'package:kb_chat_module/src/models/message_model.dart';
import 'package:kb_chat_module/src/presentation/widgets/full_view_image.dart';
import 'package:kb_chat_module/src/utils/my_date_util.dart';
import 'package:kb_chat_module/src/utils/utility.dart';

class RecivedMsgCard extends StatelessWidget {
  final MessageBox recivesMsgBoxDesign;
  final MesssageModel message;

  const RecivedMsgCard({
    super.key,
    required this.message,
    required this.recivesMsgBoxDesign,
  });

  @override
  Widget build(BuildContext context) {
    if (message.read.isEmpty) {
      Apis.updateMessageReadStatus(message);
    }
    return Padding(
      padding: recivesMsgBoxDesign.outerPadding ??
          EdgeInsets.only(
            right: MediaQuery.of(context).size.width * 0.3,
            bottom: 20,
          ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Container(
              padding: message.type == MsgType.text
                  ? const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
                  : const EdgeInsets.all(5),
              decoration: recivesMsgBoxDesign.messageBoxStyle ??
                  BoxDecoration(
                    color: Colors.grey.shade700,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
              child: message.type == MsgType.text
                  ? Text(
                      message.msg,
                      style: recivesMsgBoxDesign.textStyle ??
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
                            bottomRight: Radius.circular(15),
                          ),
                          child: Utility.chacheImage(message.msg),
                        ),
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                MyDateUtil.getFormattedTime(
                  context: context,
                  time: message.sent,
                ),
                style: recivesMsgBoxDesign.dateTimeTextStyle ??
                    const TextStyle(fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
