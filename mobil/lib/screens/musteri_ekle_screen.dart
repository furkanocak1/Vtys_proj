import 'package:flutter/material.dart';

import '../models/musteri_ekle.dart';
import '../repositories/repository_provider.dart';

class MusteriEkleScreen extends StatefulWidget {
  const MusteriEkleScreen({super.key});

  @override
  State<MusteriEkleScreen> createState() => _MusteriEkleScreenState();
}

class _MusteriEkleScreenState extends State<MusteriEkleScreen> {
  final _formKey = GlobalKey<FormState>();
  final _adController = TextEditingController();
  final _tcController = TextEditingController();
  final _telefonController = TextEditingController();

  String _musteriTipi = 'Bireysel';
  bool _saving = false;

  @override
  void dispose() {
    _adController.dispose();
    _tcController.dispose();
    _telefonController.dispose();
    super.dispose();
  }

  Future<void> _kaydet() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);

    try {
      await RepositoryProvider.musteriRepository.ekle(
        MusteriEkle(
          adSoyad: _adController.text.trim(),
          tcKimlik: _tcController.text.trim(),
          telefon: _telefonController.text.trim(),
          musteriTipi: _musteriTipi,
        ),
      );
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e')),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Yeni müşteri')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _adController,
              decoration: const InputDecoration(
                labelText: 'Ad soyad',
                border: OutlineInputBorder(),
              ),
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Ad soyad girin' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _tcController,
              decoration: const InputDecoration(
                labelText: 'TC kimlik',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              maxLength: 11,
              validator: (v) {
                if (v == null || v.trim().isEmpty) return 'TC girin';
                if (v.trim().length != 11) return 'TC 11 haneli olmalı';
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _telefonController,
              decoration: const InputDecoration(
                labelText: 'Telefon',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.phone,
              validator: (v) =>
                  v == null || v.trim().isEmpty ? 'Telefon girin' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _musteriTipi,
              decoration: const InputDecoration(
                labelText: 'Müşteri tipi',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Bireysel', child: Text('Bireysel')),
                DropdownMenuItem(value: 'Kurumsal', child: Text('Kurumsal')),
              ],
              onChanged: (v) => setState(() => _musteriTipi = v!),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _saving ? null : _kaydet,
              child: _saving
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }
}
