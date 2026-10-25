import 'package:flutter/material.dart';
import 'package:split_my_bill/widgets/numpad_button.dart';

class NumpadScreen extends StatefulWidget {
  final ValueChanged<double>? onChanged;
  const NumpadScreen({super.key, this.onChanged});

  @override
  State<NumpadScreen> createState() => _NumpadScreenState();
}

class _NumpadScreenState extends State<NumpadScreen> {
  String _input = '0';

  // Function untuk menangani ketika angka ditekan
  void _notifyParent() {
    final value = double.tryParse(_input) ?? 0;
    widget.onChanged?.call(value);
  }

  void _onNumberTap(String number) {
    if (_input == '0') {
      _input = number;
    } else {
      _input += number;
    }
    _notifyParent();
  }

  void _onBackspace() {
    // Maksimal 2 angka dibelakang koma
    if (_input.contains('.')) {
      final parts = _input.split('.');
      if (parts.length > 1 && parts[1].length >= 2) {
        return; // Jangan tambah angka lagi jika sudah 2 desimal
      }
    }

    if (_input.length > 1) {
      _input = _input.substring(0, _input.length - 1);
    } else {
      _input = '0';
    }
    _notifyParent();
  }

  void _onClear() {
    _input = '0';
    _notifyParent();
  }

  void _onDecimalTap() {
    // Hanya tambahkan titik jika belum ada titik sebelumnya
    if (!_input.contains('.')) {
      _input += '.';
      _notifyParent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildRow(['1', '2', '3']),
        const SizedBox(height: 12),
        _buildRow(['4', '5', '6']),
        const SizedBox(height: 12),
        _buildRow(['7', '8', '9']),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NumpadButton(label: 'C', onTap: _onClear),
            NumpadButton(label: '0', onTap: () => _onNumberTap('0')),
            NumpadButton(icon: Icons.backspace_outlined, onTap: _onBackspace),
          ],
        ),
      ],
    );
  }

  Widget _buildRow(List<String> numbers) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: numbers.map((number) {
        return NumpadButton(label: number, onTap: () => _onNumberTap(number));
      }).toList(),
    );
  }
}
