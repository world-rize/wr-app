import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/user/model/user.dart';
import 'package:wr_app/infrastructure/note/note_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wr_app/infrastructure/util/versioning.dart';

void main() {
  const userUuid = 'test';
  var store = MockFirestoreInstance();
  var repo = NoteRepository(store: store);
  var uc = store.latest.collection('users');
  var nc = uc.doc(userUuid).collection('notes');

  setUp(() async {
    store = MockFirestoreInstance();
    repo = NoteRepository(store: store);
    uc = store.latest.collection('users');
    nc = uc.doc(userUuid).collection('notes');
    final initialUser = User.create()..uuid = userUuid;
    print('setup');

    await uc.doc(initialUser.uuid).set(initialUser.toJson());
    final defaultNote = Note.create(title: 'default', isDefault: true);
    final achievedNote = Note.create(title: 'achieved', isAchieved: true);
    await nc.doc(defaultNote.id).set(defaultNote.toJson());
    await nc.doc(achievedNote.id).set(achievedNote.toJson());
  });

  group('NoteRepository', () {
    test('createNote', () async {
      final initialUser = User.create()..uuid = userUuid;
      var notes = await repo.getAllNotes(user: initialUser);
      expect(notes.length, 2);
      final note = Note.create(title: 'ほげノート')..id = 'hoge';
      await repo.createNote(note: note, user: initialUser);

      notes = await repo.getAllNotes(user: initialUser);
      expect(notes.length, 3);
    });

    test('deleteNote', () async {
      final initialUser = User.create()..uuid = userUuid;
      final note = Note.create(title: 'ほげノート')..id = 'hoge';

      await repo.createNote(note: note, user: initialUser);
      var notes = await repo.getAllNotes(user: initialUser);
      expect(notes.length, 3);

      await repo.deleteNote(user: initialUser, note: note);

      notes = await repo.getAllNotes(user: initialUser);
      expect(notes.length, 2);
    });

    test('updateNote', () async {
      final initialUser = User.create()..uuid = userUuid;
      final note = Note.create(title: 'ほげノート')..id = 'hoge';
      await repo.createNote(note: note, user: initialUser);
      note.title = 'ほげほげ';

      await repo.updateNote(user: initialUser, note: note);

      final notes = await repo.getAllNotes(user: initialUser);
      expect(notes['hoge'].title, 'ほげほげ');
    });
  });
}
