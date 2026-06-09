import 'package:window_manager/window_manager.dart';
import 'package:flutter/material.dart';

class CustomTitleBar extends StatelessWidget {
  const CustomTitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          Expanded(
            child: DragToMoveArea(
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  const Text(
                    'DocuLens',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () async {
              await windowManager.minimize();
            },
          ),

          IconButton(
            icon: const Icon(Icons.crop_square),
            onPressed: () async {
              if (await windowManager.isMaximized()) {
                await windowManager.unmaximize();
              } else {
                await windowManager.maximize();
              }
            },
          ),

          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () async {
              await windowManager.close();
            },
          ),
        ],
      ),
    );
  }
}