import 'package:flutter/material.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/products/product_model.dart';
import 'package:openshelves/products/product_service.dart';
import 'package:openshelves/responsive/responsive_layout.dart';

getProductTechDataForm(Product product) {
  return Expanded(
    flex: 1,
    child: Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(border: Border.all()),
      child: Column(
        children: [
          const Text('Product Tech Data'),
          TextField(
            decoration: const InputDecoration(label: Text('Width in CM')),
            controller: TextEditingController(text: product.width.toString()),
          ),
          TextField(
            decoration: const InputDecoration(label: Text('Height in CM')),
            controller: TextEditingController(text: product.height.toString()),
          ),
          TextField(
            decoration: const InputDecoration(label: Text('Depth in CM')),
            controller: TextEditingController(text: product.depth.toString()),
          ),
          TextField(
            decoration: const InputDecoration(label: Text('Weight in Gram')),
            controller: TextEditingController(text: product.weight.toString()),
          ),
        ],
      ),
    ),
  );
}

getProductMainDataForm(Product product) {
  return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.all(20.0),
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(border: Border.all()),
        child: Form(
            child: Column(
          children: [
            const Text('Main Product Data'),

            TextField(
              decoration: const InputDecoration(label: Text('ID')),
              enabled: false,
              controller: TextEditingController(text: product.id.toString()),
            ),
            TextField(
              decoration: const InputDecoration(label: Text('Produktname')),
              controller: TextEditingController(text: product.name),
              onChanged: (value) => {product.name = value},
            ),
            TextField(
              decoration: const InputDecoration(label: Text('ASIN')),
              controller: TextEditingController(text: product.asin),
              onChanged: (value) => {product.asin = value},
            ),
            TextField(
              decoration: const InputDecoration(label: Text('EAN')),
              controller: TextEditingController(text: product.ean),
              onChanged: (value) => {product.ean = value},
            ),
            ElevatedButton(
              onPressed: () {
                storeProduct(product);
              },
              child: Container(
                  margin: const EdgeInsets.all(20.0),
                  child: const Icon(Icons.save)),
            )
            // Row(children: [
            //   Text('Active'),
            //   Switch(
            //     // This bool value toggles the switch.
            //     // value: data.active,
            //     activeColor: Colors.green,

            //     onChanged: (bool value) {
            //       // This is called when the user toggles the switch.
            //       setState(() {
            //         data.active = value;
            //       });
            //     },
            //   )
            // ])
          ],
        )),
      ));
}

class ProductPageArguments {
  final Product product;
  ProductPageArguments(this.product);
}

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);
  static const String url = 'product/form';
  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ProductPageArguments;
    if (args == null && args.product == null) {
      return Scaffold(
        appBar: openShelvesAppBar,
        body: const Center(child: Text('Error: No Product')),
      );
    }

    return ResponsiveLayout(
      mobileBody: const Text("TO BE DONE"),
      tabletBody: const Text("TO BE DONE"),
      desktopBody: Scaffold(
          // appBar: openShelvesAppBar,
          floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add), onPressed: () {}),
          body: Row(children: [
            getOpenShelvesDrawer(context),
            Expanded(flex: 1, child: getProductMainDataForm(args.product)),
            Expanded(flex: 1, child: getProductTechDataForm(args.product))
          ])),
    );
  }
}
