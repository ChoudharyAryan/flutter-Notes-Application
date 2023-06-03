import 'package:flutter/material.dart';
import 'package:flutter_sem_2/services/auth/auth_service.dart';
import 'package:flutter_sem_2/utilities/dialogs/cannot_share_empty_note_dialog.dart';
import 'package:flutter_sem_2/utilities/generics/get_arguments.dart';
import 'package:flutter_sem_2/services/cloud/cloud_note.dart';
import 'package:flutter_sem_2/services/cloud/firebase_cloud_storage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';

class CreateUpdateNoteView extends StatefulWidget {
  const CreateUpdateNoteView({Key? key}) : super(key: key);

  @override
  State<CreateUpdateNoteView> createState() => _CreateUpdateNoteViewState();
}

class _CreateUpdateNoteViewState extends State<CreateUpdateNoteView> {
  CloudNote? _note;
  late final FirebaseCloudStorage _notesService;
  late final TextEditingController _textController;

  @override
  void initState() {
    _notesService = FirebaseCloudStorage();
    _textController = TextEditingController();
    super.initState();
  }

  void _textControllerListner() async {
    final note = _note;
    if (note == null) {
      return;
    }
    final text = _textController.text;
    await _notesService.updateNote(documentId: note.documentId,
    text: text,
    );
  }

  void _setupTextControllerListner() {
    _textController.removeListener(_textControllerListner);
    _textController.addListener(_textControllerListner);
  }

  Future<CloudNote> createOrGetExistingNote(BuildContext context) async {
    final widgetNote = context.getArgument<CloudNote>();

    if (widgetNote != null) {
      _note = widgetNote;
      _textController.text = widgetNote.text;
      return widgetNote;
    }

    final existingnote = _note;
    if (existingnote != null) {
      return existingnote;
    }
    final currentUser = AuthService.firebase().currentuser!;
    final userId = currentUser.id;
    final newNote = await _notesService.createNewNote(ownerUserId: userId);
    _note = newNote;
    return newNote;
  }

  void _deleteIfTextIsEmpty() {
    final note = _note;
    if (_textController.text.isEmpty && note != null) {
      _notesService.deleteNote(documentId:note.documentId);
    }
  }

  void _saveIfTextNotEmpty() async {
    final note = _note;
    final text = _textController.text;
    if (note != null && text.isNotEmpty) {
      await _notesService.updateNote(documentId: note.documentId,
      text: text,
      );
    }
  }

  @override
  void dispose() {
    _deleteIfTextIsEmpty();
    _saveIfTextNotEmpty();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(      
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(18),
                bottomRight: Radius.circular(18))),
        centerTitle: true,        
        title: const Text('New Note'),
        actions: [
          IconButton(onPressed: () async {
            final text = _textController.text;
            if(_note == null || text.isEmpty){
              await showCannotShareEmptyNoteDialog(context);
            }else{
              Share.share(text);
            }
          },
          icon: const FaIcon(FontAwesomeIcons.share),
          ),
        ],
      ),
      body: FutureBuilder(
          future: createOrGetExistingNote(context),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _textController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      hintText: 'Start writing...',
                    ),
                  ),
                );
              default:
                return const  SpinKitCircle(
                      color: Colors.blue,
                      size: 50.0,
                    );
            }
          }),
    );
  }
}
