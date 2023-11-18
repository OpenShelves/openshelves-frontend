import 'package:flutter/material.dart';
import 'package:openshelves/document/document_row.dart';
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
                          child: const Column(
                            children: [
                              // Expanded(
                              //     child: AddressForm(
                              //   address: Address(name1: ''),
                              //   onSubmit: (p0) => {},
                              //   formKey: _addressFormKey,
                              // ))
                              DocumentRow()
                            ],
                          ))
                    ],
                  )))
        ]));
  }
}
