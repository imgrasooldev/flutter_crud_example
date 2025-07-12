import 'package:flutter/material.dart';

class InvoiceListScreen extends StatelessWidget {
  const InvoiceListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final int customerId =
        ModalRoute.of(context)!.settings.arguments as int; // ← id آرہی ہے

    return Scaffold(
      appBar: AppBar(title: Text('Invoices for ID: $customerId')),
      body: Center(
        child: Text('Load & show invoices for customer #$customerId'),
      ),
    );
  }
}
