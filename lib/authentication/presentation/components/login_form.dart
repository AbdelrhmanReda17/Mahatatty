import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/authentication/Exceptions/auth_exception.dart';
import 'package:mahattaty/authentication/presentation/controllers/auth_controller.dart';
import 'package:mahattaty/core/utils/open_dialogs.dart';
import 'package:mahattaty/core/utils/validations.dart';
import '../../../core/generic components/mahattaty_button.dart';
import '../../../core/generic components/mahattaty_text_form_field.dart';
import 'dialogs/forget_password.dart';

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
              labelText: 'Email ',
              controller: _loginControllers[0],
              iconData: FontAwesomeIcons.envelope,
              errorText:
                  authState.exception?.action == AuthErrorAction.signIn &&
                          authState.exception?.code == AuthErrorType.emailError
                      ? authState.exception?.message
                      : null,
              validator: (value) => value!.isValidPhoneOrEmail
                  ? null
                  : 'Invalid Input, Please enter a valid email ',
              hintText: 'Enter your email',
            ),
            const SizedBox(height: 20),
            MahattatyTextFormField(
              fieldKey: _loginKeys[1],
              labelText: 'Password',
              controller: _loginControllers[1],
              isPassword: true,
              errorText: authState.exception?.action ==
                          AuthErrorAction.signIn &&
                      authState.exception?.code == AuthErrorType.passwordError
                  ? authState.exception?.message
                  : null,
              iconData: FontAwesomeIcons.lock,
              hintText: 'Create your password',
              validator: (value) =>
                  value!.isEmpty ? 'Password is required' : null,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Spacer(),
                GestureDetector(
                  onTap: () => OpenDialogs.openCustomDialog(
                    context: context,
                    dialog: ForgetPassword(),
                  ),
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16.5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            MahattatyButton(
              text: 'Sign In',
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
