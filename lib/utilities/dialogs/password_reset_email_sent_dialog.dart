import 'package:flutter/material.dart';
import 'package:flutter_sem_2/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetEmailSentDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Password reset',
    content: "We've sent you an reset password link",
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
