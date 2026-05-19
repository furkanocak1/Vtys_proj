import 'package:flutter/material.dart';

import '../config/app_config.dart';
import '../models/arac.dart';
import '../models/musteri.dart';
import '../models/test_surusu_kayit.dart';
import '../repositories/repository_provider.dart';

class TestSurusuScreen extends StatefulWidget {
  const TestSurusuScreen({super.key});

  @override
  State<TestSurusuScreen> createState() => _TestSurusuScreenState();
}

class _TestSurusuScreenState extends State<TestSurusuScreen> {
  final _notlarController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _loading = true;
  bool _saving = false;
  String? _error;

  List<Musteri> _musteriler = [];
  List<Arac> _araclar = [];

  Musteri? _seciliMusteri;
  Arac? _seciliArac;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _notlarController.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final musteriler = await RepositoryProvider.musteriRepository.getMusteriler();
      final araclar = await RepositoryProvider.aracRepository.getAraclar(durum: 'Satışta');
      setState(() {
        _musteriler = musteriler;
        _araclar = araclar;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  Future<void> _kaydet() async {
    if (_seciliMusteri == null || _seciliArac == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Müşteri ve araç seçin')),
      );
      return;
    }

    setState(() => _saving = true);

    try {
      await RepositoryProvider.testSurusuRepository.kaydet(
        TestSurusuKayit(
          aracId: _seciliArac!.aracId,
          musteriId: _seciliMusteri!.musteriId,
          personelId: AppConfig.mockPersonelId,
          notlar: _notlarController.text.trim(),
        ),
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Test sürüşü kaydedildi')),
      );
      setState(() {
        _seciliMusteri = null;
        _seciliArac = null;
        _notlarController.clear();
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata: $e')),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test sürüşü')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(child: Text(_error!, textAlign: TextAlign.center));
    }

    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DropdownButtonFormField<Musteri>(
            value: _seciliMusteri,
            decoration: const InputDecoration(
              labelText: 'Müşteri',
              border: OutlineInputBorder(),
            ),
            items: _musteriler
                .map((m) => DropdownMenuItem(value: m, child: Text(m.adSoyad)))
                .toList(),
            onChanged: (m) => setState(() => _seciliMusteri = m),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<Arac>(
            value: _seciliArac,
            decoration: const InputDecoration(
              labelText: 'Araç (Satışta)',
              border: OutlineInputBorder(),
            ),
            items: _araclar
                .map((a) => DropdownMenuItem(
                      value: a,
                      child: Text('${a.markaAdi} ${a.model}'),
                    ))
                .toList(),
            onChanged: (a) => setState(() => _seciliArac = a),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _notlarController,
            decoration: const InputDecoration(
              labelText: 'Notlar (isteğe bağlı)',
              border: OutlineInputBorder(),
            ),
            maxLines: 3,
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
    );
  }
}
