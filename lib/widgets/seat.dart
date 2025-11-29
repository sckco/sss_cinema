import 'package:flutter/material.dart';

typedef SeatTapCallbackNaza = void Function(String seat);

class SeatItemNaza extends StatelessWidget {
  final String seatId;
  final bool isSold;
  final bool isSelected;
  final SeatTapCallbackNaza onTap;

  const SeatItemNaza({required this.seatId, required this.isSold, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    Color color;
    if (isSold) color = Colors.red;
    else if (isSelected) color = Colors.blue;
    else color = Colors.grey;
    return GestureDetector(
      onTap: isSold ? null : () => onTap(seatId),
      child: Container(
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
        alignment: Alignment.center,
        child: Text(seatId, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}
