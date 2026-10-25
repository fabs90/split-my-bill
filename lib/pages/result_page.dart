import 'package:flutter/material.dart';

import '../style/theme.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbar height dynamic
        toolbarHeight: 80,
        backgroundColor: whiteColor,
        elevation: 0,
        title: Text('Split Bill', style: titleTextStyle),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: []),
      ),
    );
  }
}
