import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:openshelves/products/models/product_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductTechDataForm extends StatefulWidget {
  final Product product;
  final Key formKey;
  const ProductTechDataForm(
      {Key? key, required this.product, required this.formKey})
      : super(key: key);

  @override
  State<ProductTechDataForm> createState() => _ProductTechDataFormState();
}

class _ProductTechDataFormState extends State<ProductTechDataForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: Container(
          margin: const EdgeInsets.all(20.0),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(AppLocalizations.of(context)!.product_technical_data),
              TextFormField(
                decoration: InputDecoration(
                    icon: const FaIcon(FontAwesomeIcons.arrowsLeftRight),
                    label: Text(AppLocalizations.of(context)!.width)),
                controller: TextEditingController(
                    text: widget.product.width.toString()),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Must be filled";
                  }
                  return null;
                },
                onChanged: (value) =>
                    {widget.product.width = double.parse(value)},
              ),
              TextField(
                decoration: InputDecoration(
                    icon: const FaIcon(FontAwesomeIcons.arrowsUpDown),
                    label: Text(AppLocalizations.of(context)!.height)),
                controller: TextEditingController(
                    text: widget.product.height.toString()),
              ),
              TextField(
                decoration: InputDecoration(
                    icon: const FaIcon(FontAwesomeIcons.tentArrowTurnLeft),
                    label: Text(AppLocalizations.of(context)!.depth)),
                controller: TextEditingController(
                    text: widget.product.depth.toString()),
              ),
              TextField(
                decoration: InputDecoration(
                    icon: const FaIcon(FontAwesomeIcons.weightScale),
                    label: Text(AppLocalizations.of(context)!.weight)),
                controller: TextEditingController(
                    text: widget.product.weight.toString()),
              ),
            ],
          ),
        ));
  }
}
