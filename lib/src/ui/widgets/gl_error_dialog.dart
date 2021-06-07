import 'package:flutter/material.dart';
import 'package:gallery_app/src/ui/widgets/gl_dialog.dart';

Future<void> showErrorDialog(BuildContext context, String? content) async {
  if (content == null) {
    return;
  }
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return GLDialog(
        onFirstPressed: () {},
        buttonFirstTitle: 'OK',
        title: 'Thông báo lỗi',
        textContent: content,
      );
    },
  );
}
