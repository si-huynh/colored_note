/*
 * Created By: Sĩ Huỳnh on Wednesday, August 9th 2023, 8:14:21 pm
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

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:note_compose/src/note_compose_cubit.dart';
import 'package:note_compose/src/note_compose_state.dart';
import 'package:rxdart/rxdart.dart';

class NoteComposeView extends StatefulWidget {
  const NoteComposeView({super.key, required this.noteID});

  final String noteID;

  @override
  State<NoteComposeView> createState() => _NoteComposeViewState();
}

class _NoteComposeViewState extends State<NoteComposeView> {
  QuillController? _quillController;

  bool _isEditted = false;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: BlocConsumer<NoteComposeCubit, NoteComposeState>(
        builder: (context, state) {
          if (state is NoteComposeLoaded && _quillController != null) {
            return SafeArea(
              child: _buildEditorAndToolBar(),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        listener: (context, state) {
          if (state is NoteComposeLoaded) {
            _loadNoteContent(state.content);
          }
        },
      ),
    );
  }

  Widget _buildEditorAndToolBar() {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: QuillEditor.basic(
              controller: _quillController!,
              readOnly: false,
              autoFocus: false,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: QuillToolbar.basic(
            controller: _quillController!,
            showFontFamily: false,
            showCodeBlock: false,
            showAlignmentButtons: false,
            showCenterAlignment: false,
            showQuote: false,
            showLink: false,
            showListBullets: false,
            showUndo: false,
            showRedo: false,
            showDividers: false,
            showInlineCode: false,
            showIndent: false,
            showSubscript: false,
            showSuperscript: false,
            showListCheck: false,
            showSearchButton: false,
            showDirection: false,
            showListNumbers: false,
            showBackgroundColorButton: false,
            showSmallButton: false,
            showHeaderStyle: true,
            showClearFormat: true,
          ),
        ),
      ],
    );
  }

  _loadNoteContent(List<dynamic> content) async {
    final template = await rootBundle.loadString('assets/note_template.json');
    final document =
        content.isEmpty ? Document.fromJson(jsonDecode(template)) : Document.fromJson(content);
    setState(() {
      _quillController = QuillController(
        document: document,
        selection: const TextSelection.collapsed(offset: 0),
      );

      _quillController!.changes.debounceTime(const Duration(milliseconds: 1000)).listen((e) {
        if (_isEditted == false) {
          setState(() {
            _isEditted = true;
          });
        }
        _performSaveChanges(e);
      });
    });
  }

  _performSaveChanges(DocChange e) async {
    if (e.source == ChangeSource.LOCAL) {
      final cubit = context.read<NoteComposeCubit>();
      final content = _quillController!.document.toDelta().toJson();
      await cubit.saveChanges(content, changed: _isEditted);
    }
  }

  Future<bool> _onWillPop() async {
    final delta = _quillController!.document.toDelta();
    await _performSaveChanges(DocChange(delta, delta, ChangeSource.LOCAL));
    return true;
  }
}
