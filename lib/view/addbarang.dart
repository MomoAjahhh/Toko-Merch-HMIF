import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:toko_merch_hmif/controller/barangControler.dart';

class HalamanTambahBarang extends StatefulWidget {
  const HalamanTambahBarang({super.key});

  @override
  State<HalamanTambahBarang> createState() => _HalamanTambahBarangState();
}

class _HalamanTambahBarangState extends State<HalamanTambahBarang> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController namaBarangController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();
  final TextEditingController kategoriController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController stokController = TextEditingController();
  
  final BarangController barangController = BarangController();
  bool isLoading = false;

  List<String> kategoriList = ['Pakaian', 'Aksesoris', 'Alat Tulis', 'Elektronik', 'Lainnya'];
  String? selectedKategori;

  @override
  void initState() {
    super.initState();
    hargaController.text = "10000";
    stokController.text = "1";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Barang", style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.inventory_2, size: 40, color: Theme.of(context).colorScheme.primary),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Form Tambah Barang", 
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Text("Lengkapi data barang di bawah ini",
                            style: TextStyle(color: Colors.grey[600])),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              
              SizedBox(height: 24),
              
              // Nama Barang
              TextFormField(
                controller: namaBarangController,
                decoration: InputDecoration(
                  labelText: "Nama Barang",
                  prefixIcon: Icon(Icons.shopping_bag),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Nama barang tidak boleh kosong";
                  }
                  return null;
                },
              ),
              
              SizedBox(height: 16),
              
              // Harga dan Stok dalam Row
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: hargaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Harga (Rp)",
                        prefixIcon: Icon(Icons.attach_money),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Harga tidak boleh kosong";
                        }
                        if (double.tryParse(value) == null) {
                          return "Harga harus angka";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: stokController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Stok",
                        prefixIcon: Icon(Icons.inventory),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        filled: true,
                        fillColor: Colors.grey[50],
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Stok tidak boleh kosong";
                        }
                        if (int.tryParse(value) == null) {
                          return "Stok harus angka";
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              
              SizedBox(height: 16),
              
              // Kategori Dropdown
              DropdownButtonFormField<String>(
                value: selectedKategori,
                decoration: InputDecoration(
                  labelText: "Kategori",
                  prefixIcon: Icon(Icons.category),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                items: kategoriList.map((String kategori) {
                  return DropdownMenuItem<String>(
                    value: kategori,
                    child: Text(kategori),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedKategori = newValue;
                    kategoriController.text = newValue ?? "";
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Pilih kategori";
                  }
                  return null;
                },
              ),
              
              SizedBox(height: 16),
              
              // Deskripsi
              TextFormField(
                controller: deskripsiController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "Deskripsi Barang",
                  alignLabelWithHint: true,
                  prefixIcon: Padding(
                    padding: EdgeInsets.only(bottom: 60),
                    child: Icon(Icons.description),
                  ),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Deskripsi tidak boleh kosong";
                  }
                  return null;
                },
              ),
              
              SizedBox(height: 32),
              
              // Submit Button
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _simpanBarang,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: isLoading 
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.save),
                          SizedBox(width: 8),
                          Text("Simpan Barang", style: TextStyle(fontSize: 16)),
                        ],
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _simpanBarang() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });
      
      try {
        String response = await barangController.tambahBarang(
          namaBarangController.text,
          double.parse(hargaController.text),
          int.parse(stokController.text),
          deskripsiController.text,
          kategoriController.text,
        );
        
        Map<String, dynamic> result = jsonDecode(response);
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result['message']),
            backgroundColor: result['status'] == 'success' ? Colors.green : Colors.red,
          )
        );
        
        if (result['status'] == 'success') {
          Navigator.pop(context, true); // Return true to indicate data was added
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red)
        );
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}