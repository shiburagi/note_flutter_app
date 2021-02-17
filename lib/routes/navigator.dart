import 'package:flutter/material.dart';
import 'package:model/models/note.dart';
import 'package:note_flutter_app/screens/home.dart';
import 'package:note_flutter_app/screens/note_editor.dart';

Map<String, WidgetBuilder> routes = {
  RoutePath.home: (context) => HomeScreen(),
  RoutePath.noteEditor: (context) =>
      NoteEditorScreeen(note: context.argurments),
};

class RoutePath {
  static final String home = "/";
  static final String noteEditor = "/note/edit";
}

extension ContextNavigatorExt on BuildContext {
  NavigatorState get navigator => Navigator.of(this);
  dynamic get argurments => ModalRoute.of(this).settings.arguments;
  toHome() => navigator.pushNamed(RoutePath.home);
  toNoteEditor([Note note]) =>
      navigator.pushNamed(RoutePath.noteEditor, arguments: note);
}
