/*
 * Created By: Sĩ Huỳnh on Wednesday, August 9th 2023, 11:12:15 am
 * 
 * Copyright (c) 2023 Si Huynh
 * 
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 * 
 *  The above copyright notice and this permission notice shall be included in
 *  all copies or substantial portions of the Software.
 * 
 *  Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 *  distribute, sublicense, create a derivative work, and/or sell copies of the
 *  Software in any work that is designed, intended, or marketed for pedagogical or
 *  instructional purposes related to programming, coding, application development,
 *  or information technology.  Permission for such use, copying, modification,
 *  merger, publication, distribution, sublicensing, creation of derivative works,
 *  or sale is expressly withheld.
 * 
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *  THE SOFTWARE.
 */
import 'package:domain_models/domain_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folder_list/folder_list.dart';
import 'package:folder_list/src/folder_cubit.dart';

class FolderListItemView extends StatelessWidget {
  const FolderListItemView({super.key, required folder, onItemSelected, onItemDeleted})
      : _folder = folder,
        _onItemSelected = onItemSelected;

  final Folder _folder;
  final Function(String name)? _onItemSelected;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ObjectKey(_folder.id),
      background: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.error,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          trailing: Icon(
            Icons.delete,
            color: Theme.of(context).colorScheme.onError,
          ),
        ),
      ),
      direction: _folder.name == 'All' ? DismissDirection.none : DismissDirection.endToStart,
      onDismissed: (_) => _performDelete(context, _folder.name),
      confirmDismiss: (_) => _confirmDimiss(context),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Theme.of(context).colorScheme.outline,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: ListTile(
          title: Text(_folder.name),
          leading: const Icon(Icons.folder),
          trailing: const Icon(Icons.chevron_right),
          visualDensity: VisualDensity.compact,
          onTap: () => _onItemSelected?.call(_folder.name),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _confirmDimiss(BuildContext context) async {
    final l10n = FolderListLocalizations.of(context);
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(l10n.dialog_delete_folder_title),
          content: Text(l10n.dialog_delete_folder_message),
          actions: <Widget>[
            MaterialButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(l10n.dialog_submit_button),
            ),
            MaterialButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(l10n.dialog_cancel_button),
            ),
          ],
        );
      },
    );
  }

  _performDelete(BuildContext context, String name) {
    final cubit = context.read<FolderListCubit>();
    cubit.deleteFolder(name);
  }
}
