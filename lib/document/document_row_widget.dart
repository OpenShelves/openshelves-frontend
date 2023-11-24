import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:openshelves/document/models/document_row_model.dart';
import 'package:openshelves/products/models/product_model.dart';
import 'package:openshelves/products/services/product_service.dart';
import 'package:openshelves/settings/tax/models/tax_model.dart';
import 'package:openshelves/settings/tax/services/tax_service.dart';

class DocumentRowWidget extends StatefulWidget {
  final DocumentRowModel documentRow;
  const DocumentRowWidget({Key? key, required this.documentRow})
      : super(key: key);

  @override
  State<DocumentRowWidget> createState() => _DocumentRowState();
}

class _DocumentRowState extends State<DocumentRowWidget> {
  int maxHeight = 70;

  TextEditingController posController = TextEditingController();
  TextEditingController productController = TextEditingController();
  TextEditingController netPriceController = TextEditingController();
  TextEditingController grossPriceController = TextEditingController();
  TextEditingController grossTotalController = TextEditingController();
  TextEditingController quantityController = TextEditingController(
    text: '1',
  );

  calcPrice() {
    if (widget.documentRow.netPrice != null &&
        widget.documentRow.quantity != null &&
        widget.documentRow.grossPrice != null &&
        widget.documentRow.tax != null) {
      // grossPriceController.text =
      //     widget.documentRow.grossPrice!.toStringAsFixed(2);
      // netPriceController.text = widget.documentRow.netPrice!.toStringAsFixed(2);
      //     widget.documentRow.grossPrice.toStringAsFixed(2);
      grossTotalController.text =
          (widget.documentRow.grossPrice! * widget.documentRow.quantity!)
              .toStringAsFixed(2);
    }
    // if (widget.documentRow.netPrice != null && widget.documentRow.tax != null) {
    //   widget.documentRow.grossPrice = (widget.documentRow.netPrice *
    //       (1 + widget.documentRow.tax!.rate / 100));
    //   grossPriceController.text = (double.parse(netPriceController.text) *
    //           (1 + widget.documentRow.tax!.rate / 100))
    //       .toStringAsFixed(2);
    //   if (quantityController.text.isNotEmpty) {
    //     grossTotalController.text = (double.parse(grossPriceController.text) *
    //             double.parse(quantityController.text))
    //         .toStringAsFixed(2);
    //   }
    // }
  }

  @override
  initState() {
    super.initState();
    posController.text = widget.documentRow.pos.toString();
    productController.text = widget.documentRow.productName;
    netPriceController.text = widget.documentRow.netPrice.toString();
    grossPriceController.text = widget.documentRow.grossPrice.toString();
    quantityController.text = widget.documentRow.quantity.toString();
    calcPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: [
        TextFormField(
          onChanged: (value) {
            setState(() {
              widget.documentRow.pos = int.parse(value);
            });
          },
          controller: posController,
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
              counterText: widget.documentRow.product != null &&
                      widget.documentRow.product!.name.isNotEmpty
                  ? '${widget.documentRow.product!.id} / ${widget.documentRow.product!.name}'
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
              widget.documentRow.productName = product.name;
              widget.documentRow.product = product;
              widget.documentRow.netPrice = product.price;
              netPriceController.text = product.price.toString();
              calcPrice();
            });
          },
        ),
        TextFormField(
          textAlign: TextAlign.right,
          controller: quantityController,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
          onChanged: (value) {
            if (value.isNotEmpty && double.parse(value) > 0) {
              widget.documentRow.quantity = double.parse(value);
              calcPrice();
            }
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
          onChanged: (value) {
            widget.documentRow.netPrice = double.parse(value);
            widget.documentRow.grossPrice = widget.documentRow.netPrice! *
                (widget.documentRow.tax!.rate + 100) /
                100;

            // widget.documentRow.netPrice!;
            grossPriceController.text =
                widget.documentRow.grossPrice!.toStringAsFixed(2);
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
          builder: (BuildContext context, AsyncSnapshot<List<Tax>> snapshot) {
            if (snapshot.hasData) {
              var defaultTax = widget.documentRow.tax ??
                  snapshot.data!.firstWhere((tax) => tax.defaultTax,
                      orElse: () => snapshot.data!.first);
              widget.documentRow.tax = defaultTax;

              return DropdownButton(
                  value: defaultTax.id.toString(),
                  onChanged: (String? value) {
                    setState(() {
                      widget.documentRow.tax = snapshot.data!.firstWhere(
                          (tax) => tax.id.toString() == value,
                          orElse: () => snapshot.data!.first);
                      if (widget.documentRow.netPrice != null) {
                        widget.documentRow.grossPrice =
                            widget.documentRow.netPrice! *
                                (widget.documentRow.tax!.rate + 100) /
                                100;
                        grossPriceController.text =
                            widget.documentRow.grossPrice!.toStringAsFixed(2);
                      }
                    });
                  },
                  itemHeight: 60,
                  items: snapshot.data!.map<DropdownMenuItem<String>>((tax) {
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
          onChanged: (value) {
            widget.documentRow.grossPrice = double.parse(value);
            widget.documentRow.netPrice = widget.documentRow.grossPrice! /
                (100 + widget.documentRow.tax!.rate) *
                100;
            netPriceController.text =
                widget.documentRow.netPrice!.toStringAsFixed(2);

            calcPrice();
          },
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
