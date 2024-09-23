import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/Providers/States/auth_state.dart';
import 'package:mahattaty/Providers/auth_provider.dart';
import 'package:mahattaty/Screens/temp_screen.dart';
import 'package:mahattaty/Utils/open_screens.dart';
import 'package:mahattaty/Utils/validate.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_alert.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_button.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_text_form_field.dart';

class RegisterForm extends ConsumerWidget {
  RegisterForm({super.key});

  final List<TextEditingController> _registerControllers =
      List.generate(4, (_) => TextEditingController());
  final List<GlobalKey<FormFieldState>> _registerKeys =
      List.generate(4, (_) => GlobalKey<FormFieldState>());
  final GlobalKey<FormState> _registerFromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    ref.listen<AuthState>(authProvider, (previous, next) {
      if (next.error != null &&
          (next.error!.type == AuthErrorType.unknown ||
              next.error!.type == AuthErrorType.networkError)) {
        mahattatyAlertDialog(
          context,
          message: next.error!.message ?? 'An error occurred',
          type: MahattatyAlertType.error,
          onOk: () => authNotifier.resetState(),
        );
      }
    });
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Form(
          onPopInvokedWithResult: (_, __) {
            authNotifier.resetState();
          },
          key: _registerFromKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MahattatyTextFormField(
                fieldKey: _registerKeys[0],
                labelText: 'Full Name',
                controller: _registerControllers[0],
                iconData: FontAwesomeIcons.user,
                hintText: 'Enter your Full Name',
                validator: (value) => value!.isValidUsername
                    ? null
                    : 'Invalid Input , must be at least 3 characters',
                onChanged: (value) => _registerKeys[0].currentState!.validate(),
              ),
              const SizedBox(height: 20),
              MahattatyTextFormField(
                fieldKey: _registerKeys[1],
                labelText: 'Email or Phone Number',
                controller: _registerControllers[1],
                iconData: FontAwesomeIcons.envelope,
                hintText: 'Enter your email or phone number',
                errorText: authState.error?.type == AuthErrorType.emailOrPhone &&
                        authState.error?.action == AuthAction.signUp

                    ? authState.error?.message
                    : null,
                validator: (value) => value!.isValidPhoneOrEmail
                    ? null
                    : 'Invalid Input  , must be a valid email or phone number',
                onChanged: (value) => _registerKeys[1].currentState!.validate(),
              ),
              const SizedBox(height: 20),
              MahattatyTextFormField(
                fieldKey: _registerKeys[2],
                labelText: 'Password',
                controller: _registerControllers[2],
                isPassword: true,
                errorText: authState.error?.type == AuthErrorType.password
                    ? authState.error?.message
                    : null,
                iconData: FontAwesomeIcons.lock,
                hintText: 'Create your password',
                validator: (value) => value!.isValidPassword
                    ? null
                    : 'Invalid Input , must be at least 8 characters With at least one uppercase letter, one lowercase letter',
                onChanged: (value) {
                  _registerKeys[2].currentState!.validate();
                  _registerKeys[3].currentState!.validate();
                },
              ),
              const SizedBox(height: 20),
              MahattatyTextFormField(
                fieldKey: _registerKeys[3],
                labelText: 'Confirm Password',
                controller: _registerControllers[3],
                isPassword: true,
                iconData: FontAwesomeIcons.lock,
                hintText: 'Confirm your password',
                validator: (value) =>
                    value!.isValidConfirmPassword(_registerControllers[2].text)
                        ? null
                        : 'Invalid Input , must be the same as the password',
                onChanged: (value) => _registerKeys[3].currentState!.validate(),
              ),
              const SizedBox(height: 20),
              MahattatyButton(
                text: 'Sign Up',
                style: MahattatyButtonStyle.primary,
                disabled: authState.isLoading,
                onPressed: () async {
                  if (_registerFromKey.currentState!.validate()) {
                    bool isRegistered = await authNotifier.submitRegister(
                      name: _registerControllers[0].text,
                      email: _registerControllers[1].text,
                      password: _registerControllers[2].text,
                    );
                    if (isRegistered) {
                      openScreen(
                        context: context,
                        routeName: const TempScreen().routeName,
                        isReplace: true,
                      );
                    }
                  }
                },
                height: 60,
              ),
            ],
          ),
        );
      },
    );
  }
}
