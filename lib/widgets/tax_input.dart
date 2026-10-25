import 'package:flutter/material.dart';

import '../style/theme.dart';

class TaxInput extends StatefulWidget {
  const TaxInput({super.key});

  @override
  State<TaxInput> createState() => _TaxInputState();
}

class _TaxInputState extends State<TaxInput> {
  final TextEditingController _controller = TextEditingController(text: '0');
  final FocusNode _focusNode = FocusNode();
  int _taxPercentage = 0;

  @override
  void initState() {
    super.initState();
    // Supaya saat TextField diklik/fokus, border Container ikut berubah warna
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _changeTax(int delta) {
    setState(() {
      // Clamp menjaga agar pajak tetap di rentang 0 - 100
      _taxPercentage = (_taxPercentage + delta).clamp(0, 100);
      _controller.text = _taxPercentage.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isFocused = _focusNode.hasFocus;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tax', style: subtitleTextStyle),
        const SizedBox(height: 8),
        Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isFocused ? darkColor : inactiveBorderColor,
              width: isFocused ? 1.5 : 1.0,
            ),
          ),
          child: Row(
            children: [
              // 1. Ikon di kiri
              const Icon(
                Icons.receipt_long_outlined,
                color: Color(0xFF131A22),
                size: 20,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: _controller,
                  focusNode: _focusNode,
                  keyboardType: TextInputType.number,
                  style: subtitleTextStyle,
                  decoration: InputDecoration(
                    border: InputBorder.none, // Hilangkan garis bawah bawaan!
                    hintText: '0',
                    suffixText: '%',
                    suffixStyle: subtitleTextStyle,
                    isDense: true,
                  ),
                  onChanged: (val) {
                    _taxPercentage = (int.tryParse(val) ?? 0).clamp(0, 100);
                  },
                ),
              ),
              const SizedBox(width: 12),
              // 3. Ikon di kanan
              _buildStepButton(icon: Icons.remove, onTap: () => _changeTax(-1)),
              const SizedBox(width: 8),
              _buildStepButton(icon: Icons.add, onTap: () => _changeTax(1)),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _buildStepButton({required IconData icon, required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: const Color(0xFF131A22), // Senada dengan PersonSlider
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(icon, color: Colors.white, size: 18),
    ),
  );
}
