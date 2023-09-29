import 'package:flutter/material.dart';
import 'package:openshelves/products/models/product_model.dart';

class ProductTechDataForm extends StatefulWidget {
  final Product product;
  const ProductTechDataForm({Key? key, required this.product})
      : super(key: key);

  @override
  State<ProductTechDataForm> createState() => _ProductTechDataFormState();
}

class _ProductTechDataFormState extends State<ProductTechDataForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(border: Border.all()),
      child: Column(
        children: [
          const Text('Product Tech Data'),
          TextField(
            decoration: const InputDecoration(label: Text('Width in CM')),
            controller:
                TextEditingController(text: widget.product.width.toString()),
          ),
          TextField(
            decoration: const InputDecoration(label: Text('Height in CM')),
            controller:
                TextEditingController(text: widget.product.height.toString()),
          ),
          TextField(
            decoration: const InputDecoration(label: Text('Depth in CM')),
            controller:
                TextEditingController(text: widget.product.depth.toString()),
          ),
          TextField(
            decoration: const InputDecoration(label: Text('Weight in Gram')),
            controller:
                TextEditingController(text: widget.product.weight.toString()),
          ),
        ],
      ),
    );
  }
}
