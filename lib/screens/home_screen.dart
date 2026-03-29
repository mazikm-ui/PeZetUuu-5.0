
import 'package:flutter/material.dart';
import '../models/kalkulator.dart';
import '../services/data_loader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? dane;
  String? produkt;
  int? okres;
  double skladka = 0;
  double wynik = 0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final d = await DataLoader.load();
    setState(() => dane = d);
  }

  void licz() {
    if (dane == null || produkt == null || okres == null) return;

    wynik = Kalkulator.oblicz(
      dane: dane!,
      produkt: produkt!,
      okres: okres!,
      skladka: skladka,
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (dane == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final produkty = dane!['produkty'].map((e) => e['nazwa']).toList();
    List okresy = [];

    if (produkt != null) {
      final p = dane!['produkty']
          .firstWhere((e) => e['nazwa'] == produkt);
      okresy = p['okresy'].map((e) => e['okres']).toList();
    }

    return Scaffold(
      appBar: AppBar(title: const Text("PeZetUuu")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField(
              hint: const Text("Produkt"),
              items: produkty.map<DropdownMenuItem>((p) =>
                  DropdownMenuItem(value: p, child: Text(p))).toList(),
              onChanged: (v) => setState(() {
                produkt = v;
                okres = null;
              }),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField(
              hint: const Text("Okres"),
              items: okresy.map<DropdownMenuItem>((o) =>
                  DropdownMenuItem(value: o, child: Text(f"{o} miesięcy"))).toList(),
              onChanged: (v) => setState(() => okres = v),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(labelText: "Składka"),
              onChanged: (v) => skladka = double.tryParse(v) ?? 0,
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: licz, child: const Text("OBLICZ")),
            const SizedBox(height: 20),
            Text("Prowizja: ${wynik.toStringAsFixed(2)} zł"),
          ],
        ),
      ),
    );
  }
}
