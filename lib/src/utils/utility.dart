import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Utility {
  //? Connection State ---------------------
  static Widget chacheImage(String url) {
    return CachedNetworkImage(
      imageUrl: url,
      placeholder: (context, url) => const Padding(
        padding: EdgeInsets.all(8.0),
        child: CircularProgressIndicator(strokeWidth: 2),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.image, size: 70),
    );
  }
  //! --------------------------------------

  // //? Set theme ----------------------------
  // static late MessageBox recivesMsgBoxDesign;
  // static late MessageBox sendMsgBoxDesign;

  // static Future<void> setTheme({
  //   required MessageBox recived,
  //   required MessageBox send,
  // }) async {
  //   recivesMsgBoxDesign = recived;
  //   sendMsgBoxDesign = send;
  // }

  // //! --------------------------------------
}
