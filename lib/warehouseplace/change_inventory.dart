import 'package:flutter/material.dart';
import 'package:openshelves/products/product_model.dart';
import 'package:openshelves/products/product_service.dart';
import 'package:openshelves/warehouseplace/inventory_model.dart';
import 'package:openshelves/warehouseplace/inventory_service.dart';

class ChangeInventoryForm extends StatefulWidget {
  const ChangeInventoryForm({Key? key}) : super(key: key);

  @override
  State<ChangeInventoryForm> createState() => _ChangeInventoryFormState();
}

class _ChangeInventoryFormState extends State<ChangeInventoryForm> {
  String productName = '';
  late Product product;
  int warehouse_id = 0;
  int quantity = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Form(
            child: Column(
      children: [
        Text(productName),
        TextFormField(
          decoration: InputDecoration(label: Text('Product')),
          onChanged: (value) {
            if (value.length == 13) {
              getProductByCode(value).then((value) {
                setState(() {
                  productName = value.name;
                  product = value;
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
        TextFormField(
          decoration: InputDecoration(label: Text('WarehousePlaceId')),
          onChanged: (value) {
            setState(() {
              warehouse_id = int.parse(value);
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
