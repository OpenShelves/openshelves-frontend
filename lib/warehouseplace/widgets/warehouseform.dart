import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:openshelves/warehouse/warehouse_model.dart';
import 'package:openshelves/warehouse/warehouse_service.dart';
import 'package:openshelves/warehouseplace/models/warehouseplace_model.dart';
import 'package:openshelves/warehouseplace/only_form.dart';
import 'package:openshelves/warehouseplace/warehouseplaces_service.dart';
import 'package:openshelves/warehouseplace/widgets/create_sub_warehouse_places.dart';

class WarehouseForm extends StatefulWidget {
  final WarehousePlace wp;
  const WarehouseForm({Key? key, required this.wp}) : super(key: key);

  @override
  State<WarehouseForm> createState() => _WarehouseFormState();
}

class _WarehouseFormState extends State<WarehouseForm> {
  bool editMode = false;
  @override
  Widget build(BuildContext context) {
    // editMode = widget.wp!.id == null ? true : false;
    List<Warehouse> _warehouses = [];
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<Warehouse>>(
            future: getWarehouses(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // Store the retrieved warehouse places in the _warehousePlaces field
                if (snapshot.hasData) {
                  _warehouses = snapshot.data!;
                }
                return editMode
                    ? Card(
                        margin: const EdgeInsets.all(8),
                        child: Column(children: [
                          Row(children: [
                            const Text('W A R E H O U S E P L A C E'),
                            Switch(
                              value: editMode,
                              onChanged: (val) {
                                setState(() {
                                  editMode = !editMode;
                                });
                                // editMode = val;
                              },
                            )
                          ]),
                          WarehousePlaceFormOnly(
                            warehousePlace: widget.wp,
                            warehouses: _warehouses,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return CreateSubWarehousePlaces(
                                        warehousePlace: widget.wp,
                                      );
                                    });
                              },
                              child:
                                  const Text('Genereate Sub Warehouse Place'))
                        ]))
                    : ListTile(
                        title: Text(widget.wp.name),
                        subtitle: Text(widget.wp.warehouse.name +
                            ' / ' +
                            widget.wp.warehouse.address.city.toString()),
                        trailing: Switch(
                          value: editMode,
                          onChanged: (val) {
                            setState(() {
                              editMode = !editMode;
                            });
                          },
                        ),
                      );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
