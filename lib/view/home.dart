import 'package:flutter/material.dart';
import 'package:toko_merch_hmif/view/barang.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Selamat datang, di Toko Merch HMIF!"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, 
                MaterialPageRoute(builder: (BuildContext context) => HalamanBarang() ,));
              },
              child: Text("Lihat Barang"),
            )
          ],
        ),
      ),
    );
  }
}