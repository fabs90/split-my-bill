import 'package:flutter/material.dart';

import '../style/theme.dart';

class TipSelector extends StatefulWidget {
  final ValueChanged<double> onChanged;
  const TipSelector({super.key, required this.onChanged});

  @override
  State<TipSelector> createState() => _TipSelectorState();
}

class _TipSelectorState extends State<TipSelector> {
  int _selectedIndex = 0;
  double _tipPercentage = 0.0;

  final List<String> _tip = ['0%', '10%', '20%', '30%', '40%'];

  void _onTipSelected(int index) {
    setState(() {
      _selectedIndex = index;
      _tipPercentage = double.parse(_tip[index].replaceAll('%', ''));
      widget.onChanged(_tipPercentage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Judul
        Text('Tip', style: subtitleTextStyle),
        const SizedBox(height: 8),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _tip.length,
            itemBuilder: (context, index) {
              // Cek apakah index saat ini dipilih
              final is_selected = _selectedIndex == index;
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () {
                    _onTipSelected(index);
                  },
                  child: Container(
                    width: 76,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: is_selected ? darkColor : inactiveBorderColor,
                        width: is_selected ? 1.5 : 1.0,
                      ),
                    ),
                    child: Center(
                      child: Text(_tip[index], style: subtitleTextStyle),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
