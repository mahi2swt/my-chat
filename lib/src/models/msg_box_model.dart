import 'package:flutter/material.dart';

class MessageBox {
  final TextStyle? textStyle;
  final BoxDecoration? messageBoxStyle;
  final EdgeInsetsGeometry? innerPadding;
  final EdgeInsetsGeometry? outerPadding;
  final TextStyle? dateTimeTextStyle;
  MessageBox({
    this.textStyle,
    this.messageBoxStyle,
    this.innerPadding,
    this.outerPadding,
    this.dateTimeTextStyle,
  });
}
