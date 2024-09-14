import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Generics/mahattaty_circle_icon.dart';
import '../Generics/mahattaty_dialog.dart';
import '../Generics/mahattaty_text_form_field.dart';
import 'new_password_dialog.dart';

void RegisterSuccessDialog(BuildContext context) {
  TextEditingController emailController = TextEditingController();

  showModalBottomSheet(
    backgroundColor: Theme.of(context).colorScheme.background,
    elevation: 0,
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    isScrollControlled: true,
    builder: (BuildContext context) {
      return MahattatyDialog(
        title: 'Register Success',
        description: 'Congratulations! your account already created. Please login to get amazing experience.',
        content: [
          Center(
            child: MahattatyCircleIcon(
              innerCircleColor: Color(0xff00d261),
              child: Icon(
                Icons.check_circle,    // Using a single icon
                size: 40,
                color: Theme.of(context).colorScheme.primaryContainer,

              ),
              // Required
            ),
          )
        ],
        buttonText: 'Go to HomePage',
        onButtonPressed: () {
          Navigator.of(context).pop();

          //home page
        },
        contentPlacement: ContentPlacement.beforeTitle,

      );
    },
  );
}
