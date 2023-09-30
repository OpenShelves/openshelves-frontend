import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:openshelves/products/models/product_model.dart';

class IncomePopmenu extends StatelessWidget {
  final Product product;
  const IncomePopmenu({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        itemBuilder: (context) {
          return [
            PopupMenuItem(
              child: Text(AppLocalizations.of(context)!.delete_entry),
              value: 'deleteItem',
            ),
            PopupMenuItem(
                child: Text(AppLocalizations.of(context)!.changeQuantity),
                value: 'changeQuantity')
          ];
        },
        onSelected: (String value) => {
              if (value == 'deleteItem')
                {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            title: Text(
                                AppLocalizations.of(context)!.confirm_delete +
                                    '?'),
                            content: Text(product.name),
                            actions: <Widget>[
                              OutlinedButton(
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.red)),
                                  child: Text(AppLocalizations.of(context)!
                                      .cancel_button),
                                  onPressed: () {
                                    Navigator.pop(context, 'DELETE_CANCEL');
                                  }),
                              OutlinedButton(
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.green)),
                                  child: Text(
                                      AppLocalizations.of(context)!.ok_button),
                                  onPressed: () {
                                    Navigator.pop(context, 'DELETE_OK');
                                  })
                            ]);
                      })
                }
              else if (value == 'changeQuantity')
                {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(
                              AppLocalizations.of(context)!.changeQuantity),
                          content: Column(children: [
                            Text(product.name),
                            TextField(
                              onChanged: (value) {},
                              onSubmitted: (value) {
                                Navigator.pop(context, value);
                              },
                              autofocus: true,
                              keyboardType: TextInputType.number,
                            )
                          ]),
                        );
                      })
                },
            });
  }
}
