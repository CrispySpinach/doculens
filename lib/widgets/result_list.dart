import 'package:flutter/material.dart';

class ResultList extends StatelessWidget {
  final List<Map<String, dynamic>> results;

  const ResultList({
    super.key,
    required this.results,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: results.length,
      separatorBuilder: (_, _) =>
          const Divider(),
      itemBuilder: (context, index) {
        final item = results[index];

        return ListTile(
          title: Text(item["file"]),
          trailing: Text(
            "${item["score"]}%",
          ),
        );
      },
    );
  }
}