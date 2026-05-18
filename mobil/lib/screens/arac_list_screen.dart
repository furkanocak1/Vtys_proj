import 'package:flutter/material.dart';

import '../models/arac.dart';
import '../repositories/repository_provider.dart';

class AracListScreen extends StatefulWidget {
  const AracListScreen({super.key});

  @override
  State<AracListScreen> createState() => _AracListScreenState();
}

class _AracListScreenState extends State<AracListScreen> {
  final _repo = RepositoryProvider.aracRepository;

  List<Arac> _araclar = [];
  bool _loading = true;
  String? _error;
  String? _durumFiltre;

  static const _durumlar = ['Tümü', 'Satışta', 'Rezerve', 'Satıldı'];

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
      final durum = _durumFiltre == 'Tümü' ? null : _durumFiltre;
      final list = await _repo.getAraclar(durum: durum);
      setState(() {
        _araclar = list;
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
      appBar: AppBar(title: const Text('Araçlar')),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: _durumlar.map((d) {
                final selected = (_durumFiltre ?? 'Tümü') == d;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(d),
                    selected: selected,
                    onSelected: (_) {
                      setState(() => _durumFiltre = d);
                      _load();
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(_error!, textAlign: TextAlign.center),
        ),
      );
    }
    if (_araclar.isEmpty) {
      return const Center(child: Text('Araç bulunamadı'));
    }

    return RefreshIndicator(
      onRefresh: _load,
      child: ListView.builder(
        itemCount: _araclar.length,
        itemBuilder: (context, index) {
          final a = _araclar[index];
          return ListTile(
            title: Text('${a.markaAdi} ${a.model}'),
            subtitle: Text('${a.yil} · ${a.fiyat.toStringAsFixed(0)} ₺'),
            trailing: _DurumBadge(durum: a.durum),
          );
        },
      ),
    );
  }
}

class _DurumBadge extends StatelessWidget {
  const _DurumBadge({required this.durum});

  final String durum;

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (durum) {
      case 'Satışta':
        color = Colors.green;
      case 'Rezerve':
        color = Colors.orange;
      case 'Satıldı':
        color = Colors.grey;
      default:
        color = Colors.blue;
    }
    return Chip(
      label: Text(durum, style: const TextStyle(fontSize: 12)),
      backgroundColor: color.withOpacity(0.15),
      side: BorderSide(color: color),
      visualDensity: VisualDensity.compact,
    );
  }
}
