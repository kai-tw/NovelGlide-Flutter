import 'package:flutter/material.dart';

import 'advertisement.dart';
import 'advertisement_id.dart';

class BottomAdWrapper extends StatelessWidget {
  const BottomAdWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: child),
        Advertisement(adUnitId: AdvertisementId.adaptiveBanner),
      ],
    );
  }
}