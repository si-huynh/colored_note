/*
 * Created By: Sĩ Huỳnh on Sunday, August 6th 2023, 7:33:50 pm
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
import 'package:folder_list/src/folder_list_view.dart' show FolderListView, FolderItemSelected;
import 'package:folder_repository/folder_repository.dart';

class FolderListScreen extends StatelessWidget {
  const FolderListScreen({
    super.key,
    required this.folderRepository,
    required VoidCallback onNewNoteButtonPressed,
    FolderItemSelected? folderItemSelected,
  })  : _folderItemSelected = folderItemSelected,
        _onNewNoteButtonPressed = onNewNoteButtonPressed;

  final FolderRepository folderRepository;
  final FolderItemSelected? _folderItemSelected;
  final VoidCallback _onNewNoteButtonPressed;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FolderListCubit(
        folderRepository: folderRepository,
      ),
      child: FolderListView(
        folderItemSelected: _folderItemSelected,
        onNewNoteButtonPressed: _onNewNoteButtonPressed,
      ),
    );
  }
}
