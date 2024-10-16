import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/authentication/presentation/controllers/auth_controller.dart';
import 'package:mahattaty/core/utils/validations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/generic components/mahattaty_alert.dart';
import '../../../../core/generic components/mahattaty_dialog.dart';
import '../../../../core/generic components/mahattaty_text_form_field.dart';
import '../../../Exceptions/auth_exception.dart';
import '../form_error.dart';

class ForgetPassword extends ConsumerWidget {
  ForgetPassword({super.key});

  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _forgetPasswordFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authNotifier = ref.watch(authControllerProvider.notifier);
    final authState = ref.watch(authControllerProvider);
    return PopScope(
      canPop: authState.isLoading != true,
      onPopInvokedWithResult: (_, __) =>
          authState.exception != null ? authNotifier.clearException() : null,
      child: MahattatyDialog(
        title: AppLocalizations.of(context)!.forgotPasswordTitle,
        description: AppLocalizations.of(context)!.forgotPasswordSubtitle,
        content: [
          Form(
            key: _forgetPasswordFormKey,
            child: MahattatyTextFormField(
              labelText: AppLocalizations.of(context)!.emailLabel,
              iconData: FontAwesomeIcons.envelope,
              hintText: AppLocalizations.of(context)!.emailHint,
              validator: (value) => value!.isValidEmail
                  ? null
                  : AppLocalizations.of(context)!.emailError,
              controller: emailController,
              onChanged: (value) =>
                  _forgetPasswordFormKey.currentState!.validate(),
            ),
          ),
          const SizedBox(height: 10),
          FormError(
            isShow: (authState.exception != null &&
                authState.exception!.code != AuthErrorType.unknownError &&
                authState.exception!.action == AuthErrorAction.forgetPassword),
            message: authState.exception != null
                ? AppLocalizations.of(context)!.forgotError
                : '',
          ),
          const SizedBox(height: 5),
        ],
        buttonText: AppLocalizations.of(context)!.resetPasswordButton,
        contentPlacement: ContentPlacement.afterTitle,
        disabled: authState.isLoading,
        onButtonPressed: () async {
          if (!_forgetPasswordFormKey.currentState!.validate()) return;
          final result =
              await authNotifier.forgetPassword(emailController.text);
          if (result) {
            mahattatyAlertDialog(
              context,
              message: AppLocalizations.of(context)!.resetPasswordSuccess +
                  emailController.text,
              type: MahattatyAlertType.success,
              onOk: () => Navigator.of(context).pop(),
            );
          }
        },
      ),
    );
  }
}
