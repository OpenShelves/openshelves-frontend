import 'package:flutter/material.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/document/document_row_widget.dart';
import 'package:openshelves/document/models/document_model.dart';
import 'package:openshelves/document/models/document_row_model.dart';
import 'package:openshelves/document/services/document_service.dart';
import 'package:openshelves/document/widgets/document_header_widget.dart';
import 'package:openshelves/widgets/drawer.dart';

class DocumentPage extends StatefulWidget {
  // final Store<AppState> store;
  final int? id;
  static const String url = 'documents';
  const DocumentPage({Key? key, this.id}) : super(key: key);

  @override
  State<DocumentPage> createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  final _formKey = GlobalKey<FormState>();
  Document document = Document(
    documentType: 1,
    documentStatus: 1,
    documentDate: DateTime.now(),
  );

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: document.documentDate,
        firstDate: DateTime(2023, 1),
        lastDate: DateTime(2101));
    if (picked != null && picked != document.documentDate) {
      setState(() {
        document.documentDate = picked;
      });
    }
  }

  List<DocumentRowWidget> rows = [];
  // [
  //   DocumentRowWidget(
  //     documentRow: DocumentRowModel(
  //       documentId: 1,
  //       pos: 1,
  //       productName: '',
  //     ),
  //   )
  // ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.id != null) {
      getDocumentById(widget.id.toString()).then((value) {
        setState(() {
          document = value;
        });
      });

      getDocumentRowsByDocumentId(widget.id.toString()).then((value) {
        setState(() {
          rows = value
              .map((e) => DocumentRowWidget(
                    documentRow: e,
                  ))
              .toList();
        });
      });
    }
  }

  var item = const DropdownMenuItem<Map<int, String>>(child: Text('asd'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: openShelvesAppBar,
        drawer: const OpenShelvesDrawer(),
        body: Row(children: [
          const OpenShelvesDrawer(),
          Expanded(
              flex: 1,
              child: Container(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DocumentHeader(document: document, rows: rows),
                      Expanded(
                          child: ListView(
                        shrinkWrap: true,
                        children: [
                          Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                      'DocDate: ${document.documentDate.toIso8601String()}'),
                                  Text('DocStatis: ${docStatus[7]}'),
                                  DropdownButton(
                                      value: document.documentStatus,
                                      items: docStatus.entries
                                          .map((e) => DropdownMenuItem(
                                              value: e.key,
                                              child: Text(e.value.toString())))
                                          .toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          document.documentStatus =
                                              value as int;
                                        });
                                      }),
                                  ElevatedButton(
                                      onPressed: () {
                                        _selectDate(context);
                                      },
                                      child: const Icon(Icons.calendar_today)),
                                  ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          rows.add(DocumentRowWidget(
                                              documentRow: DocumentRowModel(
                                                  documentId: 1,
                                                  pos: rows.length + 1,
                                                  productName: '')));
                                        });
                                      },
                                      child: const Text('add Row')),
                                  // ElevatedButton(
                                  //     onPressed: () {
                                  //       rows.every((element) {
                                  //         element.documentRow.documentId =
                                  //             document.id!;
                                  //         storeDocumentRow(element.documentRow)
                                  //             .catchError((error) {
                                  //           print(error);
                                  //         });
                                  //         print(element.documentRow.toString());
                                  //         return true;
                                  //       });
                                  //     },
                                  //     child: const Text('save all')),
                                  // ElevatedButton(
                                  //     onPressed: () {
                                  //       storeDocument(document).then((value) {
                                  //         setState(() {
                                  //           document = value;
                                  //         });
                                  //         rows.every((element) {
                                  //           element.documentRow.documentId =
                                  //               document.id!;
                                  //           storeDocumentRow(
                                  //                   element.documentRow)
                                  //               .catchError((error) {
                                  //             throw (error);
                                  //           });
                                  //           return true;
                                  //         });
                                  //       }).catchError((error) {});
                                  //     },
                                  //     child: const Text('save doc')),
                                  // ElevatedButton(
                                  //     onPressed: () {
                                  //       deleteDocument(document).then((value) {
                                  //         // setState(() {
                                  //         //   document = value;
                                  //         // });
                                  //       }).catchError((error) {});
                                  //     },
                                  //     child: const Text('delete doc')),
                                  Column(children: rows),
                                ],
                              ))
                        ],
                      )),
                    ],
                  )))
        ]));
  }
}
