import 'package:flutter/material.dart';

class InventoryTable extends PaginatedDataTable {
  InventoryTable(
      {required List<DataColumn> columns, required DataTableSource source})
      : super(columns: columns, source: source);
}
