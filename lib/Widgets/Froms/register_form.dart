import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/Data/user_repository.dart';
import 'package:mahattaty/Models/user.dart';
import 'package:mahattaty/Utils/validate.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_button.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_text_form_field.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final List<TextEditingController> _registerControllers =
      List.generate(4, (_) => TextEditingController());
  final List<GlobalKey<FormFieldState>> _registerKeys =
      List.generate(4, (_) => GlobalKey<FormFieldState>());
  final GlobalKey<FormState> _registerFromKey = GlobalKey<FormState>();
  bool isAcceptTerms = false;
  void _handleCheckBox(bool? value) {
    if (value == null) return;
    setState(() {
      isAcceptTerms = value;
    });
  }

  @override
  void dispose() {
    for (var controller in _registerControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void registerUser() async {
    try {
      await UserRepositoy().registerUser(
        User(
          name: _registerControllers[0].text,
          emailOrPhone: _registerControllers[1].text,
          password: _registerControllers[2].text,
        ),
      );
      log('User Registered Successfully');
    } catch (error) {
      log('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Form(
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
                iconData: FontAwesomeIcons.lock,
                hintText: 'Create your password',
                validator: (value) => value!.isValidPassword
                    ? null
                    : 'Invalid Input , must be at least 8 characters With at least 1 uppercase letter, 1 lowercase letter, 1 number and 1 special character',
                onChanged: (value) => _registerKeys[2].currentState!.validate(),
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: isAcceptTerms,
                    onChanged: _handleCheckBox,
                  ),
                  Expanded(
                    child: RichText(
                      textAlign: TextAlign.left,
                      text: TextSpan(
                        text: 'I accept the ',
                        style: Theme.of(context).textTheme.titleSmall,
                        children: [
                          TextSpan(
                            text: 'Terms & Conditions & Privacy\nPolicy',
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.apply(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          TextSpan(
                            text: ' set out by Mahattaty',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              MahattatyButton(
                text: 'Sign Up',
                style: MahattatyButtonStyle.primary,
                onPressed: () {
                  if (!_registerFromKey.currentState!.validate() ||
                      !isAcceptTerms) return;
                  registerUser();
                },
                height: 50,
              ),
            ],
          ),
        );
      },
    );
  }
}
