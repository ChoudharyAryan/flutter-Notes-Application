import 'package:flutter/material.dart';
import 'package:flutter_sem_2/utilities/dialogs/generic_dialog.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext  context) {
  return showGenericDialog(
    context: context,
    title: 'Sharing',
    content: 'You can not share an empty note!',
    optionsBuilder: () => {'Ok': Null},
  );
}
