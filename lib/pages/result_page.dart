import 'package:flutter/material.dart';

import '../widgets/summary_result_card.dart';
import '../widgets/result_person_card.dart';

import '../style/theme.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    // KUNCI TANGKAP DATA YANG DIKIRIM DARI HOMEPAGE
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
        // toolbar height dynamic
        toolbarHeight: 80,
        backgroundColor: whiteColor,
        elevation: 0,
        title: Text('Result', style: titleTextStyle),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SummaryResultCard(
              billPerPerson: args['billPerPerson'],
              totalBill: args['totalBill'],
              personCount: args['personCount'],
              taxBill: args['taxBill'],
              tipPercentage: args['tipPercentage'],
            ),
            const SizedBox(height: 20),
            // Pakai expanded karena tinggi cardnya dinamis, ngga fixed seperti summary card
            Expanded(
              child: ResultPersonCard(
                billPerPerson: args['billPerPerson'],
                personCount: args['personCount'],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
