import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:jiffy/jiffy.dart';
import 'package:wr_app/domain/lesson/model/favorite_phrase_list.dart';
import 'package:wr_app/domain/lesson/model/test_result.dart';
import 'package:wr_app/domain/note/model/note.dart';
import 'package:wr_app/domain/user/model/user.dart';
import 'package:wr_app/infrastructure/note/note_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final store = MockFirestoreInstance();
  final repo = NoteRepository(store: store);

  const userUuid = 'test';
  setUp(() async {
    final initialUser = User.create()..uuid = userUuid;
    print('setup');

    await store
        .collection('users')
        .doc(initialUser.uuid)
        .set(initialUser.toJson());
  });

  tearDown(() async {
    await store.collection('users').doc(userUuid).delete();
  });

  group('User Repository', () {
    //Future<Note> createNote({
    test('createNote', () async {
      final initialUser = User.create()..uuid = userUuid;
      expect(initialUser.notes.length, 2);
      final note = Note.create(title: 'ほげノート')..id = 'hoge';
      await repo.createNote(note: note, user: initialUser);
      final userSnapshot =
          await store.collection('users').doc(initialUser.uuid).get();
      final user = User.fromJson(userSnapshot.data());
      expect(user.notes.length, 3);
    });

    // Future<void> deleteNote({@required User user, @required Note note}) {
    test('deleteNote', () async {
      final initialUser = User.create()..uuid = userUuid;
      final note = Note.create(title: 'ほげノート')..id = 'hoge';
      await repo.createNote(note: note, user: initialUser);
      await repo.deleteNote(user: initialUser, note: note);
      final userSnapshot =
          await store.collection('users').doc(initialUser.uuid).get();
      final user = User.fromJson(userSnapshot.data());
      expect(user.notes.length, 2);
    });

    test('updateNote', () async {
      final initialUser = User.create()..uuid = userUuid;
      final note = Note.create(title: 'ほげノート')..id = 'hoge';
      await repo.createNote(note: note, user: initialUser);
      note.title = 'ほげほげ';

      await repo.updateNote(user: initialUser, note: note);
      final userJson = await store
          .collection('users')
          .doc(initialUser.uuid)
          .get()
          .then((value) => value.data());
      final user = User.fromJson(userJson);
      expect(user.notes['hoge'].title, 'ほげほげ');
    });
  });
}
