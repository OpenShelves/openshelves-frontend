import 'package:flutter/material.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/products/product_service.dart';
import 'package:openshelves/responsive/responsive_layout.dart';

var productTechDataForm = Expanded(
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
          // readOnly: editMode,
          // controller: TextEditingController(text: data.width.toString()),
        ),
        TextField(
          decoration: const InputDecoration(label: Text('Height in CM')),
          // readOnly: editMode,
          // controller: TextEditingController(text: data.height.toString()),
        ),
        TextField(
          decoration: const InputDecoration(label: Text('Depth in CM')),
          // readOnly: editMode,
          // controller: TextEditingController(text: data.depth.toString()),
        ),
        TextField(
          decoration: const InputDecoration(label: Text('Weight in Gram')),
          // readOnly: editMode,
          // controller: TextEditingController(text: data.weight.toString()),
        ),
      ],
    ),
  ),
);

var productMainDataForm = Expanded(
    flex: 1,
    child: Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(border: Border.all()),
      child: Column(
        children: [
          const Text('Main Product Data'),

          TextField(
            decoration: const InputDecoration(label: Text('ID')),
            readOnly: true,
            // controller: TextEditingController(text: data.id.toString()),
          ),
          TextField(
            decoration: const InputDecoration(label: Text('Produktname')),
            // readOnly: editMode,
            // controller: TextEditingController(text: data.name),
          ),
          TextField(
            decoration: const InputDecoration(label: Text('ASIN')),
            // readOnly: editMode,
            // controller: TextEditingController(text: data.asin),
          ),
          TextField(
            decoration: const InputDecoration(label: Text('EAN')),
            // readOnly: editMode,
            // controller: TextEditingController(text: data.ean),
          ),
          // Divider(heiht: 10),
          ElevatedButton(
            onPressed: () {
              // storeProduct(product)
            },
            child: Container(
                margin: const EdgeInsets.all(20.0),
                // padding: const EdgeInsets.all(20.0),
                child: Icon(Icons.save)),
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
      ),
    ));

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);
  static const String url = 'product/form';
  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileBody: Text("TO BE DONE"),
      tabletBody: Text("TO BE DONE"),
      desktopBody: Scaffold(
          // appBar: openShelvesAppBar,
          floatingActionButton:
              FloatingActionButton(child: Icon(Icons.add), onPressed: () {}),
          body: Row(children: [
            getOpenShelvesDrawer(context),
            Expanded(flex: 1, child: productMainDataForm),
            Expanded(flex: 1, child: productTechDataForm)
          ])),
    );
  }
}
