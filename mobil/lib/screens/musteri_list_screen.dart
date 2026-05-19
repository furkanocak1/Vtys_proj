import 'package:flutter/material.dart';

import '../models/musteri.dart';
import '../repositories/repository_provider.dart';

class MusteriListScreen extends StatefulWidget {
  const MusteriListScreen({super.key});

  @override
  State<MusteriListScreen> createState() => _MusteriListScreenState();
}

class _MusteriListScreenState extends State<MusteriListScreen> {
  final _repo = RepositoryProvider.musteriRepository;

  List<Musteri> _musteriler = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final list = await _repo.getMusteriler();
      setState(() {
        _musteriler = list;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Müşteriler')),
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
    if (_musteriler.isEmpty) {
      return const Center(child: Text('Müşteri bulunamadı'));
    }

    return RefreshIndicator(
      onRefresh: _load,
      child: ListView.builder(
        itemCount: _musteriler.length,
        itemBuilder: (context, index) {
          final m = _musteriler[index];
          return ListTile(
            title: Text(m.adSoyad),
            subtitle: Text('${m.telefon} · ${m.musteriTipi}'),
            trailing: Text(
              m.tcKimlik,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          );
        },
      ),
    );
  }
}
