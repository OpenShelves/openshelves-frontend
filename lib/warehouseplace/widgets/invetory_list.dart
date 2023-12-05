import 'package:flutter/material.dart';
import 'package:openshelves/products/form/product_form_page.dart';
import 'package:openshelves/products/services/product_service.dart';
import 'package:openshelves/warehouseplace/inventory_service.dart';
import 'package:openshelves/warehouseplace/models/inventory_level_model.dart';

class InventoryList extends StatefulWidget {
  final int id;
  const InventoryList({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<InventoryList> createState() => _InventoryListState();
}

class _InventoryListState extends State<InventoryList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<InventoryLevel>>(
        future: getInventoryLevelsByInventoryId(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom:
                                          BorderSide(color: Colors.black12))),
                              child: ListTile(
                                onTap: () {
                                  getProductById(
                                          snapshot.data![index].productsId)
                                      .then((product) {
                                    Navigator.pushNamed(
                                      context,
                                      ProductFormPage.url +
                                          '/' +
                                          product.id!.toString(),
                                    );
                                  });
                                },
                                title: Text(snapshot.data![index].productsName),
                                leading: Text(snapshot.data![index].quantity,
                                    style: (Theme.of(context)
                                        .textTheme
                                        .headlineMedium)),
                                trailing: const Icon(Icons.arrow_right),
                              ),
                            );
                          })));
            } else {
              return const Center(child: Text('nodata'));
            }
          } else {
            return const Center(child: Text('connectionsstate'));
          }
        });
  }
}
