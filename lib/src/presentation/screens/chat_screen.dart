import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kb_chat_module/kb_chat.dart';
import 'package:kb_chat_module/src/api/apis.dart';
import 'package:kb_chat_module/src/controller/inbox_provider.dart';
import 'package:kb_chat_module/src/models/chat_user_model.dart';
import 'package:kb_chat_module/src/models/message_model.dart';
import 'package:kb_chat_module/src/presentation/screens/message_card.dart';
import 'package:kb_chat_module/src/presentation/widgets/chat_appbar_widget.dart';
import 'package:kb_chat_module/src/presentation/widgets/chat_input_widget.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  final ChatUserModel user;
  final MessageBox recivesMsgBoxDesign;
  final MessageBox sendMsgBoxDesign;
  const ChatScreen({
    super.key,
    required this.user,
    required this.recivesMsgBoxDesign,
    required this.sendMsgBoxDesign,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late InboxProvider _provider;
  final _textController = TextEditingController();
  bool _isUploading = false;
  @override
  void initState() {
    _provider = Provider.of<InboxProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatScreenAppbar(user: widget.user),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: Apis.getAllMessages(widget.user),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  case ConnectionState.active:
                  case ConnectionState.done:
                }
                _provider.setAllMsg(snapshot.data.docs);
                if (_provider.msgs.isNotEmpty) {
                  return ListView.builder(
                    itemCount: _provider.msgs.length,
                    reverse: true,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return MessageCard(
                        message: _provider.msgs[index],
                        recivesMsgBoxDesign: widget.recivesMsgBoxDesign,
                        sendMsgBoxDesign: widget.sendMsgBoxDesign,
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text(
                      'Say Hi! 👋',
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                }
              },
            ),
          ),
          if (_isUploading) const _Loader(),
          ChatInputBox(
            textContoller: _textController,
            onImageClick: () {
              sendGalleryImage();
            },
            onCameraClick: () {
              sendCameraImage();
            },
            onSend: () {
              sendMsg();
            },
          )
        ],
      ),
    );
  }

  //? Send Message --------------------
  void sendMsg() {
    if (_textController.text.isNotEmpty) {
      Apis.sendMessage(
        widget.user,
        _textController.text,
        MsgType.text,
      );
      _textController.text = '';
    }
  }
  //!---------------------------------------

  //? Send Message --------------------
  Future<void> sendCameraImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(
      imageQuality: 70,
      source: ImageSource.camera,
    );
    if (image != null) {
      Apis.sendChatImage(widget.user, File(image.path));
    }
  }

  //!---------------------------------------

  //? Send Message --------------------
  Future<void> sendGalleryImage() async {
    final ImagePicker picker = ImagePicker();
    final List<XFile> images = await picker.pickMultiImage(imageQuality: 70);
    for (var i in images) {
      log('Image Path: ${i.path}');
      setState(() => _isUploading = true);
      await Apis.sendChatImage(widget.user, File(i.path));
      setState(() => _isUploading = false);
    }
  }
  //!---------------------------------------
}

class _Loader extends StatelessWidget {
  const _Loader();

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
    );
  }
}
