/*
 * Created By: Sĩ Huỳnh on Saturday, August 12th 2023, 11:22:26 am
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
import 'package:intl/intl.dart';

class NoteListItemGroup {
  final String name;
  final int order;

  NoteListItemGroup(this.name, this.order);
}

class NoteListItem implements Comparable<NoteListItem> {
  final String id;
  final String title;
  final DateTime time;

  late final NoteListItemGroup group;

  NoteListItem(this.id, this.title, this.time) : super() {
    group = _createGroupByTime(time);
  }

  factory NoteListItem.fromDomainModel(Note note) {
    return NoteListItem(note.id, note.title, note.updatedDate);
  }

  NoteListItemGroup _createGroupByTime(DateTime time) {
    final today = DateTime.now();
    final diff = today.difference(time);
    if (diff.inHours < 24) return NoteListItemGroup('Today', 0);
    if (diff.inDays == 1) return NoteListItemGroup('Yesterday', 1);
    if (time.month == today.month) return NoteListItemGroup('This Month', 2);
    if (time.year == today.year) {
      int diffMonth = today.month - time.month - 1;
      return NoteListItemGroup(DateFormat.MMMM().format(time), 3 + diffMonth);
    }
    return NoteListItemGroup(DateFormat.y().format(time), time.year);
  }

  @override
  int compareTo(NoteListItem other) {
    return time.compareTo(other.time);
  }
}
