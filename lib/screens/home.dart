import 'package:business_logic/bloc/note.dart';
import 'package:business_logic/states/note.dart';
import 'package:coordinator_layout/coordinator_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_flutter_app/routes/navigator.dart';
import 'package:note_flutter_app/views/header.dart';
import 'package:note_flutter_app/views/note_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: CoordinatorLayout(
          headerMinHeight: kToolbarHeight + MediaQuery.of(context).padding.top,
          headerMaxHeight: 240,
          headers: [
            HomeHeader(),
          ],
          body: buildBody(),
        ),
        floatingActionButton: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildFilters(context),
            FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () => context.toNoteEditor(),
            )
          ],
        ),
      ),
    );
  }

  Widget buildFilters(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.fromLTRB(32, 0, 32, 0),
      child: Container(
        child: BlocBuilder<NoteBloc, NotesState>(builder: (context, state) {
          return Row(
            children: [
              buildFilterButton(
                  context, "All", BookmarkFilter.all, state.bookmarkFilter),
              Container(
                color: Theme.of(context).dividerColor,
                height: 32,
                width: 1,
              ),
              buildFilterButton(context, "Bookmark", BookmarkFilter.bookmark,
                  state.bookmarkFilter),
            ],
          );
        }),
      ),
    );
  }

  FlatButton buildFilterButton(BuildContext context, String label,
      BookmarkFilter value, BookmarkFilter bookmarkFilter) {
    return FlatButton(
      child: Text(
        label,
        style: TextStyle(
            color:
                bookmarkFilter == value ? Theme.of(context).accentColor : null),
      ),
      onPressed: () => context.read<NoteBloc>().filter(bookmarkFilter: value),
    );
  }

  Widget buildBody() => NoteListView();
}
