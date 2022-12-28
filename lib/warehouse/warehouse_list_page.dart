import 'package:flutter/material.dart';
import 'package:openshelves/address_model.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/responsive/responsive_layout.dart';
import 'package:openshelves/warehouse/warehouse_form.dart';
import 'package:openshelves/warehouse/warehouse_model.dart';
import 'package:openshelves/warehouse/warehouse_service.dart';

class WarehouseListPage extends StatefulWidget {
  const WarehouseListPage({Key? key}) : super(key: key);
  static const String url = 'warehouses';

  @override
  State<WarehouseListPage> createState() => _WarehouseListPageState();
}

getList() {}

class _WarehouseListPageState extends State<WarehouseListPage> {
  getList() {
    return Row(children: [
      getOpenShelvesDrawer(context),
      Expanded(
          child: FutureBuilder<List<Warehouse>>(
        future: getProducts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index].name),
                    subtitle: Text(snapshot.data![index].address.name1 +
                        ' ' +
                        snapshot.data![index].address.city.toString()),
                    onTap: () {
                      print('go');
                      Navigator.pushNamed(context, WarhouseForm.url,
                          arguments:
                              WarehousePageArguments(snapshot.data![index]));
                    },
                  );
                });
            // print(snapshot.data);
            return Text("data");
          }
          return Center(child: CircularProgressIndicator());
        },
      ))
    ]);
  }

  Future<List<Warehouse>> getProducts = getWarehouses();

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
        mobileBody: Scaffold(
            appBar: openShelvesAppBar,
            drawer: getOpenShelvesDrawer(context),
            body: getList()),
        tabletBody: Scaffold(
            appBar: openShelvesAppBar,
            drawer: getOpenShelvesDrawer(context),
            body: getList()),
        desktopBody: Scaffold(
            floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(context, WarhouseForm.url,
                      arguments: WarehousePageArguments(
                          Warehouse(name: '', address: Address(name1: ''))));
                }),
            body: getList()));
  }
}

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:openshelves/constants.dart';
// import 'package:openshelves/products/product_form.dart';
// import 'package:openshelves/products/product_model.dart';
// import 'package:openshelves/products/product_service.dart';
// import 'package:openshelves/responsive/responsive_layout.dart';

// class ProductPage extends StatefulWidget {
//   const ProductPage({Key? key}) : super(key: key);
//   static const String url = 'product';

//   @override
//   State<ProductPage> createState() => _ProductPageState();
// }

// class _ProductPageState extends State<ProductPage> {
//   Future<List<Product>> getProduct = getProducts();

//   createDataTableRows(List<Product> products, context) {
//     print("print rows");
//     List<DataRow> rows = [];
//     var i = 0;
//     products.forEach((product) {
//       var color = i % 2 == 0 ? Colors.grey[100] : Colors.grey[200];
//       i++;
//       rows.add(DataRow(
//           color: MaterialStateProperty.resolveWith<Color?>(
//               (Set<MaterialState> states) {
//             // All rows will have the same selected color.
//             if (states.contains(MaterialState.selected)) {
//               return Theme.of(context).colorScheme.primary.withOpacity(0.08);
//             }
//             // Even rows will have a grey color.
//             if (i % 2 == 0) {
//               return color;
//             }
//           }),
//           cells: [
//             DataCell(
//               IconButton(
//                   icon: const Icon(Icons.edit),
//                   onPressed: () {
//                     Navigator.pushNamed(context, ProductFormPage.url,
//                         arguments: ProductPageArguments(product));
//                   }),
//             ),
//             DataCell(
//               Text(product.id.toString()),
//             ),
//             DataCell(Text(product.sku.toString())),
//             DataCell(
//               Text(product.name),
//             ),
//             DataCell(
//               Text(product.price.toString()),
//             ),
//             DataCell(
//               Text(product.ean.toString()),
//             ),
//             DataCell(
//               Text(product.width.toString()),
//             ),
//             DataCell(
//               Text(product.height.toString()),
//             ),
//             DataCell(
//               Text(product.depth.toString()),
//             ),
//             DataCell(
//               Text(product.weight.toString()),
//             ),
//             DataCell(
//               Checkbox(value: product.active, onChanged: (value) {}),
//             ),
//           ]));
//     });
//     print("rows");
//     return rows;
//   }

//   getList() {
//     return FutureBuilder<List<Product>>(
//       future: getProduct,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return ListView.builder(
//             itemCount: snapshot.data!.length,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 leading: Text(snapshot.data![index].id.toString()),
//                 title: Text(snapshot.data![index].name),
//                 subtitle: Row(
//                   children: [
//                     const Text('Price: '),
//                     Text(snapshot.data![index].price.toString()),
//                     const Text(' / Sku: '),
//                     Text(snapshot.data![index].sku.toString()),
//                     const Text(' / Active: '),
//                     Text(snapshot.data![index].active.toString())
//                   ],
//                 ),
//               );
//             },
//           );
//         } else if (snapshot.hasError) {
//           return const Text('Fehler');
//         } else {
//           return loadingData;
//         }
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveLayout(
//         mobileBody: Scaffold(
//             appBar: openShelvesAppBar,
//             drawer: getOpenShelvesDrawer(context),
//             body: getList()),
//         tabletBody: Scaffold(
//             appBar: openShelvesAppBar,
//             drawer: getOpenShelvesDrawer(context),
//             body: getList()),
//         desktopBody: Scaffold(
//             floatingActionButton: FloatingActionButton(
//                 child: const Icon(Icons.add),
//                 onPressed: () {
//                   Navigator.pushNamed(context, ProductFormPage.url,
//                       arguments: ProductPageArguments(Product(name: '')));
//                 }),
//             body: Row(children: [
//               getOpenShelvesDrawer(context),
//               Expanded(
//                 child: ListView(children: [
//                   TextField(
//                     decoration: const InputDecoration(
//                         prefixIcon: Icon(Icons.search),
//                         hintText: 'At least 3 Characters'),
//                     onChanged: (value) => {
//                       if (value.length > 2)
//                         {
//                           setState(() {
//                             getProduct = searchProducts(value);
//                           }),
//                         },
//                       if (value.isEmpty)
//                         {
//                           setState(() {
//                             getProduct = getProducts();
//                           })
//                         },
//                     },
//                   ),
//                   FutureBuilder<List<Product>>(
//                     future: getProduct,
//                     builder: (context, snapshot) {
//                       if (snapshot.hasData) {
//                         return DataTable(columns: const [
//                           DataColumn(label: Expanded(child: Text('#'))),
//                           DataColumn(label: Expanded(child: Text('ID'))),
//                           DataColumn(label: Expanded(child: Text('SKU'))),
//                           DataColumn(
//                               label: Expanded(child: Text('Productname'))),
//                           DataColumn(label: Expanded(child: Text('Price'))),
//                           DataColumn(label: Expanded(child: Text('EAN'))),
//                           DataColumn(label: Expanded(child: Text('Width'))),
//                           DataColumn(label: Expanded(child: Text('Height'))),
//                           DataColumn(label: Expanded(child: Text('Depth'))),
//                           DataColumn(label: Expanded(child: Text('Weight'))),
//                           DataColumn(label: Expanded(child: Text('Active'))),
//                         ], rows: createDataTableRows(snapshot.data!, context));
//                       } else if (snapshot.hasError) {
//                         return const Text('Fehler');
//                       } else {
//                         return loadingData;
//                       }
//                     },
//                   ),
//                 ]),
//               )
//             ])));
//   }
// }
