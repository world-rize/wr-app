// Copyright © 2020 WorldRIZe. All rights reserved.

import 'package:data_classes/data_classes.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/user/model/user.dart';

abstract class INoteRepository {
  Future<Note> createNote({@required User user, @required Note note});

  Future<Note> updateNote({@required User user, @required Note note});

  Future<void> deleteNote({@required User user, @required Note note});

  Future<Map<String, Note>> getAllNotes({@required User user});
}
