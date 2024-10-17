import 'package:flutter/material.dart';
import '../../../core/generic components/mahattaty_dialog.dart';
import '../../../core/utils/open_dialogs.dart';
import 'mahattaty_circle_icon.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void showPaymentSuccessBottomSheet(BuildContext context, Function onClose) {
  OpenDialogs.openCustomDialog(
    context: context,

    dialog: WillPopScope(
      onWillPop: () async {
        await onClose();
        return true;
      },
      child: MahattatyDialog(

        title: AppLocalizations.of(context)!.paySuccess,
        description: AppLocalizations.of(context)!.paySuccessInfo,
        content: const[
      Center(
        child: MahattatyCircleIcon(
                outerCircleRadius: 70.0,
                innerCircleRadius: 50.0,
                child: Icon(
                  Icons.credit_card_rounded,
                  color: Colors.white,
                  size: 40,
                ),
              ),
      ),
        ],
        buttonText: AppLocalizations.of(context)!.closeButton,
        onButtonPressed: () {
          Navigator.of(context).pop();
          onClose();
        },
      ),
    ),
  );
}
