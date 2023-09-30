import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: [
      const Padding(padding: EdgeInsets.only(top: 50)),
      const SizedBox(
        width: 60,
        height: 60,
        child: LoadingIndicator(),
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Text(AppLocalizations.of(context)!.waiting_for_data),
      )
    ]));
  }
}
