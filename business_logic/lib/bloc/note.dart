import 'package:business_logic/states/note.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:model/models/note.dart';

class NoteBloc extends Cubit<NotesState> {
  NoteBloc() : super(NotesState());

  bool createNote(String title, String tag, String text) {
    if (text.isNotEmpty) {
      emit(state.addNote(Note(text: text, tag: tag, title: title)));
      return true;
    }
    return false;
  }

  bool saveNote(Note note, String title, String tag, String text) {
    if (text.isEmpty) return false;
    if (note == null) return createNote(title, tag, text);
    note.title = title;
    note.text = text;
    note.tag = tag;
    note.updatedDateMilliss = DateTime.now().millisecondsSinceEpoch;
    emit(state.update());
    return true;
  }

  toogleBookmark(Note note) {
    note.bookmark = !note.bookmark;
    emit(state.update());
  }

  delete(Note note) {
    emit(state.delete(note));
  }

  filter({BookmarkFilter bookmarkFilter, String searchText}) {
    emit(state.copyWith(
      bookmarkFilter: bookmarkFilter,
      searchText: searchText,
    ));
  }
}
