// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:openshelves/helpers/debouncer.dart';
import 'package:openshelves/products/services/product_service.dart';

class ProductSearchFieled extends StatefulWidget {
  final Function onSearch;
  final Function onProductFound;
  const ProductSearchFieled(
      {Key? key, required this.onSearch, required this.onProductFound})
      : super(key: key);

  @override
  State<ProductSearchFieled> createState() => _ProductSearchFieledState();
}

class _ProductSearchFieledState extends State<ProductSearchFieled> {
  TextEditingController searchController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 100);
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextField(
        controller: searchController,
        decoration: InputDecoration(
            suffixIcon: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  searchController.clear();
                  widget.onSearch(getProducts());
                }),
            prefixIcon: const Icon(Icons.search),
            hintText: AppLocalizations.of(context)!.searchHintText),
        onChanged: (value) => {
          _debouncer.run(
            () {
              if (value.length == 13) {
                getProductByCode(value).then((value) => {
                      if (value != null)
                        {widget.onProductFound(value), searchController.clear()}
                    });
              } else if (value.length > 2) {
                widget.onSearch(searchProducts(value));
              }
              if (value.isEmpty) {
                widget.onSearch(getProducts());
              }
            },
          )
        },
      ),
    ]);
  }
}
