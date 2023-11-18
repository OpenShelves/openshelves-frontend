import 'package:flutter/material.dart';

class InventoryTable extends PaginatedDataTable {
  InventoryTable(
      {Key? key,
      required List<DataColumn> columns,
      required DataTableSource source})
      : super(key: key, columns: columns, source: source);
}
