/*
 * Created By: Sĩ Huỳnh on Thursday, August 10th 2023, 9:43:15 am
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
import 'package:grouped_list/sliver_grouped_list.dart';
import 'package:note_list/src/l10n/note_list_localizations.dart';
import 'package:note_list/src/note_list_cubit.dart';
import 'package:note_list/src/note_list_state.dart';
import 'package:note_list/src/widgets/note_list_item_view.dart';

typedef OnNoteItemSelected = Function(String id);

class NoteListView extends StatefulWidget {
  const NoteListView({
    super.key,
    required this.title,
    OnNoteItemSelected? onNoteItemSelected,
    VoidCallback? onNewNoteButtonPressed,
  })  : _onNoteItemSelected = onNoteItemSelected,
        _onNewNoteButtonPressed = onNewNoteButtonPressed;

  final String title;
  final OnNoteItemSelected? _onNoteItemSelected;
  final VoidCallback? _onNewNoteButtonPressed;

  @override
  State<NoteListView> createState() => _NoteListViewState();
}

class _NoteListViewState extends State<NoteListView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NoteListCubit, NoteListState>(
      builder: (context, state) {
        return Scaffold(
          body: _buildGroupList(state, context),
          floatingActionButton: FloatingActionButton(
            onPressed: widget._onNewNoteButtonPressed,
            heroTag: 'compose-button',
            child: const Icon(Icons.add),
          ),
        );
      },
      listener: (context, state) => {},
    );
  }

  _buildGroupList(NoteListState state, BuildContext context) {
    final notes = state.noteList;
    final paddingBottom = MediaQuery.of(context).padding.bottom;
    return CustomScrollView(
      slivers: [
        SliverAppBar.large(
          title: Text(widget.title),
        ),
        notes.isNotEmpty
            ? SliverPadding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, paddingBottom),
                sliver: SliverGroupedListView(
                  elements: notes,
                  groupBy: (note) => note.group.order,
                  groupHeaderBuilder: (note) => Padding(
                    padding: const EdgeInsets.fromLTRB(8, 16, 8, 8),
                    child: Text(
                      note.group.name,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ),
                  itemComparator: (element1, element2) {
                    return element1.group.order.compareTo(element2.group.order);
                  },
                  itemBuilder: (context, note) => NoteListItemView(
                    note: note,
                    onItemSelected: widget._onNoteItemSelected,
                  ),
                ),
              )
            : _buildEmptyContent(),
      ],
    );
  }

  _buildEmptyContent() {
    return SliverFillRemaining(
      hasScrollBody: false,
      child: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.note_outlined,
              size: 96,
              color: Theme.of(context).colorScheme.outlineVariant,
            ),
            Text(
              NoteListLocalizations.of(context).folder_is_empty,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Theme.of(context).colorScheme.outlineVariant,
                  ),
            ),
            const SizedBox(
              height: kToolbarHeight + kFloatingActionButtonMargin,
            )
          ],
        ),
      ),
    );
  }
}
