/*
 * Created By: Sĩ Huỳnh on Monday, August 7th 2023, 10:02:27 am
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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folder_list/src/folder_cubit.dart';
import 'package:folder_list/src/l10n/folder_list_localizations.dart';

enum ActionDialogButton { submit, cancel }

class AddNewFolderButton extends StatefulWidget {
  const AddNewFolderButton({super.key});

  @override
  State<AddNewFolderButton> createState() => _AddNewFolderButtonState();
}

class _AddNewFolderButtonState extends State<AddNewFolderButton> {
  String _folderNameValueText = '';

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.create_new_folder_outlined),
      onPressed: _onNewFolderButtonPress,
    );
  }

  _onNewFolderButtonPress() {
    addNewFolderdialog(context).then((value) {
      if (value != null && value == ActionDialogButton.submit && _folderNameValueText.isNotEmpty) {
        final cubit = context.read<FolderListCubit>();
        cubit.createNewFolder(_folderNameValueText);
      }
    }).whenComplete(() => _folderNameValueText = '');
  }

  Future<ActionDialogButton?> addNewFolderdialog(BuildContext context) async {
    final l10n = FolderListLocalizations.of(context);
    return showDialog<ActionDialogButton>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(l10n.create_new_folder),
            content: TextField(
              onChanged: (value) {
                setState(() {
                  _folderNameValueText = value;
                });
              },
            ),
            actions: [
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context, ActionDialogButton.submit);
                },
                child: Text(l10n.dialog_submit_button),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pop(context, ActionDialogButton.cancel);
                },
                child: Text(l10n.dialog_cancel_button),
              ),
            ],
          );
        });
  }
}
