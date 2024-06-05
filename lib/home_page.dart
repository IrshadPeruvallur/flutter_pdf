import 'package:flutter/material.dart';
import 'package:flutter_pdf/widgets.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';

class InvoicePage extends StatelessWidget {
  final List<Map<String, dynamic>> items = [
    {"description": "Item 1", "quantity": 1, "price": 50.0},
    {"description": "Item 2", "quantity": 2, "price": 30.0},
    {"description": "Item 3", "quantity": 3, "price": 20.0},
  ];

  final double total = 50.0 + 2 * 30.0 + 3 * 20.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Invoice'),
        actions: [
          IconButton(
            icon: Icon(Icons.print),
            onPressed: () => _printInvoice(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeaderSection(),
            SizedBox(height: 20),
            InvoiceSummarySection(),
            SizedBox(height: 20),
            Expanded(child: ItemsSection(items: items)),
            SizedBox(height: 20),
            TotalSection(total: total),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _printInvoice(),
        child: Icon(Icons.picture_as_pdf),
      ),
    );
  }

  Future<void> _printInvoice() async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('Grafico',
                          style: pw.TextStyle(
                              fontSize: 24, fontWeight: pw.FontWeight.bold)),
                      pw.Text('Address Line 1'),
                      pw.Text('Address Line 2'),
                    ],
                  ),
                  pw.Container(
                    height: 100,
                    width: 100,
                    color: PdfColors.grey300,
                    child: pw.Center(child: pw.Text('Logo')),
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Text('Invoice',
                  style: pw.TextStyle(
                      fontSize: 32, fontWeight: pw.FontWeight.bold)),
              pw.Text('Invoice #: 123456'),
              pw.Text('Date: 01/01/2024'),
              pw.SizedBox(height: 20),
              pw.Text('Bill To:',
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 5),
              pw.Text('Customer Name'),
              pw.Text('Customer Address Line 1'),
              pw.Text('Customer Address Line 2'),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                context: context,
                data: <List<String>>[
                  <String>['Description', 'Quantity', 'Price'],
                  ...items.map((item) => [
                        item['description'],
                        item['quantity'].toString(),
                        '\$${item['price']}'
                      ])
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Align(
                alignment: pw.Alignment.centerRight,
                child: pw.Text('Total: \$${total.toStringAsFixed(2)}',
                    style: pw.TextStyle(
                        fontSize: 24, fontWeight: pw.FontWeight.bold)),
              ),
            ],
          );
        },
      ),
    );
    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }
}
