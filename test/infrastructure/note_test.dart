import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/user/model/user.dart';
import 'package:wr_app/infrastructure/note/note_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wr_app/infrastructure/util/versioning.dart';

void main() {
  final store = MockFirestoreInstance();
  final repo = NoteRepository(store: store);
  const userUuid = 'test';
  final uc = store.latest.collection('users');

  setUp(() async {
    final initialUser = User.create()..uuid = userUuid;
    print('setup');

    await uc.doc(initialUser.uuid).set(initialUser.toJson());
  });

  tearDown(() async {
    await uc.doc(userUuid).delete();
  });

  group('NoteRepository', () {
    test('createNote', () async {
      final initialUser = User.create()..uuid = userUuid;
      expect(initialUser.notes.length, 2);
      final note = Note.create(title: 'ほげノート')..id = 'hoge';
      await repo.createNote(note: note, user: initialUser);

      final userSnapshot = await uc.doc(initialUser.uuid).get();
      final user = User.fromJson(userSnapshot.data());

      expect(user.notes.length, 3);
    });

    test('deleteNote', () async {
      final initialUser = User.create()..uuid = userUuid;
      final note = Note.create(title: 'ほげノート')..id = 'hoge';
      await repo.createNote(note: note, user: initialUser);
      await repo.deleteNote(user: initialUser, note: note);

      final userSnapshot = await uc.doc(initialUser.uuid).get();
      final user = User.fromJson(userSnapshot.data());

      expect(user.notes.length, 2);
    });

    test('updateNote', () async {
      final initialUser = User.create()..uuid = userUuid;
      final note = Note.create(title: 'ほげノート')..id = 'hoge';
      await repo.createNote(note: note, user: initialUser);
      note.title = 'ほげほげ';

      await repo.updateNote(user: initialUser, note: note);
      final userJson = await uc
          .doc(initialUser.uuid)
          .get()
          .then((value) => value.data());
      final user = User.fromJson(userJson);

      expect(user.notes['hoge'].title, 'ほげほげ');
    });
  });
}
