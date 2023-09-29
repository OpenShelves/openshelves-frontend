// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:openshelves/products/models/product_model.dart';
import 'package:openshelves/products/services/product_service.dart';
import 'package:openshelves/warehouseplace/inventory_model.dart';
import 'package:openshelves/warehouseplace/inventory_service.dart';
import 'package:openshelves/warehouseplace/warehouseplaces_service.dart';

typedef void ProductCallback(Product product);

class ChangeInventoryForm extends StatefulWidget {
  final ProductCallback? onProductChanged;
  const ChangeInventoryForm({Key? key, this.onProductChanged})
      : super(key: key);

  @override
  State<ChangeInventoryForm> createState() => _ChangeInventoryFormState();
}

class _ChangeInventoryFormState extends State<ChangeInventoryForm> {
  String productName = '';
  late Product product;
  int warehouse_id = 0;
  String warehouse_name = '';
  int quantity = 0;
  TextEditingController productController = TextEditingController();
  FocusNode productFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Form(
            child: Column(
      children: [
        TextFormField(
          decoration: InputDecoration(label: Text('WarehousePlaceId')),
          onChanged: (value) {
            setState(() {
              warehouse_id = int.parse(value);
              getWarehousePlace(warehouse_id).then((warehouse) {
                print(warehouse);
                setState(() {
                  warehouse_name = warehouse.name;
                });
              });
            });
          },
        ),
        Text(warehouse_name),
        TextFormField(
          controller: productController,
          focusNode: productFocus,
          decoration: InputDecoration(label: Text('Product')),
          onChanged: (value) {
            if (value.length == 13) {
              getProductByCode(value).then((value) {
                setState(() {
                  productName = value.name;
                  product = value;
                  if (widget.onProductChanged != null) {
                    widget.onProductChanged!(value);
                  }
                  productController.text = '';
                  productFocus.requestFocus();
                });
              });
            }
          },
        ),
        TextFormField(
          decoration: InputDecoration(label: Text('Quantity')),
          onChanged: (value) {
            setState(() {
              quantity = int.parse(value);
            });
          },
        ),
        IconButton(
            onPressed: () {
              Inventory inventory = Inventory(
                  quantity: quantity,
                  warehousePlacesId: warehouse_id,
                  productsId: product.id!);
              storeInventory(inventory);
            },
            icon: Icon(Icons.add))
      ],
    )));
  }
}
