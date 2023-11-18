import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:openshelves/products/models/product_model.dart';
import 'package:openshelves/products/services/product_service.dart';
import 'package:openshelves/tax/tax_model.dart';
import 'package:openshelves/tax/tax_service.dart';

class DocumentRow extends StatefulWidget {
  const DocumentRow({Key? key}) : super(key: key);

  @override
  State<DocumentRow> createState() => _DocumentRowState();
}

class _DocumentRowState extends State<DocumentRow> {
  int maxHeight = 70;
  Product product = Product(name: '');
  double tax = 19;
  TextEditingController productController = TextEditingController();
  TextEditingController netPriceController = TextEditingController();
  TextEditingController grossPriceController = TextEditingController();
  TextEditingController grossTotalController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  calcPrice() {
    if (netPriceController.text.isNotEmpty) {
      grossPriceController.text =
          (double.parse(netPriceController.text) * (1 + tax / 100))
              .toStringAsFixed(2);
      if (quantityController.text.isNotEmpty) {
        grossTotalController.text = (double.parse(grossPriceController.text) *
                double.parse(quantityController.text))
            .toStringAsFixed(2);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: [
        TextFormField(
          textAlign: TextAlign.right,
          decoration: const InputDecoration(
            label: Text("POS"),
            constraints: BoxConstraints(
              maxHeight: 70,
              maxWidth: 40,
            ),
          ),
        ),
        TypeAheadField(
          textFieldConfiguration: TextFieldConfiguration(
            controller: productController,
            decoration: InputDecoration(
              counterText: product.id != null && product.name.isNotEmpty
                  ? '${product.id} / ${product.name}'
                  : '',
              label: const Text("Product"),
              constraints: const BoxConstraints(
                maxHeight: 70,
                maxWidth: 500,
              ),
            ),
          ),
          suggestionsCallback: (pattern) {
            return searchProducts(pattern);
          },
          itemBuilder: (context, Product product) {
            return ListTile(
              title: Text(product.name),
            );
          },
          onSuggestionSelected: (Product product) {
            productController.text = product.name;
            setState(() {
              this.product = product;
              netPriceController.text = product.price.toString();
              calcPrice();
            });
          },
        ),
        TextFormField(
          textAlign: TextAlign.right,
          controller: quantityController,
          onChanged: (value) {
            calcPrice();
          },
          decoration: const InputDecoration(
            label: Text("Quantity"),
            constraints: BoxConstraints(
              maxHeight: 70,
              maxWidth: 70,
            ),
          ),
        ),
        TextFormField(
          textAlign: TextAlign.right,
          controller: netPriceController,
          onChanged: (context) {
            calcPrice();
          },
          decoration: const InputDecoration(
            label: Text("Net Price"),
            constraints: BoxConstraints(
              maxHeight: 70,
              maxWidth: 70,
            ),
          ),
        ),
        FutureBuilder<List<Tax>>(
          future: getTaxes(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return DropdownButton(
                  value: snapshot.data[2].id.toString(),
                  onChanged: (String? value) {},
                  itemHeight: 60,
                  items: snapshot.data.map<DropdownMenuItem<String>>((tax) {
                    return DropdownMenuItem<String>(
                      value: tax.id.toString(),
                      child: Text(tax.name),
                    );
                  }).toList());
            } else {
              return const Text('Loading...');
            }
          },
        ),
        TextFormField(
          textAlign: TextAlign.right,
          controller: grossPriceController,
          decoration: const InputDecoration(
            label: Text("Gross Price"),
            constraints: BoxConstraints(
              maxHeight: 70,
              maxWidth: 70,
            ),
          ),
        ),
        TextFormField(
          textAlign: TextAlign.right,
          controller: grossTotalController,
          decoration: const InputDecoration(
            label: Text("Gross Total"),
            constraints: BoxConstraints(
              maxHeight: 70,
              maxWidth: 70,
            ),
          ),
        ),
      ],
    );
  }
}
