import 'package:business_logic/bloc/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model/models/note.dart';
import 'package:note_flutter_app/routes/navigator.dart';

class NoteEditorScreeen extends StatefulWidget {
  const NoteEditorScreeen({Key key, this.note}) : super(key: key);
  final Note note;
  @override
  _NoteEditorScreeenState createState() => _NoteEditorScreeenState();
}

class _NoteEditorScreeenState extends State<NoteEditorScreeen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController textController = TextEditingController();
  final TextEditingController tagController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.note?.title;
    tagController.text = widget.note?.tag;
    textController.text = widget.note?.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note == null ? "New note" : "Edit note"),
      ),
      body: buildBody(),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget.note == null
                  ? SizedBox()
                  : RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24)),
                      textTheme: ButtonTextTheme.primary,
                      color: Theme.of(context).errorColor,
                      child: Text("Delete"),
                      onPressed: () async {
                        if (await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text("Confirmation"),
                            content:
                                Text("Are you sure want delete this note?"),
                            actions: [
                              FlatButton(
                                onPressed: () => context.navigator.pop(false),
                                child: Text("Cancel"),
                              ),
                              RaisedButton(
                                color: Theme.of(context).errorColor,
                                textColor: Colors.white,
                                onPressed: () => context.navigator.pop(true),
                                child: Text("Confirm"),
                              ),
                            ],
                          ),
                        )) {
                          context.read<NoteBloc>().delete(widget.note);
                          context.navigator.pop();
                        }
                      },
                    ),
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                textTheme: ButtonTextTheme.primary,
                color: Theme.of(context).accentColor,
                child: Text(widget.note == null ? "Create" : "Update"),
                onPressed: () {
                  if (context.read<NoteBloc>().saveNote(
                      widget.note,
                      titleController.text,
                      tagController.text,
                      textController.text)) context.navigator.pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          TextFormField(
            controller: titleController,
            decoration: InputDecoration(
              isDense: true,
              hintText: "Title (Optional)",
              contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 16),
            ),
          ),
          TextFormField(
            controller: tagController,
            decoration: InputDecoration(
              isDense: true,
              hintText: "Tag (Optional, e.g: study,research,science)",
              contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 16),
            ),
          ),
          TextFormField(
            autofocus: true,
            controller: textController,
            textInputAction: TextInputAction.newline,
            maxLines: double.maxFinite.toInt(),
            decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
              hintText: "Notes",
              contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 16),
            ),
          ),
        ],
      ),
    );
  }
}
