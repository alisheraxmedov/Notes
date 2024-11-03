import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final String title;
  final List<String> items;
  final String editedDate;
  final Color? color;

  const NoteCard({super.key, 
    required this.title,
    required this.items,
    required this.editedDate,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            for (var item in items)
              Text('• $item'),
            const SizedBox(height: 8.0),
            Text(
              editedDate,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}