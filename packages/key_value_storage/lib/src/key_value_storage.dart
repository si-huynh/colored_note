/*
 * Created By: Sĩ Huỳnh on Monday, August 7th 2023, 11:35:10 am
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
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:key_value_storage/src/models/models.dart';
import 'package:path_provider/path_provider.dart';

class KeyValueStorage {
  static const _folderBoxKey = 'folder';
  static const _noteBoxKey = 'note';

  final HiveInterface _hive;

  KeyValueStorage({
    @visibleForTesting HiveInterface? hive,
  }) : _hive = hive ?? Hive {
    try {
      _hive
        ..registerAdapter(FolderCMAdapter())
        ..registerAdapter(NoteCMAdapter());
    } catch (_) {
      throw Exception(
          'You shouldn\'t have more than one [KeyValueStorage] instance in your project');
    }
  }

  Future<Box<FolderCM>> get folderBox => _openHiveBox(_folderBoxKey, isTemporary: true);

  Future<Box<NoteCM>> get noteBox => _openHiveBox(_noteBoxKey, isTemporary: true);

  Future<Box<T>> _openHiveBox<T>(String boxKey, {required bool isTemporary}) async {
    if (_hive.isBoxOpen(boxKey)) {
      return _hive.openBox(boxKey);
    } else {
      final directory =
          await (isTemporary ? getTemporaryDirectory() : getApplicationDocumentsDirectory());
      return _hive.openBox(
        boxKey,
        path: directory.path,
      );
    }
  }
}
