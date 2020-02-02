class Phrase {
  String english;
  String japanese;
  bool favorite;

  Phrase({this.english, this.japanese, this.favorite: false});
}

class Section {
  String title;
  List<Phrase> phrases;

  Section(this.title, this.phrases);
}
