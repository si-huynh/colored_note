/*
 * Created By: Sĩ Huỳnh on Monday, August 7th 2023, 3:44:45 pm
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
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folder_list/src/folder_list_state.dart';
import 'package:folder_repository/folder_repository.dart';

class FolderListCubit extends Cubit<FolderListState> {
  FolderListCubit({
    required this.folderRepository,
  }) : super(
          const FolderListInProgress(),
        ) {
    _fetchFolderList();
  }

  final FolderRepository folderRepository;

  Future<void> _fetchFolderList() async {
    try {
      log('Perform fetching folders...');
      final folderList = await folderRepository.getAllFolders();
      if (folderList.isEmpty) {
        final allFolder = await folderRepository.upsertFolder('All');
        folderList.add(allFolder);
      }

      emit(FolderListSuccess(folderList: folderList));
      log('Done. We have ${folderList.length} folders');
    } catch (error) {
      emit(const FolderListStateFailure());
    }
  }

  Future<void> createNewFolder(String name) async {
    try {
      if (await folderIsExist(name)) {
        log('Folder $name existed');
        return;
      }

      log('Creating new folder...');
      await folderRepository.upsertFolder(name);
      log('Folder $name was created');

      await _fetchFolderList();
    } catch (error) {
      log('Failed to create new folder', error: error);
    }
  }

  Future<void> deleteFolder(String name) async {
    try {
      await folderRepository.deleteFolder(name);
      await _fetchFolderList();
    } catch (error) {
      log('Failed to delete folder $name', error: error);
    }
  }

  Future<bool> folderIsExist(String name) async {
    return await folderRepository.getFolderByName(name) != null;
  }
}
