import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GenerateSubWarehousePlaces extends StatelessWidget {
  const GenerateSubWarehousePlaces({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(itemBuilder: (context) {
      return [
        PopupMenuItem(
          child: Text(AppLocalizations.of(context)!.delete_entry),
          value: 'deleteItem',
        ),
        PopupMenuItem(
            child: Text(AppLocalizations.of(context)!.changeQuantity),
            value: 'changeQuantity')
      ];
    });
  }
}
