import 'package:flutter/material.dart';

import '../style/theme.dart';

// Dibuat stateless karena summary card hanya menampilkan angka ringkasan tanpa interaksi

class SummaryCard extends StatelessWidget {
  // Variable to show
  final double totalBill;
  final int personCount;
  final double taxBill;
  final double tipPercentage;

  const SummaryCard({
    super.key,
    required this.totalBill,
    required this.personCount,
    required this.taxBill,
    required this.tipPercentage,
  });

  // Helper untuk mengubah angka menjadi format Rupiah (contoh: Rp 50.000)
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(painter: _PolygonBackgroundPainter()),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total Bill', style: subtitleCardTextStyle),
                        FittedBox(
                          child: Text(
                            _formatRupiah(totalBill),
                            style: titleCardTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IntrinsicWidth(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Bill', style: subtitleCardTextStyle),
                            SizedBox(width: 10),
                            Text(
                              _formatRupiah(totalBill),
                              style: subtitleCardTextStyle,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Person', style: subtitleCardTextStyle),
                            SizedBox(width: 10),
                            Text(
                              personCount.toString(),
                              style: subtitleCardTextStyle,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tax', style: subtitleCardTextStyle),
                            SizedBox(width: 10),
                            Text(
                              _formatRupiah(taxBill),
                              style: subtitleCardTextStyle,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Tip', style: subtitleCardTextStyle),
                            SizedBox(width: 10),
                            Text(
                              '${tipPercentage.toStringAsFixed(0)}%',
                              style: subtitleCardTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PolygonBackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint1 = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.fill;

    final paint2 = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..style = PaintingStyle.fill;

    // Poligon 1 (Bagian kanan)
    final path1 = Path()
      ..moveTo(size.width * 0.45, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width * 0.65, size.height)
      ..close();

    // Segitiga 2 (Aksen silang di kanan bawah)
    final path2 = Path()
      ..moveTo(size.width * 0.3, size.height)
      ..lineTo(size.width * 0.75, 0)
      ..lineTo(size.width, size.height)
      ..close();

    canvas.drawPath(path1, paint1);
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
