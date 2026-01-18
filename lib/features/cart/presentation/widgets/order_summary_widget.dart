import 'package:flutter/material.dart';
import 'summary_row.dart';

class OrderSummaryWidget extends StatelessWidget {
  final double subtotal;
  final double shipping;
  final double tax;
  final double total;

  const OrderSummaryWidget({
    super.key,
    required this.subtotal,
    required this.shipping,
    required this.tax,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          SummaryRow(
            title: "Subtotal",
            value: "\$${subtotal.toStringAsFixed(2)}",
          ),
          SummaryRow(
            title: "Shipping",
            value: shipping == 0 ? "Free" : "\$${shipping.toStringAsFixed(2)}",
          ),
          SummaryRow(
            title: "Estimated Tax",
            value: "\$${tax.toStringAsFixed(2)}",
          ),
          const Divider(),
          SummaryRow(
            title: "Total",
            value: "\$${total.toStringAsFixed(2)}",
            isBold: true,
          ),
        ],
      ),
    );
  }
}
