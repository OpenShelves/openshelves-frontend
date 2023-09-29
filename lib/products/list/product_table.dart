import 'package:flutter/material.dart';
import 'package:openshelves/main.dart';
import 'package:openshelves/products/models/product_model.dart';
import 'package:openshelves/products/product_form.dart';
import 'package:openshelves/widgets/data_cell_currency.dart';
import 'package:openshelves/widgets/data_cell_number.dart';
import 'package:redux/redux.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductTableSource extends DataTableSource {
  List<Product> data;
  BuildContext context;
  Store store;
  ProductTableSource(
      {required this.data, required this.context, required this.store});
  @override
  DataRow? getRow(int index) {
    final product = data[index];
    return DataRow.byIndex(
        color: MaterialStateColor.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return Theme.of(context).colorScheme.primary.withOpacity(0.08);
          }
          if (index.isEven) {
            return Colors.grey.withOpacity(0.05);
          }
          return Colors.white.withOpacity(0.05);
        }),
        index: index,
        cells: [
          DataCell(
            IconButton(
              splashRadius: 20,
              hoverColor: Colors.teal.shade100,
              icon: const Icon(Icons.edit),
              onPressed: () {
                store.dispatch(
                  SelectProductAction(product),
                );
                Navigator.pushNamed(
                  context,
                  ProductFormPage.url,
                );
              },
            ),
          ),
          DataCell(DataCellNumber(number: product.id ?? 0)),
          DataCell(Text('${product.sku}')),
          DataCell(Text(product.name)),
          DataCell(DataCellCurrency(
            currcency: product.price ?? 0,
            currencySymbol: '€',
          )),
          DataCell(Text('${product.ean}')),
          DataCell(DataCellNumber(
            number: product.width ?? 0,
            trailing: 'cm',
          )),
          DataCell(DataCellNumber(
            number: product.height ?? 0,
            trailing: 'cm',
          )),
          DataCell(DataCellNumber(
            number: product.depth ?? 0,
            trailing: 'cm',
          )),
          DataCell(DataCellNumber(
            number: product.weight ?? 0,
            trailing: 'g',
          )),
          DataCell(Text('${product.active}')),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => data.length;

  @override
  int get selectedRowCount => 0;
}

class ProductTable extends StatefulWidget {
  final List<Product> data;
  final Store<AppState> store;
  const ProductTable({Key? key, required this.data, required this.store})
      : super(key: key);

  @override
  State<ProductTable> createState() => _ProductTableState();
}

class _ProductTableState extends State<ProductTable> {
  final productTablekey = GlobalKey<PaginatedDataTableState>();
  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
        key: productTablekey,
        rowsPerPage: widget.data!.length < 20 ? widget.data!.length : 20,
        showFirstLastButtons: true,
        availableRowsPerPage: const [10, 20, 50],
        columns: [
          const DataColumn(label: Text('#')),
          const DataColumn(label: Text('ID')),
          const DataColumn(label: Text('SKU')),
          DataColumn(label: Text(AppLocalizations.of(context)!.productName)),
          DataColumn(label: Text(AppLocalizations.of(context)!.price)),
          const DataColumn(label: Text('EAN')),
          DataColumn(label: Text(AppLocalizations.of(context)!.width)),
          DataColumn(label: Text(AppLocalizations.of(context)!.height)),
          DataColumn(label: Text(AppLocalizations.of(context)!.depth)),
          DataColumn(label: Text(AppLocalizations.of(context)!.weight)),
          DataColumn(label: Text(AppLocalizations.of(context)!.active)),
        ],
        source: ProductTableSource(
            data: widget.data!, context: context, store: widget.store));
  }
}
