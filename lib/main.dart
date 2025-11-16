import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey), 
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2), 
          ),
        ),
      ),
      home: KalkulatorSederhana(),
    );
  }
}

class KalkulatorSederhana extends StatefulWidget {
  @override
  _KalkulatorSederhanaState createState() => _KalkulatorSederhanaState();
}

class _KalkulatorSederhanaState extends State<KalkulatorSederhana> {
  final TextEditingController angka1Controller = TextEditingController();
  final TextEditingController angka2Controller = TextEditingController();

  void tampilkanHasil(double hasil, BuildContext context) {

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Hasil: $hasil')),
    );
  }

  double? getAngka(String text) {
    return double.tryParse(text);
  }

  void operasi(int tipe) {
    final angka1 = getAngka(angka1Controller.text);
    final angka2 = getAngka(angka2Controller.text);

    if (angka1 == null || angka2 == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Input tidak valid')),
      );
      return;
    }

    double hasil;

    switch (tipe) {
      case 1:
        hasil = angka1 + angka2;
        break;
      case 2:
        hasil = angka1 - angka2;
        break;
      case 3:
        hasil = angka1 * angka2;
        break;
      case 4:
        if (angka2 == 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Tidak bisa membagi dengan nol')),
          );
          return;
        }
        hasil = angka1 / angka2;
        break;
      default:
        return;
    }

    tampilkanHasil(hasil, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kalkulator Sederhana',
        ),
        centerTitle: true, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
         
            TextField(
              controller: angka1Controller,
              decoration: const InputDecoration(
                labelText: 'Angka Ke-1',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            TextField(
              controller: angka2Controller,
              decoration: const InputDecoration(
                labelText: 'Angka Ke-2',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => operasi(1),
                  child: const Text('TAMBAH'),
                ),
                ElevatedButton(
                  onPressed: () => operasi(2),
                  child: const Text('KURANG'),
                ),
                ElevatedButton(
                  onPressed: () => operasi(3),
                  child: const Text('KALI'),
                ),
                ElevatedButton(
                  onPressed: () => operasi(4),
                  child: const Text('BAGI'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}