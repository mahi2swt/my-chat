import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum MsgType { error, warning, info, sucess }

class Dialogs {
  static void showSnackbar(BuildContext context, String msg, MsgType type) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
        backgroundColor: getColor(type),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  static Color getColor(MsgType type) {
    switch (type) {
      case MsgType.error:
        return Colors.redAccent;
      case MsgType.warning:
        return Colors.orange;
      case MsgType.sucess:
        return Colors.green;
      default:
        return Colors.blueAccent;
    }
  }

  //? Prgress Bar
  static void showProgressBar(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => Center(
        child: Platform.isAndroid
            ? const CircularProgressIndicator()
            : const CupertinoActivityIndicator(color: Colors.white),
      ),
    );
  }
  //! -----------
}
