import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/authentication/Exceptions/auth_exception.dart';
import 'package:mahattaty/authentication/presentation/components/form_error.dart';
import 'package:mahattaty/authentication/presentation/controllers/auth_controller.dart';
import 'package:mahattaty/core/utils/open_dialogs.dart';
import 'package:mahattaty/core/utils/validations.dart';
import '../../../core/generic components/mahattaty_button.dart';
import '../../../core/generic components/mahattaty_text_form_field.dart';
import 'dialogs/forget_password.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginForm extends ConsumerWidget {
  LoginForm({super.key});

  final List<TextEditingController> _loginControllers =
      List.generate(2, (_) => TextEditingController());

  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  final List<GlobalKey<FormFieldState>> _loginKeys =
      List.generate(2, (_) => GlobalKey<FormFieldState>());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);
    final authNotifier = ref.read(authControllerProvider.notifier);
    final primaryColor = Theme.of(context).colorScheme.primary;
    final bodyMedium = Theme.of(context).textTheme.bodyMedium!;

    return Form(
      key: _loginFormKey,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MahattatyTextFormField(
              fieldKey: _loginKeys[0],
              labelText: AppLocalizations.of(context)!.emailLabel,
              controller: _loginControllers[0],
              iconData: FontAwesomeIcons.envelope,
              validator: (value) => value!.isValidEmail
                  ? null
                  : AppLocalizations.of(context)!.emailError,
              hintText: AppLocalizations.of(context)!.emailHint,
              onChanged: (value) {
                if (authState.exception != null) authNotifier.clearException();
              },
            ),
            const SizedBox(height: 20),
            MahattatyTextFormField(
              fieldKey: _loginKeys[1],
              labelText: AppLocalizations.of(context)!.passwordLabel,
              controller: _loginControllers[1],
              isPassword: true,
              iconData: FontAwesomeIcons.lock,
              hintText: AppLocalizations.of(context)!.passwordHint,
              validator: (value) => value!.isEmpty
                  ? AppLocalizations.of(context)!.passwordRequired
                  : null,
              onChanged: (value) {
                if (authState.exception != null) authNotifier.clearException();
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: () => authState.isLoading
                      ? null
                      : OpenDialogs.openCustomDialog(
                          context: context,
                          dialog: ForgetPassword(),
                        ),
                  child: Text(
                    AppLocalizations.of(context)!.forgotPassword,
                    style: bodyMedium.copyWith(color: primaryColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            FormError(
              isShow: (authState.exception != null &&
                  authState.exception!.code != AuthErrorType.unknownError &&
                  authState.exception!.action == AuthErrorAction.signIn),
              message: authState.exception != null
                  ? AppLocalizations.of(context)!.loginError
                  : '',
            ),
            const SizedBox(height: 5),
            MahattatyButton(
              text: AppLocalizations.of(context)!.signInButton,
              style: MahattatyButtonStyle.primary,
              disabled: authState.isLoading,
              onPressed: () async {
                if (_loginFormKey.currentState!.validate()) {
                  await authNotifier.signIn(
                    _loginControllers[0].text,
                    _loginControllers[1].text,
                    false,
                  );
                }
              },
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
