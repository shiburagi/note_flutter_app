import 'package:flutter/material.dart';

class Note {
  Note({@required this.text, this.title, this.tag, this.bookmark = false});
  String title;
  String text;
  String tag;
  bool bookmark;

  int createdDateMilliss = DateTime.now().millisecondsSinceEpoch;
  int updatedDateMilliss = DateTime.now().millisecondsSinceEpoch;

  List<String> get tagInList => (tag?.isNotEmpty == true ? tag : "Casual")
      .split(RegExp(r",[\s]+"))
      .toList();
}
