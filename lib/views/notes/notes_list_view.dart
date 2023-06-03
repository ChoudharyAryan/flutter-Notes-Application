import 'package:flutter/material.dart';
import 'package:flutter_sem_2/services/cloud/cloud_note.dart';
import 'package:flutter_sem_2/utilities/dialogs/delete_dialog.dart';

typedef NoteCallback = void Function(CloudNote note);

class NotesListView extends StatelessWidget {
  final Iterable<CloudNote> notes;
  final NoteCallback onDeleteNote;
  final NoteCallback ontap;

  const NotesListView({
    Key? key,
    required this.notes,
    required this.onDeleteNote,
    required this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notes.length,
      itemBuilder: (context, index) {
        final note = notes.elementAt(index);
        return ListTile(
          onTap: () {
            ontap(note);
          },
          title: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6),),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.only(right: 15,left: 15,top: 23,bottom: 23),
              child: Text(
                note.text,
                maxLines: 1,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          trailing: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6),),
            elevation: 2,
            child: IconButton(
              onPressed: () async {
                final shouldDelete = await showDeleteDialog(context);
                if (shouldDelete) {
                  onDeleteNote(note);
                }
              },
              icon: const Icon(Icons.delete_outline_rounded),
            ),
          ),
        );
      },
    );
  }
}
