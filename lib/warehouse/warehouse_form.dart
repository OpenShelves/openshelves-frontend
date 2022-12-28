import 'package:flutter/material.dart';
import 'package:openshelves/address_model.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/helper/delete.dart';
import 'package:openshelves/responsive/responsive_layout.dart';
import 'package:openshelves/warehouse/warehouse_model.dart';
import 'package:openshelves/warehouse/warehouse_service.dart';

class WarhouseForm extends StatefulWidget {
  const WarhouseForm({Key? key}) : super(key: key);
  static const String url = 'warehouse/form';

  @override
  State<WarhouseForm> createState() => _WarhouseFormState();
}

TextEditingController warehouseName = TextEditingController();
TextEditingController warehouseId = TextEditingController();

final _formKey = GlobalKey<FormState>();
TextEditingController addressName1 = TextEditingController();
TextEditingController addressName2 = TextEditingController();
TextEditingController addressName3 = TextEditingController();
TextEditingController addressStreet = TextEditingController();
TextEditingController addressHousenumber = TextEditingController();
TextEditingController addressZip = TextEditingController();
TextEditingController addressCity = TextEditingController();
TextEditingController addressCountry = TextEditingController();
getAddressForm(Address address) {
  addressName1.text = address.name1;
  addressName2.text = address.name2.toString();
  addressName3.text = address.name3.toString();
  addressCity.text = address.city.toString();
  addressZip.text = address.zip.toString();
  addressCountry.text = address.country.toString();
  addressStreet.text = address.street.toString();
  addressHousenumber.text = address.housenumber.toString();

  return Container(
    margin: const EdgeInsets.all(20.0),
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(border: Border.all()),
    child: Column(
      children: [
        const Text('Address'),
        TextFormField(
          decoration: const InputDecoration(label: Text('Name1')),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Must be filled";
            }
            return null;
          },
          controller: addressName1,
        ),
        TextField(
            decoration: const InputDecoration(label: Text('Name2')),
            controller: addressName2),
        TextField(
            decoration: const InputDecoration(label: Text('Name3')),
            controller: addressName3),
        TextField(
            decoration: const InputDecoration(label: Text('Street')),
            controller: addressStreet),
        TextField(
          decoration: const InputDecoration(label: Text('Housenumber')),
          controller: addressHousenumber,
        ),
        TextField(
          decoration: const InputDecoration(label: Text('Zip')),
          controller: addressZip,
        ),
        TextField(
          decoration: const InputDecoration(label: Text('City')),
          controller: addressCity,
        ),
        TextField(
          decoration: const InputDecoration(label: Text('Country')),
          controller: addressCountry,
        ),
      ],
    ),
  );
}

emptyValidator(value) {
  if (value == null || value.isEmpty) {
    return "Must be filled";
  }
  return null;
}

class WarehousePageArguments {
  final Warehouse warehouse;
  WarehousePageArguments(this.warehouse);
}

class _WarhouseFormState extends State<WarhouseForm> {
  @override
  Widget build(BuildContext context) {
    Warehouse warehouse = Warehouse(name: '', address: Address(name1: ''));
    // if (ModalRoute.of(context)!.settings.arguments != null) {
    final args =
        ModalRoute.of(context)!.settings.arguments as WarehousePageArguments;
    if (args == null && args.warehouse == null) {
      return Scaffold(
        appBar: openShelvesAppBar,
        body: const Center(child: Text('Error: No Warehouse')),
      );
    }
    if (args.warehouse != null) {
      warehouse = args.warehouse;
      if (warehouse.id != null) {
        getWarehouse(args.warehouse.id!).then((value) {
          // setState(() {
          warehouse = value;
          // });
        });
      }
      // warehouse = args.warehouse;
    }

    warehouseName.text = warehouse.name;
    if (warehouse.id != null) {
      warehouseId.text = warehouse.id.toString();
    }
    // }

    return ResponsiveLayout(
      mobileBody: const Text("TO BE DONE"),
      tabletBody: const Text("TO BE DONE"),
      desktopBody: Scaffold(
          // appBar: openShelvesAppBar,
          // floatingActionButton: FloatingActionButton(
          //     child: const Icon(Icons.add), onPressed: () {}),
          body: Row(children: [
        getOpenShelvesDrawer(context),
        Expanded(
            flex: 1,
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextField(
                      decoration: const InputDecoration(label: Text('ID')),
                      enabled: false,
                      controller: warehouseId,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(label: Text('Name')),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Must be filled";
                        }
                        return null;
                      },
                      controller: warehouseName,
                      // enabled: false,
                      // controller: TextEditingController(text: product.id.toString()),
                    ),
                    getAddressForm(warehouse.address),
                    IconButton(
                        onPressed: () {
                          var valid = _formKey.currentState!.validate();
                          if (valid) {
                            warehouse.name = warehouseName.text;
                            warehouse.address.name1 = addressName1.text;
                            warehouse.address.name2 = addressName2.text;
                            warehouse.address.name3 = addressName3.text;
                            warehouse.address.street = addressStreet.text;
                            warehouse.address.housenumber =
                                addressHousenumber.text;
                            warehouse.address.zip = addressZip.text;
                            warehouse.address.city = addressCity.text;
                            warehouse.address.country = addressCountry.text;
                            print(warehouse);
                            storeWarehouse(warehouse).then((value) => {
                                  print(value),
                                  setState(() {
                                    warehouse:
                                    value;
                                  })
                                });
                          }
                          // print(_formKey.currentState.toString());
                        },
                        icon: Icon(Icons.save)),
                    IconButton(
                        onPressed: () {
                          getDeleteButton(context).then((value) {
                            print(value);
                            if (value && warehouse.id != null) {
                              deleteWarehouse(warehouse.id!);
                            }
                          });
                        },
                        icon: Icon(Icons.delete))
                  ],
                ))),
      ])),
    );
  }
}
