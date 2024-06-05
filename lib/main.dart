import 'package:flutter/material.dart';
import 'package:flutter_pdf/home_page.dart';

void main() {
  runApp(InvoiceApp());
}

class InvoiceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Invoice App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: InvoicePage(),
    );
  }
}
