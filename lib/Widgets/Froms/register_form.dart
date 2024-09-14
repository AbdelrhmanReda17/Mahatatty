import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mahattaty/Widgets/Generics/mahattaty_text_form_field.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final List<TextEditingController> _registerControllers =
      List.generate(4, (_) => TextEditingController());

  @override
  void dispose() {
    for (var controller in _registerControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MahattatyTextFormField(
                labelText: 'Full Name',
                controller: _registerControllers[0],
                iconData: FontAwesomeIcons.user,
                hintText: 'Enter your Full Name',
              ),
              const SizedBox(height: 20),
              MahattatyTextFormField(
                labelText: 'Email or Phone Number',
                controller: _registerControllers[1],
                iconData: FontAwesomeIcons.envelope,
                hintText: 'Enter your email or phone number',
              ),
              const SizedBox(height: 20),
              MahattatyTextFormField(
                labelText: 'Password',
                controller: _registerControllers[2],
                isPassword: true,
                iconData: FontAwesomeIcons.lock,
                hintText: 'Create your password',
              ),
              const SizedBox(height: 20),
              MahattatyTextFormField(
                labelText: 'Confirm Password',
                controller: _registerControllers[3],
                isPassword: true,
                iconData: FontAwesomeIcons.lock,
                hintText: 'Confirm your password',
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Checkbox(
                    value: true,
                    onChanged: (bool? value) {},
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
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
