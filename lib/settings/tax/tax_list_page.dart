import 'package:flutter/material.dart';
import 'package:openshelves/settings/tax/models/tax_model.dart';
import 'package:openshelves/settings/tax/services/tax_service.dart';
import 'package:openshelves/widgets/drawer.dart';

class TaxListPage extends StatefulWidget {
  static const String url = 'tax/list';
  const TaxListPage({Key? key}) : super(key: key);

  @override
  State<TaxListPage> createState() => _TaxListPageState();
}

class _TaxListPageState extends State<TaxListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: openShelvesAppBar,
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add), onPressed: () {}),
        body: Row(children: [
          const OpenShelvesDrawer(),
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(30.0),
            child: FutureBuilder<List<Tax>>(
                future: getTaxes(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Error');
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading:
                                Text(snapshot.data![index].rate.toString()),
                            trailing: snapshot.data![index].defaultTax
                                ? const Icon(Icons.check)
                                : null,
                            title: Text(snapshot.data![index].name),
                            onTap: () {
                              Navigator.pushNamed(context, TaxListPage.url);
                            },
                          );
                        });
                  }
                  return const CircularProgressIndicator();
                }),
          ))
        ]));
  }
}
