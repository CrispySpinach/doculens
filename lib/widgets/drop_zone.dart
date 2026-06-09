import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';

class DocumentDropZone extends StatefulWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Function(List<String>)? onFilesDropped;

  const DocumentDropZone({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.onFilesDropped,
  });

  @override
  State<DocumentDropZone> createState() =>
      _DocumentDropZoneState();
}

class _DocumentDropZoneState
    extends State<DocumentDropZone> {
  bool _dragging = false;

  @override
  Widget build(BuildContext context) {
    return DropTarget(
      onDragEntered: (_) {
        setState(() {
          _dragging = true;
        });
      },
      onDragExited: (_) {
        setState(() {
          _dragging = false;
        });
      },
      onDragDone: (detail) {
        setState(() {
          _dragging = false;
        });

        final paths = detail.files
            .map((file) => file.path)
            .whereType<String>()
            .toList();

        widget.onFilesDropped?.call(paths);
      },
      child: InkWell(
        onTap: widget.onTap,
        borderRadius:
            BorderRadius.circular(16),
        child: Container(
          height: 220,
          width: double.infinity,
          decoration: BoxDecoration(
            color: _dragging
                ? const Color(0xFFEFF6FF)
                : Colors.white,

            borderRadius:
                BorderRadius.circular(24),

            boxShadow: [
              BoxShadow(
                color: _dragging
                    ? const Color(0xFF2563EB)
                        .withValues(alpha: 0.15)
                    : Colors.black
                        .withValues(alpha: 0.08),

                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center,
            children: [
              Icon(
                Icons.description_outlined,
                size: 64,
                color: const Color(0xFF2563EB),
              ),

              const SizedBox(height: 12),

              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                widget.subtitle,
                style: TextStyle(
                  color:
                      Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}