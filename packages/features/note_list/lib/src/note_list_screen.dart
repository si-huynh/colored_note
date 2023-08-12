/*
 * Created By: Sĩ Huỳnh on Sunday, August 6th 2023, 3:40:02 pm
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
import 'package:note_list/src/note_list_cubit.dart';
import 'package:note_list/src/note_list_view.dart' show NoteListView, OnNoteItemSelected;
import 'package:note_repository/note_repository.dart';

class NoteListScreen extends StatelessWidget {
  NoteListScreen({
    super.key,
    required this.title,
    required NoteRepository noteRepository,
    OnNoteItemSelected? onNoteItemSelected,
    VoidCallback? onNewNoteButtonPressed,
  })  : _cubit = NoteListCubit(
          folder: title,
          noteRepository: noteRepository,
        ),
        _onNoteItemSelected = onNoteItemSelected,
        _onNewNoteButtonPressed = onNewNoteButtonPressed;

  final String title;
  final OnNoteItemSelected? _onNoteItemSelected;
  final VoidCallback? _onNewNoteButtonPressed;

  final NoteListCubit _cubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _cubit,
      child: NoteListView(
        title: title,
        onNoteItemSelected: _onNoteItemSelected,
        onNewNoteButtonPressed: _onNewNoteButtonPressed,
      ),
    );
  }

  onFocused() {
    Future.delayed(const Duration(milliseconds: 100), () {
      _cubit.deleteCraftNote();
    });
  }
}
