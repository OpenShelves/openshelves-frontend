import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:openshelves/products/product_service.dart';

class ProductSearchFieled extends StatefulWidget {
  final Function onSearch;
  const ProductSearchFieled({Key? key, required this.onSearch})
      : super(key: key);

  @override
  State<ProductSearchFieled> createState() => _ProductSearchFieledState();
}

class _ProductSearchFieledState extends State<ProductSearchFieled> {
  TextEditingController searchController = TextEditingController();
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
          if (value.length == 13)
            {getProductByCode(value).then((value) => print)}
          else if (value.length > 2)
            {widget.onSearch(searchProducts(value))},
          if (value.isEmpty) {widget.onSearch(getProducts())},
        },
      ),
    ]);
  }
}
