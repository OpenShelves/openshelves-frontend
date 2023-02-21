import 'package:flutter/material.dart';

class DataCellNumber extends StatefulWidget {
  final num number;
  final String? trailing;
  const DataCellNumber({Key? key, required this.number, this.trailing})
      : super(key: key);

  @override
  State<DataCellNumber> createState() => _DataCellNumberState();
}

class _DataCellNumberState extends State<DataCellNumber> {
  @override
  Widget build(BuildContext context) {
    var text = '${widget.number}';
    if (widget.trailing != null) {
      text += ' ${widget.trailing}';
    }
    return Container(
        alignment: Alignment.centerRight,
        child: Text(
          text,
          textAlign: TextAlign.right,
        ));
  }
}
