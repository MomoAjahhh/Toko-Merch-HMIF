import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:toko_merch_hmif/controller/barangControler.dart';
import 'package:toko_merch_hmif/models/barang.dart';

class HalamanBarang extends StatefulWidget {
  const HalamanBarang({super.key});

  @override
  State<HalamanBarang> createState() => _HalamanBarangState();
}

class _HalamanBarangState extends State<HalamanBarang> {

  BarangController barangController = BarangController();
  String _temp = "waiting respose...";
  List<Barang> listBarang = [];

  @override
  void initState() {
    super.initState();
    bacaData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(_temp),
      ),
    );
  }

  bacaData() async {
    Future<String> data = barangController.fetchData();
    
    data.then((value) {
      Map json = jsonDecode(value);
      for (var item in json['data']) {
        listBarang.add(Barang.fromJson(item));
      }

      setState(() {
        _temp = listBarang[2].deskripsi;
      });
    });
  }

  Widget daftarBarang(listBarang) {
    if (listBarang.isEmpty || listBarang == null) {
      return CircularProgressIndicator();
    }else {
      return ListView.builder(
        itemCount: listBarang.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(listBarang[index].namaBarang),
            subtitle: Text(listBarang[index].deskripsi),
          );
        },
      );
    }
  }
}