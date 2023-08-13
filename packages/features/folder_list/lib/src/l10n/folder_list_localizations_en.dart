import 'folder_list_localizations.dart';

/// The translations for English (`en`).
class FolderListLocalizationsEn extends FolderListLocalizations {
  FolderListLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get create_new_folder => 'Create New Folder';

  @override
  String get folders => 'Folders';

  @override
  String get dialog_cancel_button => 'Cancel';

  @override
  String get dialog_submit_button => 'Submit';

  @override
  String get dialog_delete_folder_message => 'Are you sure you wish to delete this folder?';

  @override
  String get dialog_delete_folder_title => 'Confirm';
}
