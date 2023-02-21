import 'package:flutter/material.dart';

class DataCellCurrency extends StatefulWidget {
  final num currcency;
  final String currencySymbol;
  const DataCellCurrency(
      {Key? key, required this.currcency, required this.currencySymbol})
      : super(key: key);

  @override
  State<DataCellCurrency> createState() => _DataCellCurrencyState();
}

class _DataCellCurrencyState extends State<DataCellCurrency> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerRight,
        child: Text(
          '${widget.currcency} ${widget.currencySymbol}',
          textAlign: TextAlign.right,
        ));
  }
}
