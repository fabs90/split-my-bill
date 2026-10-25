import 'package:flutter/material.dart';

import '../style/theme.dart';

class ResultPersonCard extends StatelessWidget {
  double billPerPerson;
  int personCount;

  ResultPersonCard({
    super.key,
    required this.billPerPerson,
    required this.personCount,
  });

  String _formatRupiah(double number) {
    final int value = number.round();
    final String formatted = value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
    return 'Rp $formatted';
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: personCount,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.person, color: Color(0xFF131A22), size: 20),
                  const SizedBox(width: 12),
                  Text(
                    'Person ${index + 1}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Text(_formatRupiah(billPerPerson), style: titleTextStyle),
            ],
          ),
        );
      },
    );
  }
}
