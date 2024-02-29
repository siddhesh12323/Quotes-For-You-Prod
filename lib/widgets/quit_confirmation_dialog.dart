import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<dynamic> showQuitConfirmationDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Quit App'),
        content: Text('Are you sure you want to quit the app?'),
        actions: [
          TextButton(
            onPressed: () {
              // User wants to cancel, close the dialog
              Navigator.of(context).pop(false);
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // User confirmed, close the dialog and return true
              // Navigator.of(context).pop(true);
              SystemNavigator.pop();
            },
            child: Text('Quit'),
          ),
        ],
      );
    },
  );
}
