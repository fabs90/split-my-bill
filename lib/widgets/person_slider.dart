import 'package:flutter/material.dart';

class PersonSlider extends StatefulWidget {
  final double value;
  final double max;
  final double min;
  final int? divisions;
  final ValueChanged<double> onChanged;

  const PersonSlider({
    super.key,
    required this.value,
    this.max = 10,
    this.min = 1,
    this.divisions = 9,
    required this.onChanged,
  });

  @override
  State<PersonSlider> createState() => _PersonSliderState();
}

class _PersonSliderState extends State<PersonSlider> {
  void _updateValue(double localDx, double maxWidth) {
    // Menghitung rasio geser antara 0.0 - 1.0
    final rawRatio = (localDx / maxWidth).clamp(0.0, 1.0);

    // Jika divisions diatur, bulatkan rasio ke titik division terdekat (snapping)
    final double ratio = (widget.divisions != null && widget.divisions! > 0)
        ? (rawRatio * widget.divisions!).round() / widget.divisions!
        : rawRatio;

    final newValue = widget.min + (widget.max - widget.min) * ratio;

    // Hanya panggil onChanged jika nilainya benar-benar berubah
    if (newValue != widget.value) {
      widget.onChanged(newValue);
    }
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

                  // 2. Track Terisi (Warna Gelap)
                  Container(
                    width: filledWidth,
                    height: barHeight,
                    decoration: BoxDecoration(
                      color: const Color(0xFF131A22),
                      borderRadius: BorderRadius.horizontal(
                        left: const Radius.circular(4),
                        right: Radius.circular(progress >= 1.0 ? 4 : 0),
                      ),
                    ),
                  ),

                  // 3. Ikon di sisi kiri track
                  Positioned(
                    left: 16,
                    child: Icon(
                      Icons.group_outlined,
                      color: filledWidth > 26
                          ? Colors.white
                          : const Color(0xFF131A22),
                      size: 20,
                    ),
                  ),

                  // 4. Teks Angka Nilai di sisi kanan track
                  Positioned(
                    right: 16,
                    child: Text(
                      widget.value.round().toString(),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: filledWidth > totalWidth - 28
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                  ),

                  // 5. Handle Vertikal Kapsul
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
