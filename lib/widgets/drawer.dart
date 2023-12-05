import 'package:flutter/material.dart';
import 'package:openshelves/document/document_list_page.dart';
import 'package:openshelves/document/document_page.dart';
import 'package:openshelves/home.dart';
import 'package:openshelves/login/login.dart';
import 'package:openshelves/products/list/product_list_page.dart';
import 'package:openshelves/scanner/income/income_form.dart';
import 'package:openshelves/settings/settings_list_page.dart';
import 'package:openshelves/warehouse/warehouse_list_page.dart';
import 'package:openshelves/warehouseplace/warehouseplace_list_page.dart';

class OpenShelvesDrawer extends StatelessWidget {
  const OpenShelvesDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.grey[300],
        child: Column(
          children: [
            Text(
              'OpenShelves',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const Divider(
              height: 10,
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('L O G I N'),
              onTap: () {
                Navigator.pushNamed(context, LoginPage.url);
              },
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('D A S H B O A R D'),
              onTap: () {
                Navigator.pushNamed(context, HomePage.url);
              },
            ),
            ListTile(
              leading: const Icon(Icons.table_rows),
              title: const Text('P R O D U C T S'),
              onTap: () {
                Navigator.pushNamed(context, ProductPage.url);
              },
            ),
            // ListTile(
            //   leading: const Icon(Icons.warehouse),
            //   title: const Text('W A R E H O U S E'),
            //   onTap: () {
            //     Navigator.pushNamed(context, WarhouseForm.url);
            //   },
            // ),
            ListTile(
              leading: const Icon(Icons.warehouse),
              title: const Text('W A R E H O U S E S'),
              onTap: () {
                Navigator.pushNamed(context, WarehouseListPage.url);
              },
            ),
            ListTile(
              leading: const Icon(Icons.library_books),
              title: const Text('W A R E H O U S E PLACE'),
              onTap: () {
                Navigator.pushNamed(context, WarehousePlaceListPage.url);
              },
            ),
            ListTile(
              leading: const Icon(Icons.qr_code),
              title: const Text('I N C O M I N G'),
              onTap: () {
                Navigator.pushNamed(context, IncomePage.url);
              },
            ),
            ListTile(
              leading: const Icon(Icons.file_open),
              title: const Text('D O C U M E N T S'),
              onTap: () {
                Navigator.pushNamed(context, DocumentListPage.url);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('S E T T I N G S'),
              onTap: () {
                Navigator.pushNamed(context, SettingsListPage.url);
              },
            ),
            // const ListTile(
            //   leading: Icon(Icons.shopping_basket),
            //   title: Text('O R D E R S'),
            //   // trailing: Icon(Icons.add),
            // ),
            // const ListTile(
            //   leading: Icon(Icons.settings),
            //   title: Text('S E T T I N G S'),
            // )
          ],
        ));
  }
}
