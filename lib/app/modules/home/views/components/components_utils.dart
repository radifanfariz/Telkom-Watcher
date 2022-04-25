import 'package:flutter/cupertino.dart';

class ComponentUtils {

      static void showCupertinoSheet(BuildContext context, {
            required Widget child,
            required VoidCallback onClicked,
      }) =>
          showCupertinoModalPopup(
              context: context,
              builder: (context) =>
              CupertinoActionSheet(
                    actions: [
                          child,
                    ],
                    cancelButton: CupertinoActionSheetAction(
                          child: Text("Done"),
                          onPressed: onClicked,
                    ),
              ));
}