import 'package:flutter/material.dart';
import 'package:test/utils/exports.dart';

class Transactions extends StatefulWidget {
  const Transactions({super.key});

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Transactions"),
      body: Column(
        children: const [
          Divider(),
          Center(
            child: Text("Transactions"),
          ),
        ],
      ),
    );
  }
}
