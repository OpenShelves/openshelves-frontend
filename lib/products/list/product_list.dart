import 'package:flutter/material.dart';
import 'package:openshelves/main.dart';
import 'package:openshelves/products/models/product_model.dart';
import 'package:openshelves/products/product_form.dart';
import 'package:redux/redux.dart';

class ProductList extends StatefulWidget {
  final List<Product> products;
  final Store<AppState> store;
  const ProductList({Key? key, required this.products, required this.store})
      : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.products.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Text(widget.products[index].id.toString()),
          title: Text(widget.products[index].name),
          onTap: () {
            widget.store.dispatch(SelectProductAction(widget.products[index]));
            Navigator.pushNamed(
              context,
              ProductFormPage.url,
            );
          },
          subtitle: Row(
            children: [
              const Text('Price: '),
              Text(widget.products[index].price.toString()),
              // const Text(' / Sku: '),
              // Text(snapshot.data![index].sku.toString()),
              // const Text(' / Active: '),
              // Text(snapshot.data![index].active.toString())
            ],
          ),
        );
      },
    );
  }
}
