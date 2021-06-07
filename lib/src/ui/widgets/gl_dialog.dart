import 'package:flutter/material.dart';
import 'package:gallery_app/src/ui/widgets/gl_button.dart';

class GLDialog extends StatelessWidget {
  const GLDialog(
      {Key? key,
      this.onFirstPressed,
      this.onSecondPressed,
      this.textContent = '',
      this.title = '',
      this.buttonFirstTitle = '',
      this.buttonSecondTitle = ''})
      : super(key: key);
  final void Function()? onFirstPressed;
  final void Function()? onSecondPressed;
  final String title;
  final String textContent;
  final String buttonFirstTitle;
  final String buttonSecondTitle;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const SizedBox(
            height: 18,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.60),
            child: TextField(
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  ?.copyWith(color: Colors.grey[600]),
              controller: TextEditingController(text: textContent),
              readOnly: true,
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              textInputAction: TextInputAction.newline,
              keyboardType: TextInputType.multiline,
              minLines: null,
              maxLines: null,
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.grey[800]),
                contentPadding: const EdgeInsets.all(10),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabled: true,
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              onSecondPressed != null
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8, bottom: 8),
                      child: GLButton(
                        buttonSecondTitle,
                        onPressed: () {
                          onSecondPressed!();
                          Navigator.of(context).pop(true);
                        },
                        size: Size(110, 40),
                        borderRadius: 20,
                        backgroundColor: Theme.of(context).primaryColor,
                        borderColor: Theme.of(context).primaryColor,
                        style: Theme.of(context)
                            .textTheme
                            .button
                            ?.copyWith(color: Colors.white),
                      ),
                    )
                  : SizedBox(),
              onFirstPressed != null
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8, bottom: 8),
                        child: GLButton(
                          buttonFirstTitle,
                          onPressed: () {
                            onFirstPressed!();
                            Navigator.of(context).pop(false);
                          },
                          size: Size(110, 40),
                          borderRadius: 20,
                          backgroundColor: Theme.of(context).primaryColor,
                          borderColor: Theme.of(context).primaryColor,
                          style: Theme.of(context).textTheme.button?.copyWith(
                              color: Theme.of(context).backgroundColor),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          )
        ],
      ),
    );
  }
}
