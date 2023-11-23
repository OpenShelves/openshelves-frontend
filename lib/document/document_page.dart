import 'package:flutter/material.dart';
import 'package:openshelves/document/document_row_widget.dart';
import 'package:openshelves/document/models/document_model.dart';
import 'package:openshelves/document/models/document_row_model.dart';
import 'package:openshelves/document/services/document_service.dart';
import 'package:openshelves/settings/tax/services/tax_service.dart';
import 'package:openshelves/state/appstate.dart';
import 'package:openshelves/widgets/drawer.dart';
import 'package:redux/redux.dart';

class DocumentPage extends StatefulWidget {
  final Store<AppState> store;
  static const String url = 'documents';
  const DocumentPage({Key? key, required this.store}) : super(key: key);

  @override
  State<DocumentPage> createState() => _DocumentPageState();
}

class _DocumentPageState extends State<DocumentPage> {
  final _formKey = GlobalKey<FormState>();
  final _addressFormKey = GlobalKey<FormState>();

  List<DocumentRowWidget> rows = [
    DocumentRowWidget(
      documentRow: DocumentRowModel(
        documentId: 1,
        pos: 1,
        productName: '',
      ),
    )
  ];
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
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
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
                                  child: Text('add Row')),
                              ElevatedButton(
                                  onPressed: () {
                                    rows.every((element) {
                                      storeDocumentRow(element.documentRow)
                                          .catchError((error) {
                                        print(error);
                                      });
                                      print(element.documentRow.toString());
                                      return true;
                                    });
                                  },
                                  child: Text('save all')),
                              ElevatedButton(
                                  onPressed: () {
                                    storeDocument(Document(
                                      documentType: 1,
                                      documentStatus: 1,
                                      documentNumber: '1',
                                      documentDate: DateTime.now(),
                                    )).catchError((error) {});
                                  },
                                  child: Text('save doc')),
                              Column(children: rows),
                            ],
                          ))
                    ],
                  )))
        ]));
  }
}
