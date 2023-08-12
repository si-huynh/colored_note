/*
 * Created By: Sĩ Huỳnh on Thursday, August 10th 2023, 11:51:57 am
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
import 'package:note_compose/src/note_compose_state.dart';
import 'package:note_repository/note_repository.dart';

class NoteComposeCubit extends Cubit<NoteComposeState> {
  NoteComposeCubit({
    required this.id,
    required this.noteRepository,
  }) : super(const NoteComposeEmpty()) {
    _performLoad();
  }

  final NoteRepository noteRepository;
  final String id;

  Future<void> _performLoad() async {
    try {
      final content = await noteRepository.getContent(id);
      emit(NoteComposeLoaded(content: content));
    } catch (error) {
      log('Failed to fetch note', error: error);
    }
  }

  Future<void> saveChanges(List<dynamic> content, {bool changed = false}) async {
    try {
      final note = await noteRepository.getNoteByID(id);
      await noteRepository.updateContent(content, note, changed: changed);
    } catch (error) {
      log('Failed to update content for note');
    }
  }
}
