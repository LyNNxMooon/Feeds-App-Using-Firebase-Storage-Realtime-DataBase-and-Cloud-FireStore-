import 'package:feeds/constants/colors.dart';
import 'package:feeds/constants/dimensions.dart';
import 'package:flutter/material.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget(
      {super.key,
      required this.content,
      this.isSuccessDialog = true,
      required this.onTapOK});

  final String content;
  final bool isSuccessDialog;
  final Function onTapOK;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: isSuccessDialog
          ? const Icon(
              Icons.check_circle,
              color: kSuccessColor,
              size: kSP45x,
            )
          : const Icon(
              Icons.error,
              color: kDeleteColor,
              size: kSP45x,
            ),
      content: Text(
        content,
        textAlign: TextAlign.center,
      ),
      actions: [
        MaterialButton(
          onPressed: () {
            onTapOK();
          },
          child: const Text("OK"),
        )
      ],
    );
  }
}
