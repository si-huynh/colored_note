/*
 * Created By: Sĩ Huỳnh on Monday, August 7th 2023, 1:28:06 pm
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
import 'package:folder_repository/src/folder_local_storage.dart';
import 'package:folder_repository/src/mappers/cache_to_domain.dart';
import 'package:key_value_storage/key_value_storage.dart';

class FolderRepository {
  final FolderLocalStorage _localStorage;

  FolderRepository({
    required KeyValueStorage keyValueStorage,
    @visibleForTesting FolderLocalStorage? localStorage,
  }) : _localStorage = localStorage ?? FolderLocalStorage(keyValueStorage: keyValueStorage);

  Future<void> upsertFolder(String name) async {
    return await _localStorage.upsertFolder(name);
  }

  Future<void> deleteFolder(String name) async {
    return await _localStorage.deleteFolder(name);
  }

  Future<List<Folder>> getAllFolders() async {
    final folders = await _localStorage.getAllFolders();
    return folders.map((folder) => folder.toDomainModel()).toList();
  }
}
