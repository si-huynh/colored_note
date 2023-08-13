/*
 * Created By: Sĩ Huỳnh on Wednesday, August 9th 2023, 10:01:04 am
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
import 'package:folder_list/src/folder_cubit.dart';
import 'package:folder_list/src/folder_list_state.dart';
import 'package:folder_list/src/l10n/folder_list_localizations.dart';
import 'package:folder_list/src/widgets/add_new_folder_dialog.dart';
import 'package:folder_list/src/widgets/folder_list_item_view.dart';

typedef FolderItemSelected = Function(String name);

class FolderListView extends StatelessWidget {
  const FolderListView({
    super.key,
    required VoidCallback onNewNoteButtonPressed,
    FolderItemSelected? folderItemSelected,
  })  : _folderItemSelected = folderItemSelected,
        _onNewNoteButtonPressed = onNewNoteButtonPressed;

  final FolderItemSelected? _folderItemSelected;
  final VoidCallback _onNewNoteButtonPressed;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FolderListCubit, FolderListState>(
      builder: (context, state) {
        final folders = state is FolderListSuccess ? state.folderList : <Folder>[];

        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar.large(
                leading: const AddNewFolderButton(),
                title: Text(FolderListLocalizations.of(context).folders),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(20),
                sliver: SliverFixedExtentList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => FolderListItemView(
                      folder: folders[index],
                      onItemSelected: _folderItemSelected,
                    ),
                    childCount: folders.length,
                  ),
                  itemExtent: 56,
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _onNewNoteButtonPressed,
            heroTag: null,
            child: const Icon(Icons.add),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
