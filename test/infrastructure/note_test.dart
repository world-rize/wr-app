import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wr_app/domain/user/index.dart';
import 'package:wr_app/infrastructure/note/note_persistence.dart';

void main() {
  final store = MockFirestoreInstance();
  final noteRepo = NoteRepository(firestore: store);

  // TODO: テストを書く
  // setUp(() async {
  //   print('setup');
  //   final initialUser = repo.generateInitialUser('test');

  //   final favList = repo.generateFavoriteList(listId: 'favlist', title: '');
  //   final note = repo.generateNote(noteId: 'note', title: '');
  //   final streakResult = List.generate(100, (index) {
  //     final date = Jiffy().subtract(duration: Duration(days: index ~/ 3));
  //     return TestResult(sectionId: '', score: 1, date: date.toIso8601String());
  //   });

  //   initialUser
  //     ..notes[note.id] = note
  //     ..favorites[favList.id] = favList
  //     ..statistics.testResults = streakResult;

  //   await store.setUser(initialUser);
  // });

  // group('User Repository', () {
  //   test('readUser', () async {
  //     final user = await repo.readUser(uuid: 'test');
  //     final uuid = (await store.getUser('test')).uuid;
  //     expect(uuid, user.uuid);
  //   });
  // });
}
