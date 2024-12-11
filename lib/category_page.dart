import 'package:flutter/material.dart';
import 'quiz_page.dart';

class CategoryPage extends StatelessWidget {
  // Daftar kategori yang tersedia
  final List<String> categories = [
    'Geografi',
    'Hewan',
    'Sejarah',
    'Matematika',
    'Teknologi',
    'Seni',
    'Musik',
    'Filsafat',
    'Olahraga',
    'Sastra',
  ];

  // Menambahkan gambar untuk setiap kategori
  final List<String> categoryImages = [
    'assets/images/geografi.png', // Gambar untuk Geografi
    'assets/images/hewan.png',    // Gambar untuk Hewan
    'assets/images/sejarah.png',  // Gambar untuk Sejarah
    'assets/images/matematika.png', // Gambar untuk Matematika
    'assets/images/teknologi.png',  // Gambar untuk Teknologi
    'assets/images/seni.png',      // Gambar untuk Seni
    'assets/images/musik.png',     // Gambar untuk Musik
    'assets/images/filsafat.png',  // Gambar untuk Filsafat
    'assets/images/olahraga.png',  // Gambar untuk Olahraga
    'assets/images/sastra.png',    // Gambar untuk Sastra
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Kategori Soal'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple, // Warna AppBar yang lebih elegan
      ),
      body: Container(
        // Menambahkan background ungu futuristik dengan gradien
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple.shade900, Colors.purple.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              // Menentukan warna gradien yang berbeda untuk setiap card
              List<Color> gradientColors;
              switch (index % 5) {
                case 0:
                  gradientColors = [Colors.blue.shade500, Colors.blue.shade700];
                  break;
                case 1:
                  gradientColors = [Colors.green.shade500, Colors.green.shade700];
                  break;
                case 2:
                  gradientColors = [Colors.red.shade500, Colors.red.shade700];
                  break;
                case 3:
                  gradientColors = [Colors.orange.shade500, Colors.orange.shade700];
                  break;
                case 4:
                  gradientColors = [Colors.pink.shade500, Colors.pink.shade700];
                  break;
                default:
                  gradientColors = [Colors.purple.shade500, Colors.purple.shade700];
              }

              return GestureDetector(
                onTap: () {
                  // Navigasi ke halaman kuis berdasarkan kategori yang dipilih
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          QuizPage(category: categories[index]),
                    ),
                  );
                },
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 10, // Memberikan bayangan untuk tampilan elegan
                  shadowColor: Colors.black45, // Warna bayangan yang lebih lembut
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Membuat sudut card melengkung
                  ),
                  child: Container(
                    // Menambahkan gradien pada setiap card
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: gradientColors,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(categoryImages[index]), // Menambahkan gambar
                        radius: 30, // Ukuran avatar
                      ),
                      title: Text(
                        categories[index],
                        style: TextStyle(
                          fontSize: 20, // Ukuran font lebih besar
                          fontWeight: FontWeight.bold, // Memberikan efek bold pada teks
                          color: Colors.white, // Teks putih untuk kontras yang elegan
                          letterSpacing: 1.2, // Menambah jarak antar huruf agar lebih elegan
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
