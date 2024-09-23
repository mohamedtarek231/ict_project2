import 'package:flutter/material.dart';

class CardInfoUser extends StatelessWidget {
  final String? text;
  const CardInfoUser({
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[300],
          border: Border.all(
            color: Colors.blue,
          ),
          boxShadow: const [BoxShadow(blurRadius: 5, color: Colors.blue)]),
      child: Text(
        text ?? 'No data',
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
