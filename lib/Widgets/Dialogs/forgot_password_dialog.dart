import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/Providers/auth_provider.dart';
import 'package:mahattaty/Utils/open_dialog.dart';
import 'package:mahattaty/Utils/validate.dart';
import 'package:mahattaty/Widgets/Dialogs/otp_dialog.dart';
import 'package:share/share.dart';
import '../Generics/mahattaty_dialog.dart';
import '../Generics/mahattaty_text_form_field.dart';

class ForgetPasswordDialog extends ConsumerWidget {
  ForgetPasswordDialog({super.key});
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MahattatyDialog(
      title: 'Forget Password',
      description: 'Enter your email to reset your password',
      content: [
        MahattatyTextFormField(
          labelText: 'Email',
          iconData: FontAwesomeIcons.envelope,
          hintText: 'Enter your email',
          validator: (value) => value!.isValidEmail
              ? null
              : 'Invalid Input, Please enter a valid email or phone number',
          controller: emailController,
        ),
        const SizedBox(height: 10),
      ],
      buttonText: 'Send Email',
      contentPlacement: ContentPlacement.afterTitle,
      onButtonPressed: () async {
        final email = emailController.text.trim();
        if (email.isValidEmail) {
          String dynamicLink = await _createDynamicLink(email);
          Share.share("Reset your password: $dynamicLink");

        }
      },
    );
  }
}

Future<String> _createDynamicLink(String email) async {
  final DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: "https://mahattaty.page.link",
    link: Uri.parse("https://mahattaty.com/reset?email=$email"),
    androidParameters: const AndroidParameters(
      packageName: "com.example.mahattaty",
      minimumVersion: 0,
    ),
    iosParameters: const IOSParameters(
      bundleId: "com.example.mahattaty",
      minimumVersion: "0",
    ),
  );
  final shortLink = await FirebaseDynamicLinks.instance.buildShortLink(parameters);
  return shortLink.shortUrl.toString();
}
