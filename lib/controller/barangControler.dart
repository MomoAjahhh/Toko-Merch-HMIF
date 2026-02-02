import 'package:http/http.dart' as http;

class BarangController {
  Future<String> fetchData() async {
    // Implementasi pengambilan data barang dari API
    final response = await http.get(Uri.parse('http://192.168.100.141/api_toko_hmif/getBarang.php'));
    if (response.statusCode == 200) {
      // Berhasil mendapatkan data
      return response.body;
    } else {
      // Gagal mendapatkan data
      return "Data gagal diambil";
    }
  }
}
