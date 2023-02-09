import 'package:flutter/material.dart';

class StatCard extends StatelessWidget {
  final String headline;
  final Widget body;
  final Color headlineColor;

  StatCard({
    required this.headline,
    required this.body,
    required this.headlineColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 150,
            height: 40,
            decoration: BoxDecoration(
              color: headlineColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
                child: Text(
              headline,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )),
          ),
          SizedBox(height: 15),
          Expanded(child: Center(child: body)),
        ],
      ),
    );
  }
}
