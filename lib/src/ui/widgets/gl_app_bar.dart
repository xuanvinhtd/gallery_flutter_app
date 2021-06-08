import 'package:flutter/material.dart';

class GLAppBar extends StatelessWidget with PreferredSizeWidget {
  const GLAppBar(
      {Key? key,
      this.title,
      this.actions = const [],
      this.isEnableBackButton = false,
      this.onPressed})
      : preferredSize = const Size.fromHeight(50.0),
        super(key: key);

  @override
  final Size preferredSize;

  final String? title;
  final List<Widget> actions;
  final bool isEnableBackButton;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
      title: Text(title ?? '',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: Theme.of(context).primaryColor)),
      automaticallyImplyLeading: true,
      leading: isEnableBackButton
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back,
              ),
              onPressed: onPressed ??
                  () {
                    Navigator.pop(context);
                  },
            )
          : null,
      centerTitle: true,
      actions: actions,
    );
  }
}
