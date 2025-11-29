import 'package:flutter/material.dart';

typedef SeatTapCallbackNaza = void Function(String seat);

class SeatItemNaza extends StatelessWidget {
  final String seatId;
  final bool isSold;
  final bool isSelected;
  final SeatTapCallbackNaza onTap;

  const SeatItemNaza({required this.seatId, required this.isSold, required this.isSelected, required this.onTap});

  
