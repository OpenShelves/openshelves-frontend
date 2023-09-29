import 'package:flutter/material.dart';
import 'package:openshelves/address_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddressForm extends StatefulWidget {
  final Address address;
  final void Function(Address) onSubmit;
  final GlobalKey<FormState> formKey;
  const AddressForm(
      {Key? key,
      required this.address,
      required this.onSubmit,
      required this.formKey})
      : super(key: key);

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  TextEditingController addressName1 = TextEditingController();
  TextEditingController addressName2 = TextEditingController();
  TextEditingController addressName3 = TextEditingController();
  TextEditingController addressStreet = TextEditingController();
  TextEditingController addressHousenumber = TextEditingController();
  TextEditingController addressZip = TextEditingController();
  TextEditingController addressCity = TextEditingController();
  TextEditingController addressCountry = TextEditingController();

  @override
  initState() {
    super.initState();
    addressName1.text = widget.address.name1;
    addressName2.text = widget.address.name2 ?? '';
    addressName3.text = widget.address.name3 ?? '';
    addressStreet.text = widget.address.street ?? '';
    addressHousenumber.text = widget.address.housenumber ?? '';
    addressZip.text = widget.address.zip ?? '';
    addressCity.text = widget.address.city ?? '';
    addressCountry.text = widget.address.country ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: Container(
          margin: const EdgeInsets.all(20.0),
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(border: Border.all()),
          child: Column(
            children: [
              const Text('Address'),
              TextFormField(
                decoration: InputDecoration(
                    label: Text(AppLocalizations.of(context)!.address_name1)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Must be filled";
                  }
                  return null;
                },
                controller: addressName1,
                onSaved: (value) {
                  widget.address.name1 = value!;
                  widget.onSubmit(widget.address);
                },
              ),
              TextFormField(
                  decoration: InputDecoration(
                      label: Text(AppLocalizations.of(context)!.address_name2)),
                  controller: addressName2,
                  onSaved: (value) {
                    widget.address.name2 = value!;
                    widget.onSubmit(widget.address);
                  }),
              TextFormField(
                  decoration: InputDecoration(
                      label: Text(AppLocalizations.of(context)!.address_name3)),
                  controller: addressName3,
                  onSaved: (value) {
                    widget.address.name3 = value!;
                    widget.onSubmit(widget.address);
                  }),
              TextFormField(
                  decoration: InputDecoration(
                      label:
                          Text(AppLocalizations.of(context)!.address_street)),
                  controller: addressStreet,
                  onSaved: (value) {
                    widget.address.street = value!;
                    widget.onSubmit(widget.address);
                  }),
              TextFormField(
                  decoration: InputDecoration(
                      label: Text(
                          AppLocalizations.of(context)!.address_housenumber)),
                  controller: addressHousenumber,
                  onSaved: (value) {
                    widget.address.housenumber = value!;
                    widget.onSubmit(widget.address);
                  }),
              TextFormField(
                  decoration: InputDecoration(
                      label: Text(AppLocalizations.of(context)!.address_zip)),
                  controller: addressZip,
                  onSaved: (value) {
                    widget.address.zip = value!;
                    widget.onSubmit(widget.address);
                  }),
              TextFormField(
                  decoration: InputDecoration(
                      label: Text(AppLocalizations.of(context)!.address_city)),
                  controller: addressCity,
                  onSaved: (value) {
                    widget.address.city = value!;
                    widget.onSubmit(widget.address);
                  }),
              TextFormField(
                  decoration: InputDecoration(
                      label:
                          Text(AppLocalizations.of(context)!.address_country)),
                  controller: addressCountry,
                  onSaved: (value) {
                    widget.address.country = value!;
                    widget.onSubmit(widget.address);
                  }),
            ],
          ),
        ));
  }
}
