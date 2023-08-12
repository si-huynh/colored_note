/*
 * Created By: Sĩ Huỳnh on Wednesday, August 9th 2023, 2:10:47 pm
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
import 'package:flutter/foundation.dart';
import 'package:key_value_storage/key_value_storage.dart';
import 'package:note_repository/src/mappers/cache_to_domain.dart';
import 'package:note_repository/src/mappers/domain_to_cache.dart';
import 'package:note_repository/src/note_local_storage.dart';

class NoteRepository {
  NoteRepository({
    required KeyValueStorage keyValueStorage,
    @visibleForTesting NoteLocalStorage? localStorage,
  }) : _localStorage = localStorage ?? NoteLocalStorage(keyValueStorage: keyValueStorage);

  final NoteLocalStorage _localStorage;

  Future<void> upsertNote(Note note) async {
    final cacheModel = note.toCacheModel();
    return await _localStorage.upsertNote(cacheModel);
  }

  Future<String> newCraftNode({String folder = 'All'}) async {
    final note = Note.craft(folder: folder);
    await upsertNote(note);
    return note.id;
  }

  Future<List<Note>> getAllNotes(String folder) async {
    final notes = await _localStorage.getNotesByFolder(folder);
    notes.sort((a, b) => b.updatedDate.compareTo(a.updatedDate));
    return notes.map((note) => note.toDomainModel()).toList();
  }

  Future<Note> getNoteByID(String id) async {
    final noteCM = await _localStorage.getNoteByID(id);
    return noteCM.toDomainModel();
  }

  Future<List<dynamic>> getContent(String id) async {
    final noteCM = await _localStorage.getNoteByID(id);
    return noteCM.content;
  }

  Future<void> deleteNoteByID(String id) async {
    return await _localStorage.deleteNoteByID(id);
  }

  Future<void> updateContent(List<dynamic> content, Note note, {bool changed = false}) async {
    final cacheModel = note.toCacheModel(
      content: content,
      changed: changed,
    );
    return await _localStorage.upsertNote(cacheModel);
  }
}
