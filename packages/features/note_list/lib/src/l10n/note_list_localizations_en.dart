import 'note_list_localizations.dart';

/// The translations for English (`en`).
class NoteListLocalizationsEn extends NoteListLocalizations {
  NoteListLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get folder_is_empty => 'Folder is empty';

  @override
  String get dialog_cancel_button => 'Cancel';

  @override
  String get dialog_submit_button => 'Submit';

  @override
  String get dialog_delete_note_message => 'Are you sure you wish to delete this note?';

  @override
  String get dialog_delete_note_title => 'Confirm';

  @override
  String get group_today => 'Today';

  @override
  String get group_yesterday => 'Yesterday';

  @override
  String get group_this_month => 'This Month';
}
