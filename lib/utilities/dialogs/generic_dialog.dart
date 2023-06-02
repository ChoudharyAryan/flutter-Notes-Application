import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder optionsBuilder,
}) {
  final options = optionsBuilder();
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        elevation: 20,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(title),
        content: Text(content),
        actions: options.keys.map((optionTitle) {
          final value = options[optionTitle];
          return TextButton(            
            onPressed: () {
              if (value != null) {
                Navigator.of(context).pop(value);
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Text(optionTitle),
          );
        }).toList(),
      );
    },
  );
}
