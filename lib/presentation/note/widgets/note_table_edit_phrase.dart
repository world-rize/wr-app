import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wr_app/domain/language.dart';
import 'package:wr_app/domain/note/model/note_phrase.dart';

class EditPhrase extends StatefulWidget {
  EditPhrase({
    @required this.language,
    @required this.notePhrase,
    @required this.onSubmit,
  });

  Language language;
  NotePhrase notePhrase;
  Function(String) onSubmit;

  @override
  _EditPhraseState createState() => _EditPhraseState();
}

class _EditPhraseState extends State<EditPhrase> {
  String _tmpString;
  @override
  void initState() {
    super.initState();
    _tmpString = '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Material(
        child: Column(
          children: [
            Container(
              child: TextFormField(
                autofocus: true,
                initialValue: widget.language == Language.japanese
                    ? widget.notePhrase.japanese
                    : widget.notePhrase.english,
                decoration: InputDecoration(
                  labelText: widget.language == Language.japanese
                      ? 'Japanese'
                      : 'English',
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 5,
                onChanged: (t) {
                  _tmpString = t;
                },
              ),
            ),
            RaisedButton(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                widget.onSubmit(_tmpString);
              },
              child: Text(
                'Save',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
