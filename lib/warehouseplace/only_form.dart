import 'package:flutter/material.dart';
import 'package:openshelves/helper/url_helper.dart';
import 'package:openshelves/warehouse/warehouse_model.dart';
import 'package:openshelves/warehouse/warehouse_service.dart';
import 'package:openshelves/warehouseplace/models/warehouseplace_model.dart';
import 'package:openshelves/warehouseplace/warehouseplace_list_page.dart';
import 'package:openshelves/warehouseplace/warehouseplaces_service.dart';
import 'package:openshelves/widgets/delete_overlay.dart';

class WarehousePlaceFormOnly extends StatefulWidget {
  const WarehousePlaceFormOnly(
      {Key? key, required this.warehousePlace, required this.warehouses})
      : super(key: key);
  final WarehousePlace warehousePlace;
  final List<Warehouse> warehouses;
  @override
  State<WarehousePlaceFormOnly> createState() => _WarehousePlaceFormOnlyState();
}

class _WarehousePlaceFormOnlyState extends State<WarehousePlaceFormOnly> {
  final _formKey1 = GlobalKey<FormState>();
  final futureWarehouses = getWarehouses();

  TextEditingController idController = TextEditingController(text: '');
  @override
  void initState() {
    idController.text = widget.warehousePlace.id != null
        ? widget.warehousePlace.id.toString()
        : '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: idController,
                decoration:
                    const InputDecoration(hintText: 'ID', label: Text('ID')),
                enabled: false,
              ),
              TextFormField(
                initialValue: widget.warehousePlace.name,
                decoration: const InputDecoration(
                    icon: Icon(Icons.abc),
                    hintText: 'Enter the name',
                    label: Text('Warehouse Place Name')),
                onChanged: (value) {
                  setState(() {
                    widget.warehousePlace.name = value;
                  });
                },
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter the name';
                  }
                  return null;
                },
                onSaved: (value) => widget.warehousePlace.name = value!,
              ),
              DropdownButtonFormField<int>(
                value: widget.warehousePlace.warehouse!.id ??
                    widget.warehouses[0].id,
                decoration: const InputDecoration(
                    icon: Icon(Icons.warehouse),
                    hintText: 'Select the warehouse place',
                    label: Text('Warehouse')),
                items: widget.warehouses.map((_warehouse1) {
                  return DropdownMenuItem<int>(
                    child: Text(_warehouse1.name),
                    value: _warehouse1.id,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    widget.warehousePlace.warehouse = widget.warehouses
                        .firstWhere((element) => element.id == value);
                  });
                },
                onSaved: (value) {
                  setState(() {
                    widget.warehousePlace.warehouse = widget.warehouses
                        .firstWhere((element) => element.id == value);
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a warehouse place';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: widget.warehousePlace.barcode,
                onChanged: (value) {
                  setState(() {
                    widget.warehousePlace.barcode = value;
                  });
                },
                decoration: InputDecoration(
                    suffix: IconButton(
                        onPressed: () => {
                              launchInBrowser(Uri.parse(
                                  'http://localhost:4090/label/' +
                                      widget.warehousePlace.barcode))
                            },
                        icon: const Icon(Icons.print)),
                    icon: const Icon(Icons.barcode_reader),
                    hintText: 'Barcode',
                    label: const Text('Barcode')),
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    // widget.warehousePlace.parent =  value as WarehousePlace?;
                  });
                },
                decoration: const InputDecoration(
                    icon: Icon(Icons.library_books),
                    hintText: 'Parent',
                    label: Text('Parent')),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: TextButton(
                  onPressed: () {
                    // Validate the form and save the data
                    if (_formKey1.currentState!.validate()) {
                      _formKey1.currentState!.save();
                      // WarehousePlace wpn = wp;

                      storeWarehousePlace(widget.warehousePlace)
                          .then((warehousePlaceServer) {
                        setState(() {
                          idController.text =
                              warehousePlaceServer.id.toString();
                        });
                      });
                    }
                  },
                  child: const Text('Save'),
                ),
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const DeleteDialog();
                        }).then((value) {
                      if (value && widget.warehousePlace.id != null) {
                        deleteWarehousePlace(widget.warehousePlace.id!)
                            .then((value) {
                          Navigator.pushNamed(
                              context, WarehousePlaceListPage.url);
                        });
                      }
                    });
                  },
                  icon: const Icon(Icons.delete))
            ],
          ),
        ));
  }
}
