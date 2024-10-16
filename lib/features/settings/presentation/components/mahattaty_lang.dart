import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahattaty/features/settings/presentation/controllers/settings_controller.dart';
import '../../../../core/generic components/mahattaty_dialog.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class MahattatyLang extends ConsumerStatefulWidget {
  const MahattatyLang({super.key});

  @override
  MahattatyLangState createState() => MahattatyLangState();
}
class MahattatyLangState extends ConsumerState<MahattatyLang> {
  int selectedLanguage = 0;

  @override
  Widget build(BuildContext context) {
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
              color: Theme.of(context)
                  .colorScheme
                  .primary
                  .withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.surface,
          useMagnifier: true,
          children: [
            for (var language in [AppLocalizations.of(context)!.language, AppLocalizations.of(context)!.otherLanguage])
              Center(
                child: Text(
                  language,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
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
