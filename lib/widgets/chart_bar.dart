import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double percentageOfTotal;

  ChartBar(this.label, this.spendingAmount, this.percentageOfTotal);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: FittedBox(
            child: Text(
              'Rs.${spendingAmount.toStringAsFixed(0)}',
            ),
          ),
          height:13,
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          height: 80,
          width: 10,
          child: Stack(children: [
            Container(
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 230, 249, 236),
                  borderRadius: BorderRadius.circular(10)),
            ),
            FractionallySizedBox(
                heightFactor: percentageOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    color: Theme.of(context).primaryColorLight,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ))
          ]),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(label)
      ],
    );
  }
}
