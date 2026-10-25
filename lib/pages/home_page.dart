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
  double _totalTip = 0;
  double _tax = 0;

  // Logic calculate
  double get _taxAmount => _totalBill * (_tax / 100);
  double get _tipAmount => _totalBill * (_totalTip / 100);
  double get _grandTotal => _totalBill + _taxAmount + _tipAmount;
  double get _billPerPerson => _grandTotal / _personCount.round();
  // NOTE:'(For larger apps, developers move these variables and calculations out of the Widget into a controller/provider using packages like Provider, Riverpod, or BLoC, or built-in ChangeNotifier—keeping UI files purely for layout and logic files purely for math/data).'

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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SummaryCard(
                totalBill: _totalBill,
                personCount: _personCount.round(),
                taxBill: _tax,
                tipPercentage: _totalTip,
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
              TipSelector(
                onChanged: (value) {
                  setState(() {
                    _totalTip = value;
                  });
                },
              ),
              SizedBox(height: 20),
              TaxInput(
                onChanged: (value) {
                  setState(() {
                    _tax = value;
                  });
                },
              ),
              SizedBox(height: 20),
              NumpadScreen(
                onChanged: (value) {
                  setState(() {
                    _totalBill = value;
                  });
                },
              ),
              SizedBox(height: 20),
              SplitBillButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/result',
                    arguments: {
                      'billPerPerson': _billPerPerson,
                      'totalBill': _totalBill,
                      'personCount': _personCount.round(),
                      'taxBill': _tax,
                      'tipPercentage': _totalTip,
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
