import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:openshelves/products/models/product_model.dart';
import 'package:openshelves/products/services/product_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductMainDataForm extends StatefulWidget {
  final Product product;
  const ProductMainDataForm({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductMainDataForm> createState() => _ProductMainDataFormState();
}

class _ProductMainDataFormState extends State<ProductMainDataForm> {
  late Product product;
  @override
  initState() {
    super.initState();
    product = widget.product;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(20),
        child: Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  child: Column(
                children: [
                  TextField(
                    decoration: const InputDecoration(label: Text('ID')),
                    enabled: false,
                    controller:
                        TextEditingController(text: product.id.toString()),
                  ),
                  TextField(
                    decoration: InputDecoration(
                        icon: const Icon(Icons.abc),
                        label: Text(AppLocalizations.of(context)!.productName)),
                    controller: TextEditingController(text: product.name),
                    onChanged: (value) => {product.name = value},
                  ),
                  TextField(
                    decoration: const InputDecoration(
                        label: Text('ASIN'),
                        icon: FaIcon(FontAwesomeIcons.amazon)),
                    controller: TextEditingController(text: product.asin),
                    onChanged: (value) => {product.asin = value},
                  ),
                  TextField(
                    decoration: const InputDecoration(
                        icon: Icon(Icons.barcode_reader), label: Text('EAN')),
                    controller: TextEditingController(text: product.ean),
                    onChanged: (value) => {product.ean = value},
                  ),
                  ElevatedButton(
                    onPressed: () {
                      storeProduct(product).then((productBackend) {
                        setState(() {
                          product = productBackend;
                        });
                      });
                    },
                    child: Container(
                        margin: const EdgeInsets.all(5.0),
                        child: const Icon(Icons.save)),
                  )
                ],
              )),
            )));
  }
}
