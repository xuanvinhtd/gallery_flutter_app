import 'package:flutter/material.dart';
import 'package:gallery_app/src/config/app_constant.dart';

class GLButton extends StatelessWidget {
  GLButton(this.text,
      {Key? key,
      this.onPressed,
      this.size = const Size(double.infinity, 50),
      this.backgroundColor = Colors.white,
      this.style = const TextStyle(color: Colors.black),
      this.borderWidth = 1,
      this.borderColor = Colors.black,
      this.borderRadius = 25,
      this.imgUrl,
      this.scale = 2.5})
      : super(key: key);
  final void Function()? onPressed;
  final String? text;
  final String? imgUrl;
  final Size size;
  final Color backgroundColor;
  final TextStyle? style;
  final double borderWidth;
  final Color borderColor;
  final double borderRadius;
  final double scale;
  DateTime? _clickTime;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed != null
          ? () {
              if (_canClick(DateTime.now())) {
                onPressed!();
              }
            }
          : null,
      style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          minimumSize: size,
          shape: RoundedRectangleBorder(
              side: BorderSide(width: borderWidth, color: borderColor),
              borderRadius: BorderRadius.circular(borderRadius))),
      child: imgUrl == null
          ? Text(text ?? '', style: style)
          : Image.asset(
              imgUrl ?? '',
              scale: scale,
            ),
    );
  }

  bool _canClick(DateTime currentTime) {
    if (_clickTime == null) {
      _clickTime = currentTime;
      return true;
    }
    if (currentTime.difference(_clickTime!).inSeconds <
        AppConstant.kPeriodTimeClick) {
      _clickTime = currentTime;
      return false;
    }
    _clickTime = currentTime;
    return true;
  }
}
