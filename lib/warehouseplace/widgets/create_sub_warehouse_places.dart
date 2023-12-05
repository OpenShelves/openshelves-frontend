import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:openshelves/warehouseplace/models/warehouseplace_model.dart';
import 'package:openshelves/warehouseplace/warehouseplaces_service.dart';

class CreateSubWarehousePlaces extends StatefulWidget {
  final WarehousePlace warehousePlace;
  const CreateSubWarehousePlaces({Key? key, required this.warehousePlace})
      : super(key: key);

  @override
  State<CreateSubWarehousePlaces> createState() =>
      _CreateSubWarehousePlacesState();
}

class _CreateSubWarehousePlacesState extends State<CreateSubWarehousePlaces> {
  TextEditingController nameController =
      TextEditingController(text: 'Fachboden');
  TextEditingController quantityController = TextEditingController(text: '1');
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Generate Sub Warehouse Place'),
      content: Column(children: [
        TextFormField(
          controller: nameController,
          decoration: const InputDecoration(
            hintText: 'Enter the name',
          ),
          onChanged: (value) {},
          validator: (value) {
            if (value != null && value.isEmpty) {
              return 'Must be filled';
            }
            return null;
          },
        ),
        TextFormField(
          controller: quantityController,
          decoration: const InputDecoration(
            hintText: 'Quantity',
          ),
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly
          ],
        )
      ]),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel')),
        TextButton(
            onPressed: () {
              for (var i = 1; i <= int.parse(quantityController.text); i++) {
                storeWarehousePlace(WarehousePlace(
                  name:
                      '${nameController.text} ' + i.toString().padLeft(2, '0'),
                  barcode: '${widget.warehousePlace.barcode}-' +
                      i.toString().padLeft(2, '0'),
                  warehouse: widget.warehousePlace.warehouse,
                  parent: widget.warehousePlace,
                ));
              }

              Navigator.pop(context);
            },
            child: const Text('Generate'))
      ],
    );
  }
}
