import 'package:flutter/material.dart';
import 'package:openshelves/document/document_row_widget.dart';
import 'package:openshelves/document/models/document_model.dart';
import 'package:openshelves/document/services/document_service.dart';

class DocumentHeader extends StatefulWidget {
  Document document;
  final List<DocumentRowWidget> rows;
  DocumentHeader({Key? key, required this.document, required this.rows})
      : super(key: key);

  @override
  State<DocumentHeader> createState() => _DocumentHeaderState();
}

class _DocumentHeaderState extends State<DocumentHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Text('Edit Document', style: Theme.of(context).textTheme.headlineLarge),
      Text(' ID: ${widget.document.id.toString()}'),
      DropdownButton<String>(items: [
        DropdownMenuItem<String>(
          onTap: () {
            deleteDocument(widget.document).then((value) {
              // setState(() {
              //   document = value;
              // });
            }).catchError((error) {});
          },
          child: const Text('Delete'),
          value: 'Delete',
        ),
        const DropdownMenuItem<String>(
          child: Text('Document Status'),
          value: 'Document Status',
        ),
      ], onChanged: (value) {}, value: null),
      OutlinedButton(onPressed: () {}, child: const Text('Hi')),
      ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          ),
          onPressed: () {
            storeDocument(widget.document).then((value) {
              setState(() {
                widget.document = value;
              });
              widget.rows.every((element) {
                element.documentRow.documentId = widget.document.id!;
                storeDocumentRow(element.documentRow).catchError((error) {
                  throw (error);
                });
                return true;
              });
            }).catchError((error) {});
          },
          child: const Text('Save')),
    ]);
  }
}
