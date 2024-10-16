import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/features/settings/presentation/controllers/settings_controller.dart';
import '../../../../core/generic components/mahattaty_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ChangeLanguageDialog extends ConsumerStatefulWidget {
  const ChangeLanguageDialog({super.key});

  @override
  MahattatyLangState createState() => MahattatyLangState();
}
class MahattatyLangState extends ConsumerState<ChangeLanguageDialog> {
  int selectedLanguage = 0;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final surfaceColor = Theme.of(context).colorScheme.surface;
    final onSurfaceColor = Theme.of(context).colorScheme.onSurface;

    return MahattatyDialog(
      title: AppLocalizations.of(context)!.selectLanguage,
      description: AppLocalizations.of(context)!.selectLanguageDescription,
      content: [
        CupertinoPicker(
          itemExtent: 50,
          onSelectedItemChanged: (index) {
            setState(() {
              selectedLanguage = index;
            });
          },
          selectionOverlay: Container(
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          backgroundColor: surfaceColor,
          useMagnifier: true,
          children: [
            for (var language in [AppLocalizations.of(context)!.language, AppLocalizations.of(context)!.otherLanguage])
              Center(
                child: Text(
                  language,
                  style: TextStyle(
                    color: onSurfaceColor,
                    fontSize: 20,
                  ),
                ),
              ),
          ],
        ),
      ],
      buttonText: 'Save',
      onButtonPressed: () {
        Navigator.pop(context);
        ref.read(settingsControllerProvider.notifier).changeLanguage(
          selectedLanguage == 0 ? AppLocalizations.of(context)!.languageCode : AppLocalizations.of(context)!.otherLanguageCode,
        );
      },
    );
  }
}
