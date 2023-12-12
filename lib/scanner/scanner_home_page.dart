import 'package:flutter/material.dart';
import 'package:openshelves/scanner/income/income_form.dart';
import 'package:openshelves/widgets/drawer.dart';

class ScannerHomePage extends StatelessWidget {
  static const url = 'scanner-home';
  const ScannerHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Scanner')),
        drawer: const OpenShelvesDrawer(),
        body: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.qr_code_scanner),
              title: const Text('Incoming'),
              onTap: () {
                Navigator.pushNamed(context, IncomePage.url);
              },
            ),
            // ListTile(
            //   leading: const Icon(Icons.qr_code_scanner),
            //   title: const Text('Scan to Warehouse'),
            //   onTap: () {
            //     Navigator.pushNamed(context, '/scanner-to-warehouse');
            //   },
            // ),
            // ListTile(
            //   leading: const Icon(Icons.qr_code_scanner),
            //   title: const Text('Scan to Warehouse Place'),
            //   onTap: () {
            //     Navigator.pushNamed(context, '/scanner-to-warehouse-place');
            //   },
            // ),
            // ListTile(
            //   leading: const Icon(Icons.qr_code_scanner),
            //   title: const Text('Scan to Product'),
            //   onTap: () {
            //     Navigator.pushNamed(context, '/scanner-to-product');
            //   },
            // ),
          ],
        ));
  }
}
