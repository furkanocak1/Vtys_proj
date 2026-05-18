import 'package:flutter/material.dart';

import '../models/arac.dart';

class AracDetailScreen extends StatelessWidget {
  const AracDetailScreen({super.key, required this.arac});

  final Arac arac;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${arac.markaAdi} ${arac.model}')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _row('Durum', arac.durum),
          _row('Fiyat', '${arac.fiyat.toStringAsFixed(0)} ₺'),
          _row('Yıl', '${arac.yil}'),
          _row('Şasi no', arac.sasiNo),
          _row('Marka', arac.markaAdi),
          _row('Model', arac.model),
          _row('Şube ID', '${arac.subeId}'),
          _row('Araç ID', '${arac.aracId}'),
        ],
      ),
    );
  }

  Widget _row(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
