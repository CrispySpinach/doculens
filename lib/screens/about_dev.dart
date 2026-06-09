import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/mesh_background.dart';
import '../widgets/window_manager.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  Future<void> openUrl(String url) async {
    final uri = Uri.parse(url);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception(
        'Could not launch $url',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          MeshBackground(
            durationSeconds: 20,
            blurSigma: 80,
            blobs: [
              MeshBlob(
                color: const Color(0xFF2563EB)
                    .withValues(alpha: 0.30),
                size: 900,
              ),
              MeshBlob(
                color: const Color(0xFF60A5FA)
                    .withValues(alpha: 0.25),
                size: 800,
              ),
            ],
          ),

          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomTitleBar(),

              Align(
                alignment: Alignment.centerLeft,
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                  ),
                  label: const Text(
                    'Back',
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    width: 500,
                    padding: const EdgeInsets.all(32),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(
                        alpha: 0.85,
                      ),
                      borderRadius:
                          BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withValues(alpha: 0.08),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.description_outlined,
                          size: 72,
                          color: Color(0xFF2563EB),
                        ),

                        const SizedBox(height: 16),

                        const Text(
                          'DocuLens',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          'Document Similarity Checker',
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                Colors.grey.shade700,
                          ),
                        ),

                        const SizedBox(height: 24),

                        const Text(
                          'Version 1.0.0',
                        ),

                        const Divider(
                          height: 40,
                        ),

                        const Text(
                          'Developed By',
                          style: TextStyle(
                            fontWeight:
                                FontWeight.w600,
                          ),
                        ),

                        const SizedBox(height: 8),

                        const Text(
                          'CrispySpinach and Friends :)',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          'Kalimantan Institute of Technology',
                          style: TextStyle(
                            color:
                                Colors.grey.shade700,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 24),

                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            FilledButton.icon(
                              onPressed: () {
                                openUrl('https://github.com/CrispySpinach');
                              },
                              icon:
                                  const Icon(Icons.code),
                              label:
                                  const Text('GitHub'),
                            ),

                            const SizedBox(width: 12),

                            FilledButton.icon(
                              onPressed: () {
                                openUrl('https://www.linkedin.com/in/syabani-nz/');
                              },
                              icon:
                                  const Icon(Icons.link),
                              label:
                                  const Text('LinkedIn'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}