import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:openshelves/scanner/income/models/income_model.dart';

class IncomePopMenu extends StatefulWidget {
  final IncomingModel incomingModel;
  final Function(IncomingModel) onQuantityChanged;
  const IncomePopMenu(
      {Key? key, required this.incomingModel, required this.onQuantityChanged})
      : super(key: key);

  @override
  State<IncomePopMenu> createState() => _IncomePopMenuState();
}

class _IncomePopMenuState extends State<IncomePopMenu> {
  TextEditingController quantityController = TextEditingController();
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
                            content: Text(widget.incomingModel.product.name),
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
                  quantityController.text =
                      widget.incomingModel.quantity.toString(),
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          actions: [
                            OutlinedButton(
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.red)),
                                child: Text(AppLocalizations.of(context)!
                                    .cancel_button),
                                onPressed: () {
                                  Navigator.pop(
                                      context, 'QUANTITY_CHANGED_CANCELED');
                                }),
                            OutlinedButton(
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.green)),
                                child: Text(
                                    AppLocalizations.of(context)!.ok_button),
                                onPressed: () {
                                  Navigator.pop(context, 'QUANTITY_CHANGED');
                                })
                          ],
                          title: Text(
                              AppLocalizations.of(context)!.changeQuantity),
                          content: Column(children: [
                            Text(widget.incomingModel.product.name),
                            TextFormField(
                              controller: quantityController,
                              onChanged: (value) {},
                              autofocus: true,
                              keyboardType: TextInputType.number,
                            )
                          ]),
                        );
                      }).then((value) {
                    widget.incomingModel.quantity =
                        int.parse(quantityController.text);
                    widget.onQuantityChanged(widget.incomingModel);
                  })
                },
            });
  }
}
