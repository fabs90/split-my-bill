import 'package:flutter/material.dart';
import 'package:split_my_bill/widgets/summary_card.dart';
import 'package:split_my_bill/widgets/person_slider.dart';
import 'package:split_my_bill/widgets/tip_selector.dart';
import 'package:split_my_bill/widgets/tax_input.dart';
import 'package:split_my_bill/widgets/numpad_screen.dart';
import 'package:split_my_bill/widgets/split_bill_button.dart';

import '../style/theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _totalBill = 0;
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              SummaryCard(
                totalBill: _totalBill,
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
                  // Pake setState biar di flutter nge rebuild lagi tampilan nya dan nampilin angka terbaru
                  setState(() {
                    _personCount = val;
                  });
                },
              ),
              SizedBox(height: 20),
              TipSelector(),
              SizedBox(height: 20),
              TaxInput(),
              SizedBox(height: 20),
              NumpadScreen(
                onChanged: (value) {
                  setState(() {
                    _totalBill = value;
                  });
                },
              ),
              SizedBox(height: 20),
              SplitBillButton(),
            ],
          ),
        ),
      ),
    );
  }
}
