import 'package:model/models/note.dart';

class NotesState {
  NotesState(
      {this.notes = const [],
      this.searchText = "",
      this.bookmarkFilter = BookmarkFilter.all});

  List<Note> notes = [];
  String searchText = "";
  BookmarkFilter bookmarkFilter = BookmarkFilter.bookmark;

  List<Note> get filterNotes => notes
      .where((note) =>
          bookmarkFilter.valid(note.bookmark) &&
          (note.text.toLowerCase().contains(searchText.toLowerCase()) ||
              note.title.toLowerCase().contains(searchText.toLowerCase()) ||
              note.tag.toLowerCase().contains(searchText.toLowerCase())))
      .toList();

  List<Note> get filterBookmarkNotes =>
      filterNotes.where((note) => note.bookmark).toList();
  List<Note> get filterUnbookmarkNotes =>
      filterNotes.where((note) => !note.bookmark).toList();

  NotesState addNote(Note note) {
    return copyWith(notes: [note, ...notes]);
  }

  NotesState update() {
    return copyWith();
  }

  NotesState delete(Note note) {
    return copyWith(notes: notes.where((n) => n != note).toList());
  }

  NotesState copyWith(
      {List<Note> notes, String searchText, BookmarkFilter bookmarkFilter}) {
    return NotesState(
      notes: notes ?? this.notes,
      searchText: searchText ?? this.searchText,
      bookmarkFilter: bookmarkFilter ?? this.bookmarkFilter,
    );
  }
}

enum BookmarkFilter {
  all,
  bookmark,
}

extension BookmarkFilterExt on BookmarkFilter {
  bool get value => this == BookmarkFilter.all
      ? null
      : this == BookmarkFilter.bookmark
          ? true
          : false;
  bool valid(bool bookmark) => value == null || value == bookmark;
}
