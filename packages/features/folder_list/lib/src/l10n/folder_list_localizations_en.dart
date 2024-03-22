import 'folder_list_localizations.dart';

/// The translations for English (`en`).
class FolderListLocalizationsEn extends FolderListLocalizations {
  FolderListLocalizationsEn([super.locale = 'en']);

  @override
  String get createNewFolder => 'Create New Folder';

  @override
  String get folders => 'Folders';

  @override
  String get dialogCancelButton => 'Cancel';

  @override
  String get dialogSubmitButton => 'Submit';

  @override
  String get dialogDeleteFolderMessage =>
      'Are you sure you wish to delete this folder?';

  @override
  String get dialogDeleteFolderTitle => 'Confirm';
}
