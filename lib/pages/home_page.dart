import 'package:flutter/material.dart';
import 'package:split_my_bill/widgets/summary_card.dart';

import '../style/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        // toolbar height dynamic
        toolbarHeight: 80,
        backgroundColor: whiteColor,
        elevation: 0,
        title: Text('Split Bill', style: titleTextStyle),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          SummaryCard(
            totalBill: 0,
            personCount: 0,
            taxBill: 0,
            tipPercentage: 0,
          ),
        ],
      ),
    );
  }
}
