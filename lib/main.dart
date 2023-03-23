import 'package:flutter/material.dart';
import 'package:test/views/wallet/wallet.dart';
import 'package:test/widgets/widget.dart';

import 'views/home/Homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, home: BottomNav(),
      // BottomNav(),
    );
  }
}
