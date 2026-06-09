import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';

class MeshBackground extends StatefulWidget {
  final int durationSeconds;
  final Color backgroundColor;
  final double blurSigma;
  final List<MeshBlob> blobs;

  const MeshBackground({
    super.key,
    required this.blobs,
    this.backgroundColor = const Color(0xFFF8FAFC),
    this.durationSeconds = 10,
    this.blurSigma = 50.0
  });

  @override
  State<MeshBackground> createState() => 
    _MeshBackgroundState();
}

class MeshBlob {
  final Color color;
  final double size;

  const MeshBlob({
    required this.color,
    required this.size,
  });
}

class _MeshBackgroundState extends State<MeshBackground> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: widget.durationSeconds),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, _) {
        return Stack(
          children: [
            Positioned.fill(
              child: Container(
                color: widget.backgroundColor,
              )
            ),

            ...List.generate(
              widget.blobs.length,
              (index) {
                final blob = widget.blobs[index];
                return Positioned(
                  left: 200 + sin((_controller.value * pi * 2) + index,) * 200,
                  top: 200 + cos((_controller.value * pi * 2) + index,) * 150,
                  child: _blob(
                    color: blob.color,
                    size: blob.size,
                  ),
                );
              }
            )
          ],
        );
      }
    );
  }

  Widget _blob({
    required Color color,
    required double size,
  }) {
    return ImageFiltered(
      imageFilter: ImageFilter.blur(
        sigmaX: widget.blurSigma,
        sigmaY: widget.blurSigma,
      ),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle
        ),
      )
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}