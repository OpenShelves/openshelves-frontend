import 'package:flutter/material.dart';

class DesktopCard extends StatefulWidget {
  final String title;
  final Widget child;
  final List<Widget>? primaryActions;
  const DesktopCard(
      {Key? key, required this.title, required this.child, this.primaryActions})
      : super(key: key);

  @override
  State<DesktopCard> createState() => _DesktopCardState();
}

class _DesktopCardState extends State<DesktopCard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            margin: const EdgeInsets.all(20),
            child: ListView(children: [
              Row(children: [
                Container(
                    margin: const EdgeInsets.fromLTRB(0, 0, 50, 0),
                    child: Text(widget.title,
                        style: const TextStyle(fontSize: 20))),
                Expanded(
                    child: TextFormField(
                        decoration: InputDecoration(
                  labelText: 'Search...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ))),
                widget.primaryActions != null
                    ? Row(
                        children: widget.primaryActions!
                            .map((element) => Container(
                                margin: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                                child: element))
                            .toList())
                    : Container(),
                DropdownButton(
                    focusColor: Colors.blue,
                    dropdownColor: Colors.blue,
                    // itemHeight: 20,
                    style: const TextStyle(
                        color: Colors.white, backgroundColor: Colors.blue),
                    hint: const Text('More Actions'),
                    items: const [
                      DropdownMenuItem(child: Text('One'), value: 1),
                      DropdownMenuItem(child: Text('Two'), value: 2),
                      DropdownMenuItem(child: Text('Three'), value: 3)
                    ],
                    onChanged: (value) {}),
              ]),
              const Divider(),
              widget.child
            ])));
  }
}
