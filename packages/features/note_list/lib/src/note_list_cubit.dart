/*
 * Created By: Sĩ Huỳnh on Thursday, August 10th 2023, 9:56:48 am
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

import 'package:domain_models/domain_models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_list/src/note_list_item.dart';
import 'package:note_list/src/note_list_state.dart';
import 'package:note_repository/note_repository.dart';

class NoteListCubit extends Cubit<NoteListState> {
  NoteListCubit({
    required this.folder,
    required this.noteRepository,
  }) : super(const NoteListState());

  final NoteRepository noteRepository;
  final String folder;

  Future<void> fetchNoteList() async {
    try {
      final noteList = await noteRepository.getAllNotes(folder);
      final noteListItem = noteList.map((e) => NoteListItem.fromDomainModel(e)).toList();
      emit(NoteListState(noteList: noteListItem));
    } catch (error) {
      log('Failed to load note list in folder $folder', error: error);
    }
  }

  Future<Note?> createNewNote() async {
    try {
      final note = Note.craft(folder: folder);
      await noteRepository.upsertNote(note);
      await fetchNoteList();
      return note;
    } catch (error) {
      log('Failed to create new note', error: error);
      return null;
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      await noteRepository.deleteNoteByID(id);
      await fetchNoteList();
    } catch (error) {
      log('Failed to delete note', error: error);
    }
  }

  Future<void> deleteCraftNote() async {
    try {
      final noteList = await noteRepository.getAllNotes(folder);
      if (noteList.isNotEmpty) {
        final note = noteList.first;
        if ((note.title == 'New Note' || note.title.isEmpty) && note.body.isEmpty) {
          await deleteNote(note.id);
        } else {
          emit(const NoteListState(noteList: []));
          await fetchNoteList();
        }
      }
    } catch (error) {
      log('Failed to delete note', error: error);
    }
  }
}
