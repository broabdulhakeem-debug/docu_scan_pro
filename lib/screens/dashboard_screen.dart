import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DocuScan Pro Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: const [
            _Tile(title: 'Scan Document', icon: Icons.camera_alt),
            _Tile(title: 'Upload', icon: Icons.upload_file),
            _Tile(title: 'My Documents', icon: Icons.folder),
            _Tile(title: 'Notes', icon: Icons.edit_note),
            _Tile(title: 'Subscriptions', icon: Icons.payment),
            _Tile(title: 'Organizations', icon: Icons.business),
          ],
        ),
      ),
    );
  }
}

class _Tile extends StatelessWidget {
  final String title;
  final IconData icon;

  const _Tile({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: () {},
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40),
            const SizedBox(height: 10),
            Text(title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}