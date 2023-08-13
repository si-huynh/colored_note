import 'note_list_localizations.dart';

/// The translations for English (`en`).
class NoteListLocalizationsEn extends NoteListLocalizations {
  NoteListLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get folderIsEmpty => 'Folder is empty';

  @override
  String get dialogCancelButton => 'Cancel';

  @override
  String get dialogSubmitButton => 'Submit';

  @override
  String get dialogDeleteNoteMessage => 'Are you sure you wish to delete this note?';

  @override
  String get dialogDeleteNoteTitle => 'Confirm';
}
