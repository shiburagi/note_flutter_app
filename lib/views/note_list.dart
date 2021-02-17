import 'dart:developer';

import 'package:business_logic/bloc/note.dart';
import 'package:business_logic/states/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:model/models/note.dart';
import 'package:note_flutter_app/routes/navigator.dart';
import 'package:note_flutter_app/extensions/formatter.dart';

class NoteListView extends StatelessWidget {
  const NoteListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NoteBloc, NotesState>(
      builder: (context, state) {
        List<Note> notes = state.filterNotes;
        return notes.isEmpty
            ? Container(
                child: Text(
                  "No notes",
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(color: Theme.of(context).disabledColor),
                ),
                alignment: Alignment.center,
              )
            : buildGridList(notes);
      },
    );
  }

  ListView buildGridList(List<Note> notes) {
    return ListView(
      padding: EdgeInsets.only(top: 8, left: 8, right: 8),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: buildList(notes, 0, 2)),
            Expanded(child: buildList(notes, 1, 2)),
          ],
        ),
      ],
    );
  }

  ListView buildList(List<Note> notes, int i, int col) {
    log("${notes.length % col}");
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        index = index * col + i;
        return NoteListItem(
          note: notes[index],
        );
      },
      itemCount:
          (notes.length / col).floor() + (notes.length % col > i ? 1 : 0),
    );
  }
}

class NoteListItem extends StatelessWidget {
  const NoteListItem({
    Key key,
    this.note,
  }) : super(key: key);

  final Note note;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.toNoteEditor(note),
      child: Container(
        child: Stack(
          children: [
            Container(
              child: buildMainContent(context),
              margin: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            ),
            Positioned(
              right: 8,
              top: -8,
              child: buildBookmarkButton(context),
            )
          ],
        ),
      ),
    );
  }

  IconButton buildBookmarkButton(BuildContext context) {
    return IconButton(
      icon: Stack(
        children: [
          Icon(
            Icons.bookmark,
            color: Theme.of(context).canvasColor,
            size: 32,
          ),
          Icon(
            note.bookmark ? Icons.bookmark : Icons.bookmark_outline,
            color: Theme.of(context).primaryColor,
            size: 32,
          )
        ],
      ),
      onPressed: () => context.read<NoteBloc>().toogleBookmark(note),
    );
  }

  Card buildMainContent(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Theme.of(context).disabledColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 12, 16, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(right: 32),
              child: Wrap(
                  spacing: 8.0, // gap between adjacent chips
                  runSpacing: 4.0, // gap between lines
                  children: note.tagInList
                      .map((tag) => Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.2)),
                            child: Text(
                              tag,
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ))
                      .toList()),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              note.title.trim()?.isNotEmpty == true ? note.title : "<Untitled>",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              note.text,
              maxLines: 6,
              overflow: TextOverflow.fade,
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              note.updatedDateMilliss.toUserDateTime,
              overflow: TextOverflow.fade,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Theme.of(context).accentColor),
            ),
          ],
        ),
      ),
    );
  }
}
