/*
 * Created By: Sĩ Huỳnh on Sunday, August 6th 2023, 3:52:11 pm
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
import 'package:folder_list/folder_list.dart';
import 'package:folder_repository/folder_repository.dart';
import 'package:note_compose/note_compose.dart';
import 'package:note_list/note_list.dart';
import 'package:note_repository/note_repository.dart';
import 'package:routemaster/routemaster.dart';

Map<String, PageBuilder> buildRoutingTable({
  required RoutemasterDelegate routerDelegate,
  required FolderRepository folderRepository,
  required NoteRepository noteRepository,
}) {
  return {
    _PathConstants.folderListPath: (route) {
      return MaterialPage(
        name: 'folder-list',
        child: FolderListScreen(
          folderRepository: folderRepository,
          folderItemSelected: (name) {
            routerDelegate.push(_PathConstants.noteList(folder: name));
          },
          onNewNoteButtonPressed: () async {
            final noteID = await noteRepository.newCraftNode();
            routerDelegate.push(_PathConstants.noteComposePath(
              folder: 'All',
              noteID: noteID,
            ));
          },
        ),
      );
    },
    _PathConstants.noteList(): (route) {
      final folder = route.pathParameters['folder']!;

      return MaterialPage(
        name: 'note-list',
        child: NoteListScreen(
          title: folder,
          noteRepository: noteRepository,
          onNoteItemSelected: (noteID) {
            routerDelegate.push(_PathConstants.noteComposePath(
              folder: folder,
              noteID: noteID,
            ));
          },
          onNewNoteButtonPressed: () async {
            final noteID = await noteRepository.newCraftNode(folder: folder);
            routerDelegate.push(_PathConstants.noteComposePath(
              folder: folder,
              noteID: noteID,
            ));
          },
        ),
      );
    },
    _PathConstants.noteComposePath(): (route) {
      final noteID = route.pathParameters[_PathConstants.idPathParameter]!;
      return MaterialPage(
        name: 'note-compose',
        child: NoteComposeScreen(
          noteID: noteID,
          noteRepository: noteRepository,
        ),
      );
    }
  };
}

class _PathConstants {
  const _PathConstants._();

  static String get folderListPath => '/';

  static String get folderPathParameter => 'folder';

  static String noteList({String? folder}) => '/folder/${folder ?? ':$folderPathParameter'}';

  static String get idPathParameter => 'id';

  static String noteComposePath({String? folder, String? noteID}) =>
      '/folder/${folder ?? ':$folderPathParameter'}/${noteID ?? ':$idPathParameter'}';
}
