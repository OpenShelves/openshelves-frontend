import 'package:flutter/material.dart';
import 'package:openshelves/warehouse/warehouse_model.dart';
import 'package:openshelves/warehouse/warehouse_service.dart';
import 'package:openshelves/warehouseplace/warehouseplace_list_page.dart';
import 'package:openshelves/warehouseplace/warehouseplace_model.dart';
import 'package:openshelves/warehouseplace/warehouseplaces_service.dart';
import 'package:openshelves/widgets/delete_overlay.dart';

class WarehousePlaceFormOnly extends StatefulWidget {
  const WarehousePlaceFormOnly(
      {Key? key, required this.warehousePlace, required this.warehouses})
      : super(key: key);
  final WarehousePlace warehousePlace;
  final List<Warehouse> warehouses;
  @override
  State<WarehousePlaceFormOnly> createState() =>
      _WarehousePlaceFormOnlyState(warehousePlace);
}

class _WarehousePlaceFormOnlyState extends State<WarehousePlaceFormOnly> {
  WarehousePlace warehousePlace;
  _WarehousePlaceFormOnlyState(this.warehousePlace);
  final _formKey1 = GlobalKey<FormState>();
  final futureWarehouses = getWarehouses();
  String _name = '';
  Warehouse? _warehouse;
  TextEditingController idController = TextEditingController(text: '');
  @override
  void initState() {
    idController.text =
        warehousePlace.id != null ? warehousePlace.id.toString() : '';
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
                initialValue: warehousePlace.name,
                decoration: const InputDecoration(
                    hintText: 'Enter the name',
                    label: Text('Warehouse Place Name')),
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Please enter the name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              DropdownButtonFormField<int>(
                value: warehousePlace.warehouse.id ?? widget.warehouses[0].id,
                decoration: const InputDecoration(
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
                    _warehouse = widget.warehouses
                        .firstWhere((element) => element.id == value);
                  });
                },
                onSaved: (value) {
                  setState(() {
                    _warehouse = widget.warehouses
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: TextButton(
                  onPressed: () {
                    // Validate the form and save the data
                    if (_formKey1.currentState!.validate()) {
                      _formKey1.currentState!.save();
                      // WarehousePlace wpn = wp;
                      WarehousePlace wpn = WarehousePlace(
                          id: warehousePlace.id,
                          name: _name,
                          warehouse: _warehouse!);
                      storeWarehousePlace(wpn).then((warehousePlaceServer) {
                        print(warehousePlaceServer.toJson());
                        setState(() {
                          _name = warehousePlaceServer.name;
                          warehousePlace = warehousePlaceServer;
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
                      print(value);
                      if (value && warehousePlace.id != null) {
                        deleteWarehousePlace(warehousePlace.id!).then((value) {
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
