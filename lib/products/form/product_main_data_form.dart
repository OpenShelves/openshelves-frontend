import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:openshelves/products/models/product_model.dart';
import 'package:openshelves/products/services/product_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductMainDataForm extends StatefulWidget {
  final Product product;
  final Key formKey;
  final void Function(Product) onSubmit;
  const ProductMainDataForm(
      {Key? key,
      required this.product,
      required this.onSubmit,
      required this.formKey})
      : super(key: key);

  @override
  State<ProductMainDataForm> createState() => _ProductMainDataFormState();
}

class _ProductMainDataFormState extends State<ProductMainDataForm> {
  @override
  initState() {
    super.initState();
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
                  key: widget.formKey,
                  child: Column(
                    children: [
                      TextField(
                        decoration: const InputDecoration(label: Text('ID')),
                        enabled: false,
                        controller: TextEditingController(
                            text: widget.product.id.toString()),
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                            icon: const Icon(Icons.abc),
                            label: Text(
                                AppLocalizations.of(context)!.productName)),
                        controller:
                            TextEditingController(text: widget.product.name),
                        onChanged: (value) => {widget.product.name = value},
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Must be filled";
                          }
                          return null;
                        },
                      ),
                      TextField(
                        decoration: const InputDecoration(
                            label: Text('ASIN'),
                            icon: FaIcon(FontAwesomeIcons.amazon)),
                        controller:
                            TextEditingController(text: widget.product.asin),
                        onChanged: (value) => {widget.product.asin = value},
                      ),
                      TextField(
                        decoration: const InputDecoration(
                            icon: Icon(Icons.barcode_reader),
                            label: Text('EAN')),
                        controller:
                            TextEditingController(text: widget.product.ean),
                        onChanged: (value) => {widget.product.ean = value},
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            icon: FaIcon(FontAwesomeIcons.cashRegister),
                            label: Text('Price')),
                        controller: TextEditingController(
                            text: widget.product.price.toString()),
                        onChanged: (value) =>
                            {widget.product.price = double.parse(value)},
                      ),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     storeProduct(widget.product).then((productBackend) {
                      //       setState(() {
                      //         // widget.product = productBackend;
                      //       });
                      //     });
                      //   },
                      //   child: Container(
                      //       margin: const EdgeInsets.all(5.0),
                      //       child: const Icon(Icons.save)),
                      // )
                    ],
                  )),
            )));
  }
}
