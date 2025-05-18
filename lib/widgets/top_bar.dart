import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final String title;
  final Widget? action;
  const TopBar({required this.title, this.action, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: const AssetImage(
                    'lib/Assets/Fotodeperfil.png',
                  ),
                  radius: 18,
                ),
                const SizedBox(width: 10),
                Text(
                  'Mercurio',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            action ?? Container(),
          ],
        ),
      ),
    );
  }
}
