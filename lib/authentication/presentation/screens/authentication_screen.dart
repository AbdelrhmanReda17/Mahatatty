import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/authentication/Exceptions/auth_exception.dart';
import 'package:mahattaty/authentication/presentation/controllers/auth_controller.dart';
import '../../../core/generic components/mahattaty_alert.dart';
import '../../../core/utils/open_screens.dart';
import '../../../features/screens/root_screen.dart';
import '../components/login_form.dart';
import '../components/register_form.dart';
import '../components/social_account_login.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AuthenticationScreen extends ConsumerStatefulWidget {
  const AuthenticationScreen({super.key = const Key('login_screen')});

  String get loginRouteName => '/authentication/login';

  String get registerRouteName => '/authentication/register';

  @override
  AuthenticationScreenState createState() => AuthenticationScreenState();
}

class AuthenticationScreenState extends ConsumerState<AuthenticationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _controller!.forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final headLineSmall = Theme.of(context).textTheme.headlineSmall!;
    final bodyMedium = Theme.of(context).textTheme.bodyMedium!;
    final onPrimaryContainerColor =
        Theme.of(context).colorScheme.onPrimaryContainer;
    final primaryColor = Theme.of(context).colorScheme.primary;
    bool isLogin =
        ModalRoute.of(context)!.settings.name == widget.loginRouteName ||
            widget.key == const Key('login_screen');
    Widget content = isLogin ? LoginForm() : RegisterForm();
    ref.listen<AuthState>(
      authControllerProvider,
      (previous, next) {
        if (next.exception != null &&
            next.exception!.code == AuthErrorType.unknownError) {
          mahattatyAlertDialog(
            context,
            message: next.exception!.action == AuthErrorAction.forgetPassword
                ? AppLocalizations.of(context)!.resetPasswordError
                : AppLocalizations.of(context)!.generalError,
            type: MahattatyAlertType.error,
          );
        }
        if (next.user != null) {
          OpenScreen.open(
            context: context,
            routeName: const RootScreen().homeRouteName,
            isNamed: true,
            isReplace: true,
          );
        }
      },
    );

    return Scaffold(
      body: FadeTransition(
        opacity: Tween<double>(begin: 0, end: 1).animate(_controller!).drive(
              CurveTween(curve: Curves.easeInOut),
            ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            AppBar(
              centerTitle: false,
              titleSpacing: 0,
              title: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  text: isLogin
                      ? '${AppLocalizations.of(context)!.loginTitle}\n'
                      : '${AppLocalizations.of(context)!.registerTitle}\n',
                  style: headLineSmall.copyWith(fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: isLogin
                          ? AppLocalizations.of(context)!.loginSubtitle
                          : AppLocalizations.of(context)!.registerSubtitle,
                      style:
                          bodyMedium.copyWith(color: onPrimaryContainerColor),
                    ),
                  ],
                ),
              ),
              automaticallyImplyLeading: false,
            ),
            const SizedBox(height: 8),
            content,
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  isLogin
                      ? AppLocalizations.of(context)!.registerQuestion
                      : AppLocalizations.of(context)!.loginQuestion,
                  style: bodyMedium,
                ),
                TextButton(
                  onPressed: ref.watch(authControllerProvider).isLoading == true
                      ? null
                      : () {
                          ref
                              .read(authControllerProvider.notifier)
                              .clearException();
                          OpenScreen.open(
                            context: context,
                            screen: isLogin
                                ? const AuthenticationScreen(
                                    key: Key('register_screen'),
                                  )
                                : const AuthenticationScreen(
                                    key: Key('login_screen'),
                                  ),
                            isReplace: true,
                          );
                        },
                  child: Text(
                    isLogin
                        ? AppLocalizations.of(context)!.signUpButton
                        : AppLocalizations.of(context)!.signInButton,
                    style: bodyMedium.copyWith(
                      color: primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            const SocialAccountsLogin(),
            const SizedBox(height: 8),
            if (!isLogin)
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: AppLocalizations.of(context)!.termsAndConditions,
                  style: bodyMedium,
                  children: [
                    TextSpan(
                      text:
                          AppLocalizations.of(context)!.termsAndConditionsLink,
                      style: bodyMedium.apply(
                        color: primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
