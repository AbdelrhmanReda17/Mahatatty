import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mahattaty/core/utils/app_localizations_extension.dart';

class LegalAndPoliciesScreen extends StatelessWidget {
  const LegalAndPoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onSecondary,

        title: Text(AppLocalizations.of(context)!.legal),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                AppLocalizations.of(context)!.termsAndConditionsLabel,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing:  Text(
                AppLocalizations.of(context)!.arabicOrEnglish('1 / 10 / 2022'),
              ),
            ),
            const SizedBox(height: 8),
             Text(
              AppLocalizations.of(context)!.termsAndConditionsContent,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              title: Text(
                AppLocalizations.of(context)!.changesToTheServiceAndOrTerms,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing:  Text(
                AppLocalizations.of(context)!.arabicOrEnglish('1 / 11 / 2022'),
              ),
            ),
            const SizedBox(height: 8),
             Text(
              AppLocalizations.of(context)!.changesToTheServiceAndOrTermsContent,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
             ListTile(
              contentPadding:const EdgeInsets.all(0),
              title: Text(
                AppLocalizations.of(context)!.privacyPolicyLabel,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text(
                AppLocalizations.of(context)!.arabicOrEnglish('1 / 12 / 2022'),
              ),
            ),
            const SizedBox(height: 8),
             Text(
              AppLocalizations.of(context)!.privacyPolicyContent,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
