import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kb_chat_module/src/api/apis.dart';
import 'package:kb_chat_module/src/models/chat_user_model.dart';
import 'package:kb_chat_module/src/models/message_model.dart';

class InboxProvider extends ChangeNotifier {
  List<ChatUserModel> userList = [];
  final List<ChatUserModel> searchList = [];
  List<MesssageModel> msgs = [];

  //? Set All User into List ----
  void setAllUser(dynamic data) {
    userList = List.from(data.map((e) {
          return ChatUserModel.fromMap(e.data());
        }).toList() ??
        []);
  }
  //!---------------------------------

  //? Search from List ---------------
  void searchListData(String text) {
    searchList.clear();
    for (var i in userList) {
      if (i.name.toLowerCase().contains(text.toLowerCase()) ||
          i.email.toLowerCase().contains(text.toLowerCase())) {
        searchList.add(i);
      }
    }
    log(searchList.length.toString());
    notifyListeners();
  }
  //!---------------------------------

  //? update online and Lastseen status
  void checkLastStatus() {
    SystemChannels.lifecycle.setMessageHandler((message) {
      if (message.toString().contains('pause')) {
        Apis.updateActiveStatus(false);
      }
      if (message.toString().contains('resume')) {
        Apis.updateActiveStatus(true);
      }
      return Future.value(message);
    });
  }
  //!-------------------------------

  //* chat Related fuiunctions and data mapoping

  //? Get All Msgs -----------------
  void setAllMsg(dynamic data) {
    msgs = List.from(data.map((e) {
          return MesssageModel.fromMap(e.data());
        }).toList() ??
        []);
  }
  //!-------------------------------
}
