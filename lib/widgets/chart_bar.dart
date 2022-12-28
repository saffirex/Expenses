import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingAmount;
  final double percentageOfTotal;

  ChartBar(this.label, this.spendingAmount, this.percentageOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints){
      return Column(
      children: [
        Container(
          height: (constraints.maxHeight) *0.095, //notice all these multipliers add up to 1.0, maxheight is the height of the container defined in main.dart file and here we are distributing it to the children
          child: FittedBox(
            child: Text(
              'Rs.${spendingAmount.toStringAsFixed(0)}',
            ),
          ),
          
        ),
        SizedBox(
          height: (constraints.maxHeight) *0.04,
        ),
        Container(
          height: (constraints.maxHeight) *0.7,
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
        SizedBox(
          height: (constraints.maxHeight) *0.055,
        ),
        Container(
          height: (constraints.maxHeight) *0.1,
          child: FittedBox(child: Text(label)))
      ],
    );
    }
    );
    
  }
}
