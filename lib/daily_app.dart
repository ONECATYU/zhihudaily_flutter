import 'package:flutter/material.dart';

import 'package:zhihudaily_flutter/pages/home_page.dart';

class DailyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue
      ),
      home: HomePage(),
    );
  }
}