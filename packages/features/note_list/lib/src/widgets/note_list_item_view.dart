/*
 * Created By: Sĩ Huỳnh on Thursday, August 10th 2023, 11:06:16 am
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
import 'package:intl/intl.dart';
import 'package:note_list/note_list.dart';
import 'package:note_list/src/note_list_cubit.dart';
import 'package:note_list/src/note_list_item.dart' show NoteListItem, NoteGroup;

class NoteListItemView extends StatelessWidget {
  const NoteListItemView({
    super.key,
    required this.note,
    Function(String)? onItemSelected,
  }) : _onItemSelected = onItemSelected;

  final NoteListItem note;
  final Function(String id)? _onItemSelected;

  @override
  Widget build(BuildContext context) {
    var formatTime = DateFormat.yMMMd().format(note.time);
    final group = note.group.name;
    if (group == NoteGroup.today.name || group == NoteGroup.yesterday.value) {
      formatTime = DateFormat.Hm().format(note.time);
    } else {
      formatTime = DateFormat('EEEE dd').format(note.time);
    }
    return Dismissible(
      key: ObjectKey(note.id),
      background: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.error,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          trailing: Icon(
            Icons.delete,
            color: Theme.of(context).colorScheme.onError,
          ),
          visualDensity: VisualDensity.standard,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => _confirmDimiss(context),
      onDismissed: (_) => _performDelete(context, note.id),
      child: Card(
        child: ListTile(
          title: Text(note.title),
          subtitle: Text(
            formatTime,
            style: Theme.of(context).textTheme.labelSmall,
          ),
          trailing: const Icon(Icons.chevron_right),
          leading: const Icon(Icons.note),
          visualDensity: VisualDensity.comfortable,
          onTap: () => _onItemSelected?.call(note.id),
        ),
      ),
    );
  }

  Future<bool> _confirmDimiss(BuildContext context) async {
    final l10n = NoteListLocalizations.of(context);
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(l10n.dialog_delete_note_title),
          content: Text(l10n.dialog_delete_note_message),
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

  Future<void> _performDelete(BuildContext context, String id) async {
    final cubit = context.read<NoteListCubit>();
    return cubit.deleteNote(id);
  }
}
