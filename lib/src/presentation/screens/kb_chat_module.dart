library kb_chat_module;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kb_chat_module/src/api/apis.dart';
import 'package:kb_chat_module/src/controller/inbox_provider.dart';
import 'package:kb_chat_module/src/models/msg_box_model.dart';
import 'package:kb_chat_module/src/presentation/screens/home_screen.dart';
import 'package:provider/provider.dart';

class KbChatModule extends StatefulWidget {
  final ThemeData? theme;
  final User firebaseAuthUser;
  final MessageBox? recivesMsgBoxDesign;
  final MessageBox? sendMsgBoxDesign;
  final String pushNotificationKey;
  final String notificationChannelId;
  const KbChatModule({
    super.key,
    this.theme,
    required this.firebaseAuthUser,
    this.recivesMsgBoxDesign,
    this.sendMsgBoxDesign,
    required this.pushNotificationKey,
    required this.notificationChannelId,
  });

  @override
  State<KbChatModule> createState() => _KbChatModuleState();
}

class _KbChatModuleState extends State<KbChatModule> {
  @override
  void initState() {
    checkCurrentUser();
    setKey();

    super.initState();
  }

  Future<void> checkCurrentUser() async {
    await Apis.setAuthorisedUser(widget.firebaseAuthUser);

    if (!await Apis.userExist()) {
      await Apis.createUser();
    }
  }

  Future<void> setKey() async {
    await Apis.steKey(
      key: widget.pushNotificationKey,
      channelName: widget.notificationChannelId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InboxProvider()),
      ],
      child: MaterialApp(
        theme: getDefaultTheme(context),
        debugShowCheckedModeBanner: false,
        home: HomeScreen(
          recivesMsgBoxDesign: widget.recivesMsgBoxDesign!,
          sendMsgBoxDesign: widget.sendMsgBoxDesign!,
        ),
      ),
    );
  }

  ThemeData getDefaultTheme(BuildContext context) {
    final providedTheme = widget.theme;
    if (providedTheme != null) {
      return providedTheme;
    } else {
      return ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      );
    }
  }
}
