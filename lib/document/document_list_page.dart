import 'package:flutter/material.dart';
import 'package:openshelves/document/document_page.dart';
import 'package:openshelves/document/models/document_model.dart';
import 'package:openshelves/document/services/document_service.dart';
import 'package:openshelves/state/appstate.dart';
import 'package:openshelves/widgets/drawer.dart';
import 'package:redux/redux.dart';

class DocumentListPage extends StatefulWidget {
  static const String url = 'document/list';
  final Store<AppState> store;
  const DocumentListPage({Key? key, required this.store}) : super(key: key);

  @override
  State<DocumentListPage> createState() => _DocumentListPageState();
}

class _DocumentListPageState extends State<DocumentListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: openShelvesAppBar,
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, DocumentPage.url + '/new');
            }),
        body: Row(children: [
          const OpenShelvesDrawer(),
          Expanded(
              child: Container(
                  padding: const EdgeInsets.all(30.0),
                  child: FutureBuilder<List<Document>>(
                      future: getAllDocuments(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context,
                                        DocumentPage.url +
                                            '/${snapshot.data![index].id}');
                                  },
                                  leading:
                                      Text(snapshot.data![index].id.toString()),
                                  title: Text(snapshot
                                      .data![index].documentNumber
                                      .toString()),
                                  subtitle: Text(snapshot
                                      .data![index].documentDate
                                      .toString()),
                                );
                              });
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      })))
        ]));
  }
}
