import 'package:flutter/material.dart';
import 'category_page.dart';

class WelcomePage extends StatelessWidget {
  final VoidCallback onToggleTheme;

  // Konstruktor untuk menerima callback onToggleTheme
  WelcomePage({required this.onToggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Asah Otak Seru!'),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: onToggleTheme, // Mengubah tema saat tombol ini ditekan
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF8A2BE2), // Ungu terang
              Color(0xFF4B0082), // Ungu gelap
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Teks Selamat Datang
              Text(
                'Selamat Datang di BrainQuest!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 20),
              // Gambar logo
              Image.asset(
                'assets/images/logo.png', // Pastikan path gambar sudah benar
                width: 100,  // Atur lebar gambar
                height: 100, // Atur tinggi gambar
                fit: BoxFit.cover, // Menyesuaikan gambar dengan ruang yang tersedia
              ),
              SizedBox(height: 20),
              // Tombol untuk navigasi ke halaman kategori
              ElevatedButton(
                onPressed: () {
                  // Navigasi ke halaman kategori
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CategoryPage()),
                  );
                },
                child: Text('Mulai Kuis'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
