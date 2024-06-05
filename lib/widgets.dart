import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Company Name',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text('Address Line 1'),
                Text('Address Line 2'),
              ],
            ),
            Container(
              height: 100,
              width: 100,
              color: Colors.grey[300], // Placeholder for the logo
              child: Center(child: Text('Logo')),
            ),
          ],
        ),
        SizedBox(height: 20),
        Text('Invoice',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
        Text('Invoice #: 123456'),
        Text('Date: 01/01/2024'),
      ],
    );
  }
}

class InvoiceSummarySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Bill To:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        Text('Customer Name'),
        Text('Customer Address Line 1'),
        Text('Customer Address Line 2'),
      ],
    );
  }
}

class ItemsSection extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  ItemsSection({required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ListTile(
          title: Text(item['description']),
          trailing: Text('\$${item['price'] * item['quantity']}'),
          subtitle: Text('Quantity: ${item['quantity']}'),
        );
      },
    );
  }
}

class TotalSection extends StatelessWidget {
  final double total;

  TotalSection({required this.total});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('Total: \$${total.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
