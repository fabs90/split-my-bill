import 'package:flutter/material.dart';
import 'package:split_my_bill/widgets/summary_card.dart';
import 'package:split_my_bill/widgets/person_slider.dart';
import 'package:split_my_bill/widgets/tip_selector.dart';

import '../style/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _personCount = 4;
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            SummaryCard(
              totalBill: 0,
              personCount: _personCount.round(),
              taxBill: 0,
              tipPercentage: 0,
            ),
            SizedBox(height: 20),
            PersonSlider(
              value: _personCount,
              min: 1,
              max: 10,
              onChanged: (val) {
                setState(() {
                  _personCount = val;
                });
              },
            ),
            SizedBox(height: 20),
            TipSelector(),
          ],
        ),
      ),
    );
  }
}
