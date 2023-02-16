import 'package:flutter/material.dart';
import 'package:openshelves/address_model.dart';
import 'package:openshelves/constants.dart';
import 'package:openshelves/helper/delete.dart';
import 'package:openshelves/main.dart';
import 'package:openshelves/responsive/responsive_layout.dart';
import 'package:openshelves/warehouse/warehouse_model.dart';
import 'package:openshelves/warehouse/warehouse_service.dart';
import 'package:openshelves/warehouse/widgets/address_form.dart';
import 'package:redux/redux.dart';

class WarhouseForm extends StatefulWidget {
  final Store<AppState> store;
  const WarhouseForm({Key? key, required this.store}) : super(key: key);
  static const String url = 'warehouse/form';

  @override
  State<WarhouseForm> createState() => _WarhouseFormState();
}

emptyValidator(value) {
  if (value == null || value.isEmpty) {
    return "Must be filled";
  }
  return null;
}

class _WarhouseFormState extends State<WarhouseForm> {
  final _formKey = GlobalKey<FormState>();
  final _addressFormKey = GlobalKey<FormState>();
  late Warehouse warehouse;
  late Address address;
  TextEditingController warehouseName = TextEditingController();
  TextEditingController warehouseId = TextEditingController();

  @override
  initState() {
    super.initState();
    if (widget.store.state.selectedWarehouse != null) {
      warehouse = widget.store.state.selectedWarehouse!;
      warehouseName.text = warehouse.name;
      warehouseId.text = warehouse.id != null ? warehouse.id.toString() : '';
    } else {
      warehouse = Warehouse(name: '', address: Address(name1: ''));
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    AddressForm(
                      formKey: _addressFormKey,
                      address: warehouse.address,
                      onSubmit: (address) {
                        print(address);
                        setState(() {
                          this.address = address;
                        });
                      },
                    ),
                    IconButton(
                        onPressed: () {
                          var valid = _formKey.currentState!.validate();
                          if (valid) {
                            _addressFormKey.currentState!.validate();
                            _addressFormKey.currentState!.save();
                            warehouse.name = warehouseName.text;
                            if (warehouseId.text != null &&
                                warehouseId.text != '') {
                              warehouse.id = int.parse(warehouseId.text);
                            }
                            warehouse.address = address;
                            storeWarehouse(warehouse).then((value) => {});
                          }
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
