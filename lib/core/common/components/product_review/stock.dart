import 'package:flutter/material.dart';

Widget buildStockStatus(int stock) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      children: [
        const Text(
          'Stock: ',
          style: TextStyle(fontSize: 16, color: Colors.black54),
        ),
        Expanded(
          child: LinearProgressIndicator(
            value: stock > 0 ? stock / 100 : 0,
            color: stock > 0 ? Colors.green : Colors.red,
            backgroundColor: Colors.grey.shade300,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          '$stock Available',
          style: TextStyle(
              fontSize: 16,
              color: stock > 0 ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}
