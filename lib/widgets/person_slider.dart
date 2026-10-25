import 'package:flutter/material.dart';

class PersonSlider extends StatefulWidget {
  final double value;
  final double max;
  final double min;
  final ValueChanged<double> onChanged;

  const PersonSlider({
    super.key,
    required this.value,
    this.max = 10,
    this.min = 1,
    required this.onChanged,
  });

  @override
  State<PersonSlider> createState() => _PersonSliderState();
}

class _PersonSliderState extends State<PersonSlider> {
  void _updateValue(double localDx, double maxWidth) {
    // Menghitung rasio geser antara 0.0 - 1.0
    final ratio = (localDx / maxWidth).clamp(0.0, 1.0);
    final newValue = widget.min + (widget.max - widget.min) * ratio;
    widget.onChanged(newValue);
  }

  @override
  Widget build(BuildContext context) {
    const double barHeight = 44.0;
    const double handleWidth = 8.0;
    const double handleHeight = 52.0;

    return Container(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final totalWidth = constraints.maxWidth;
          final progress =
              ((widget.value - widget.min) / (widget.max - widget.min)).clamp(
                0.0,
                1.0,
              );
          final filledWidth = totalWidth * progress;

          return GestureDetector(
            onHorizontalDragUpdate: (details) =>
                _updateValue(details.localPosition.dx, totalWidth),
            onTapDown: (details) =>
                _updateValue(details.localPosition.dx, totalWidth),
            child: SizedBox(
              height: handleHeight,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.centerLeft,
                children: [
                  // 1. Background Track (Warna Abu Muda / Putih Semi Transparan)
                  Container(
                    width: totalWidth,
                    height: barHeight,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F4F5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),

                  // 2. Teks Angka Nilai di sisi kanan track
                  Positioned(
                    right: 16,
                    child: Text(
                      widget.value.round().toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  // 3. Track Terisi (Warna Gelap)
                  Container(
                    width: filledWidth,
                    height: barHeight,
                    decoration: const BoxDecoration(
                      color: Color(0xFF131A22),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        bottomLeft: Radius.circular(4),
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 12),
                    // Ikon tetap terlihat selama lebar track cukup
                    child: filledWidth > 36
                        ? const Icon(
                            Icons.group_outlined,
                            color: Colors.white,
                            size: 20,
                          )
                        : null,
                  ),

                  // 4. Handle Vertikal Kapsul
                  Positioned(
                    left: (filledWidth - (handleWidth / 2)).clamp(
                      0.0,
                      totalWidth - handleWidth,
                    ),
                    child: Container(
                      width: handleWidth,
                      height: handleHeight,
                      decoration: BoxDecoration(
                        color: const Color(0xFF131A22),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
