import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart';
import 'package:kb_chat_module/src/models/chat_user_model.dart';
import 'package:kb_chat_module/src/models/message_model.dart';

class Apis {
  static FirebaseAuth auth = FirebaseAuth.instance;

  //? For accessing cloud firstore DB
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  //! -------------------------------

  //? For accessing cloud firstore DB
  static FirebaseStorage storage = FirebaseStorage.instance;
  //! -------------------------------

  //? Data Stroing for future use ---
  static late User user;
  static late ChatUserModel me;
  //! -------------------------------

  //? Firebase Messaging ------------
  static FirebaseMessaging fMessaging = FirebaseMessaging.instance;
  //! -------------------------------

  //? checking user is exist or not
  static Future<bool> userExist() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }
  //! -------------------------------

  //? Set Authorised User------------
  static Future<void> setAuthorisedUser(User userDate) async {
    user = userDate;
  }
  //! -------------------------------

  //? set Token and key -------------
  static late String pushNotificationKey;
  static late String notificationChannelName;
  static Future<void> steKey({
    required String key,
    required String channelName,
  }) async {
    pushNotificationKey = key;
    notificationChannelName = channelName;
  }
  //! -------------------------------

  //? for getting current user info
  static Future<void> getSelfInfo() async {
    await firestore.collection('users').doc(user.uid).get().then((user) async {
      if (user.exists) {
        me = ChatUserModel.fromMap(user.data()!);
        await getFirebaseMsgToken();
        updateActiveStatus(true);
      } else {
        await createUser().then((value) => getSelfInfo());
      }
    });
  }
  //! -------------------------------

  //? checking user is not exist ----
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final chatUser = ChatUserModel(
      id: user.uid.toString(),
      name: user.displayName.toString(),
      email: user.email.toString(),
      about: 'Hey!, I\'m using FL Chat',
      image: user.photoURL.toString(),
      isOnline: false,
      createdAt: time,
      lastActive: time,
      pushToken: '',
    );

    return firestore.collection('users').doc(user.uid).set(chatUser.toMap());
  }
  //! -------------------------------

  //? get All User list -------------
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore
        .collection('users')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }
  //! -------------------------------

  //? for updating user information -
  static Future<void> updateUserInfo() async {
    await firestore.collection('users').doc(user.uid).update({
      'name': me.name,
      'about': me.about,
    });
  }
  //! -------------------------------

  //? getting conversation ID -------
  static String getConversationID(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';
  //! -------------------------------

  //* for getting all messages of a specific conversation from firestore database
  //? get All Msgs list -------------
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      ChatUserModel user) {
    return firestore
        .collection('chats/${getConversationID(user.id)}/messages/')
        .orderBy('sent', descending: true)
        .snapshots();
  }
  //! -------------------------------

  //? for sending message -----------
  static Future<void> sendMessage(
    ChatUserModel chatUser,
    String msg,
    MsgType msgType,
  ) async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();
    final MesssageModel message = MesssageModel(
      toId: chatUser.id,
      msg: msg,
      read: '',
      type: msgType,
      fromId: user.uid,
      sent: time,
    );
    final ref = firestore.collection(
      'chats/${getConversationID(chatUser.id)}/messages/',
    );
    await ref.doc(time).set(message.toMap()).then((value) {
      sendPushNotifications(chatUser, msgType == MsgType.text ? msg : 'Image');
    });
  }
  //! -------------------------------

  //? Update read msg ---------------
  static Future<void> updateMessageReadStatus(MesssageModel message) async {
    firestore
        .collection('chats/${getConversationID(message.fromId)}/messages/')
        .doc(message.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }
  //! -------------------------------

  //? get Last Msg on User card------
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
      ChatUserModel user) {
    return firestore
        .collection('chats/${getConversationID(user.id)}/messages/')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }
  //! -------------------------------

  //? Send Photo --------------------
  static Future<void> sendChatImage(ChatUserModel chatUser, File file) async {
    final ext = file.path.split('.').last;
    final ref = storage.ref().child(
          'images/${getConversationID(chatUser.id)}/${DateTime.now().millisecondsSinceEpoch}.$ext',
        );
    await ref
        .putFile(file, SettableMetadata(contentType: 'image/$ext'))
        .then((p0) {});
    final imageUrl = await ref.getDownloadURL();
    await sendMessage(chatUser, imageUrl, MsgType.image);
  }
  //! -------------------------------

  //? get Users info ----------------
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
      ChatUserModel chatuser) {
    return firestore
        .collection('users')
        .where('id', isEqualTo: chatuser.id)
        .snapshots();
  }
  //! -------------------------------

  //? Update online or last active status
  static Future<void> updateActiveStatus(bool isOnline) async {
    firestore.collection('users').doc(user.uid).update({
      'is_online': isOnline,
      'last_active': DateTime.now().millisecondsSinceEpoch.toString(),
      'push_token': me.pushToken,
    });
  }
  //! -------------------------------

  //* Firebase Push Notification -------------------------------
  //? Get Firwebase token -----------
  static Future<void> getFirebaseMsgToken() async {
    await fMessaging.requestPermission();
    fMessaging.getToken().then((token) {
      if (token != null) {
        me.pushToken = token;
        log('push token --> $token');
      }
    });
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   log('Got a message whilst in the foreground!');
    //   log('Message data: ${message.data}');

    //   if (message.notification != null) {
    //     log('Message also contained a notification: ${message.notification}');
    //   }
    // });
  }
  //! -------------------------------

  //? send Push Notification --------
  static Future<void> sendPushNotifications(
    ChatUserModel chatUser,
    String msg,
  ) async {
    final body = {
      "to": chatUser.pushToken,
      "notification": {
        "title": chatUser.name,
        "body": msg,
        "android_channel_id": notificationChannelName,
      },
      "data": {
        "some_data": "User Id: ${me.id}",
      },
    };
    try {
      await post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: pushNotificationKey
        },
        body: jsonEncode(body),
      );
    } catch (e) {
      log(e.toString());
    }
  }
  //! -------------------------------
}
