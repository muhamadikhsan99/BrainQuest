import 'package:flutter/material.dart';

// Model untuk soal
class Question {
  final String question;
  final List<String> options;
  final int correctAnswer;
  final String hint; // Tambahan untuk menyimpan hint

  Question(this.question, this.options, this.correctAnswer, this.hint);
}

// Halaman untuk menampilkan kuis dan menangani logika
class QuizPage extends StatefulWidget {
  final String category;
  const QuizPage({required this.category});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  int score = 0;

   // Gambar latar belakang untuk setiap kategori
  final Map<String, String> backgroundImages = {
    'Geografi': 'assets/geografi_background.png',
    'Hewan': 'assets/hewan_background.png',
    'Sejarah': 'assets/sejarah_background.png',
    'Matematika': 'assets/matematika_background.png',
    'Teknologi': 'assets/teknologi_background.png',
    'Seni': 'assets/seni_background.png',
    'Musik': 'assets/musik_background.png',
    'Sastra': 'assets/sastra_background.png',
    'Filsafat': 'assets/filsafat_background.png',
    'Olahraga': 'assets/olahraga_background.png',
  };

    // Daftar soal berdasarkan kategori dengan hint
  final Map<String, List<Question>> questions = {
    'Geografi': [
      Question('Ibukota Indonesia adalah...', ['Jakarta', 'Bandung', 'Surabaya'], 0, 'Kota ini adalah pusat pemerintahan dan terletak di Pulau Jawa.'),
      Question('Benua terbesar di dunia adalah...', ['Asia', 'Afrika', 'Antartika'], 0, 'Benua ini dikenal dengan populasi dan wilayahnya yang sangat luas.'),
      Question('Negara yang memiliki jumlah penduduk terbanyak adalah...', ['China', 'India', 'USA'], 0, 'Negara ini terletak di Asia Timur.'),
      Question('Gunung tertinggi di dunia adalah...', ['Everest', 'Kilimanjaro', 'Fuji'], 0, 'Gunung ini bagian dari Pegunungan Himalaya.'),
      Question('Sungai terpanjang di dunia adalah...', ['Amazon', 'Nil', 'Yangtze'], 1, 'Sungai ini mengalir di benua Afrika.'),
      Question('Apa ibu kota Australia?', ['Sydney', 'Melbourne', 'Canberra'], 2, 'Ibukota ini bukan kota terbesar di Australia.'),
      Question('Negara dengan luas wilayah terbesar adalah...', ['Russia', 'Canada', 'China'], 0, 'Negara ini membentang dari Eropa hingga Asia.'),
      Question('Benua terkecil di dunia adalah...', ['Australia', 'Antartika', 'Eropa'], 0, 'Benua ini juga dikenal sebagai sebuah negara.'),
      Question('Danau terbesar di dunia adalah...', ['Caspian Sea', 'Lake Superior', 'Lake Victoria'], 0, 'Danau ini memiliki nama yang menyerupai laut.'),
      Question('Negara yang memiliki banyak pulau terbanyak adalah...', ['Indonesia', 'Philippines', 'Maldives'], 0, 'Negara ini memiliki ribuan pulau dan terletak di Asia Tenggara.'),
    ],
    'Hewan': [
      Question('Hewan tercepat di dunia adalah...', ['Cheetah', 'Kelinci', 'Kuda'], 0, 'Hewan ini dikenal karena larinya yang sangat cepat dan hidup di padang rumput Afrika.'),
      Question('Hewan yang bisa terbang adalah...', ['Burung', 'Gajah', 'Kucing'], 0, 'Hewan ini memiliki sayap dan bulu.'),
      Question('Hewan yang hidup di air adalah...', ['Ikan', 'Kuda', 'Monyet'], 0, 'Hewan ini bernapas menggunakan insang.'),
      Question('Hewan yang dikenal sebagai raja hutan adalah...', ['Singa', 'Harimau', 'Serigala'], 0, 'Hewan ini memiliki surai pada jantannya dan dikenal dengan aumannya.'),
      Question('Hewan yang bisa hidup di gurun adalah...', ['Unta', 'Kelinci', 'Beruang'], 0, 'Hewan ini dikenal mampu bertahan tanpa air dalam waktu lama.'),
      Question('Hewan yang memiliki cangkang keras adalah...', ['Kura-kura', 'Ikan', 'Kucing'], 0, 'Hewan ini memiliki rumah yang dibawanya ke mana-mana.'),
      Question('Kucing memiliki berapa jumlah gigi?', ['30', '32', '28'], 1, 'Jumlah giginya sedikit lebih banyak dari manusia.'),
      Question('Hewan yang bisa memanjat pohon adalah...', ['Kera', 'Anjing', 'Kucing'], 0, 'Hewan ini sering ditemukan di hutan dan memakan buah-buahan.'),
      Question('Hewan yang dapat berburu dengan menggunakan sonar adalah...', ['Dolphin', 'Kelelawar', 'Burung'], 1, 'Hewan ini berburu di malam hari dan terbang dengan cara unik.'),
      Question('Hewan yang paling pintar adalah...', ['Dolphin', 'Gajah', 'Anjing'], 0, 'Hewan ini hidup di air dan dikenal memiliki kecerdasan tinggi.'),
    ],
    'Sejarah': [
      Question('Siapa penemu lampu pijar?', ['Thomas Edison', 'Albert Einstein', 'Nikola Tesla'], 0, 'Penemu ini dikenal sebagai bapak teknologi modern, dengan banyak paten atas namanya.'),
      Question('Perang Dunia II dimulai pada tahun...', ['1939', '1914', '1945'], 0, 'Perang ini dimulai dengan invasi Jerman ke Polandia.'),
      Question('Presiden pertama Amerika Serikat adalah...', ['George Washington', 'Abraham Lincoln', 'Thomas Jefferson'], 0, 'Presiden ini dikenal sebagai salah satu bapak pendiri Amerika Serikat.'),
      Question('Jepang menyerang Pearl Harbor pada tahun...', ['1941', '1939', '1914'], 0, 'Serangan ini menyebabkan Amerika Serikat terlibat dalam Perang Dunia II.'),
      Question('Tanggal Kemerdekaan Indonesia adalah...', ['17 Agustus 1945', '20 Mei 1908', '28 Oktober 1928'], 0, 'Tanggal ini ditandai dengan proklamasi kemerdekaan oleh Soekarno dan Hatta.'),
      Question('Raja Inggris yang terkenal dengan julukan "Ratu Victoria" adalah...', ['Queen Elizabeth II', 'King George VI', 'Queen Victoria'], 2, 'Ratu ini memerintah selama era keemasan industri Inggris.'),
      Question('Revolusi Prancis terjadi pada tahun...', ['1789', '1800', '1776'], 0, 'Revolusi ini ditandai dengan jatuhnya Bastille dan berakhirnya kekuasaan monarki.'),
      Question('Siapa penulis "The Communist Manifesto"?', ['Karl Marx', 'Friedrich Engels', 'Mao Zedong'], 0, 'Penulis ini berasal dari Jerman dan bekerja sama dengan Friedrich Engels.'),
      Question('Siapa yang menjadi Presiden pertama Indonesia?', ['Soekarno', 'Sukarno', 'Habibie'], 0, 'Presiden ini adalah proklamator kemerdekaan Indonesia.'),
      Question('Perjanjian yang mengakhiri Perang Dunia I disebut...', ['Versailles', 'Potsdam', 'Yalta'], 0, 'Perjanjian ini ditandatangani di sebuah istana di Prancis.'),
    ],
    'Matematika': [
      Question('Berapa hasil dari 5 + 3?', ['8', '7', '6'], 0, 'Hasil ini didapatkan dengan menambahkan lima dengan tiga.'),
      Question('Berapa hasil dari 12 x 2?', ['24', '22', '30'], 0, 'Perkalian ini melibatkan penggandaan dua belas dua kali.'),
      Question('Berapa hasil dari 15 / 3?', ['5', '6', '4'], 0, 'Hasil ini didapatkan dengan membagi lima belas dengan tiga.'),
      Question('Jumlah sudut dalam segitiga adalah...', ['180 derajat', '360 derajat', '90 derajat'], 0, 'Setiap sudut segitiga berjumlah hingga nilai tetap ini.'),
      Question('Perimeter lingkaran dihitung dengan rumus...', ['2πr', 'πr²', 'πd'], 0, 'Rumus ini melibatkan keliling lingkaran dan jari-jari.'),
      Question('Jumlah sisi segiempat adalah...', ['4', '5', '6'], 0, 'Bentuk ini memiliki empat sisi yang sama atau tidak sama panjang.'),
      Question('Rumus luas persegi panjang adalah...', ['panjang x lebar', 'panjang x tinggi', 'lebar x tinggi'], 0, 'Rumus ini menggunakan dua dimensi utama persegi panjang.'),
      Question('Tiga sisi segitiga adalah 3 cm, 4 cm, dan 5 cm. Apa panjang hipotenusanya?', ['5 cm', '6 cm', '7 cm'], 0, 'Segitiga ini adalah segitiga siku-siku, gunakan teorema Pythagoras.'),
      Question('Berapa hasil dari 25 x 4?', ['100', '105', '110'], 0, 'Hasil ini adalah perkalian dua puluh lima dengan empat.'),
      Question('Jumlah angka pada bilangan genap pertama adalah...', ['10', '12', '14'], 0, 'Bilangan genap pertama adalah 2, 4, 6, dan 8.'),

    ],
    'Teknologi': [
    Question('Siapa pendiri Apple?', ['Steve Jobs', 'Bill Gates', 'Mark Zuckerberg'], 0, 'Dia juga dikenal sebagai salah satu inovator besar di dunia teknologi.'),
    Question('Apa kepanjangan dari HTML?', ['HyperText Markup Language', 'Home Text Markup Language', 'HighText Markup Language'], 0, 'Ini adalah standar utama untuk membuat halaman web.'),
    Question('Framework yang digunakan untuk membuat aplikasi Android adalah...', ['Flutter', 'Django', 'React'], 0, 'Framework ini dikembangkan oleh Google dan berbasis Dart.'),
    Question('Siapa yang menciptakan Microsoft Windows?', ['Bill Gates', 'Steve Jobs', 'Mark Zuckerberg'], 0, 'Tokoh ini juga dikenal dengan perusahaan bernama Microsoft.'),
    Question('Apa kepanjangan dari CPU?', ['Central Processing Unit', 'Central Program Unit', 'Central Power Unit'], 0, 'Ini adalah otak dari komputer yang mengatur proses data.'),
    Question('Apple merilis iPhone pertama pada tahun...', ['2007', '2010', '2012'], 0, 'Tahun ini adalah awal revolusi smartphone.'),
    Question('Google didirikan pada tahun...', ['1998', '2000', '2005'], 0, 'Dua pendirinya adalah Larry Page dan Sergey Brin.'),
    Question('Sistem operasi open-source yang paling banyak digunakan adalah...', ['Linux', 'Windows', 'MacOS'], 0, 'Sistem operasi ini memiliki banyak distribusi seperti Ubuntu dan Fedora.'),
    Question('Bahasa pemrograman yang digunakan untuk membuat aplikasi Android adalah...', ['Java', 'Swift', 'C#'], 0, 'Bahasa ini sudah lama menjadi standar untuk pengembangan aplikasi Android.'),
    Question('Laptop pertama kali diciptakan oleh...', ['IBM', 'Apple', 'Dell'], 0, 'Perusahaan ini juga dikenal dengan komputer personal pada 1980-an.'),
    ],
    'Seni': [
    Question('Lukisan Mona Lisa dibuat oleh...', ['Leonardo da Vinci', 'Pablo Picasso', 'Vincent van Gogh'], 0, 'Pelukis ini juga seorang penemu dari masa Renaisans.'),
    Question('Film pertama yang menggunakan efek CGI adalah...', ['Jurassic Park', 'Avatar', 'Terminator 2'], 0, 'Film ini melibatkan dinosaurus yang tampak hidup.'),
    Question('Alat musik yang dimainkan dengan dipukul adalah...', ['Gitar', 'Piano', 'Drum'], 0, 'Alat musik ini biasanya digunakan di band.'),
    Question('Patung David dibuat oleh...', ['Michelangelo', 'Donatello', 'Raphael'], 0, 'Patung ini adalah salah satu karya seni terkenal dari zaman Renaisans.'),
    Question('Tarian tradisional Indonesia yang menggunakan kipas adalah...', ['Saman', 'Legong', 'Tari Kecak'], 1, 'Tarian ini berasal dari Bali.'),
    Question('Film animasi pertama yang diproduksi oleh Disney adalah...', ['Steamboat Willie', 'Snow White', 'Pinocchio'], 0, 'Film ini dirilis pada tahun 1928.'),
    Question('Periode seni yang terkenal dengan aliran kubisme adalah...', ['Impresionisme', 'Futurisme', 'Kubisme'], 2, 'Aliran seni ini dipelopori oleh Pablo Picasso.'),
    Question('Siapa pelukis yang terkenal dengan lukisan The Starry Night?', ['Vincent van Gogh', 'Claude Monet', 'Salvador Dali'], 0, 'Pelukis ini dikenal dengan gaya pasca-impresionisme.'),
    Question('Siapa penulis novel "Harry Potter"?', ['J.K. Rowling', 'George R.R. Martin', 'J.R.R. Tolkien'], 0, 'Dia adalah seorang penulis Inggris terkenal dengan seri tentang penyihir.'),
    Question('Film "Titanic" disutradarai oleh...', ['James Cameron', 'Steven Spielberg', 'George Lucas'], 0, 'Film ini memenangkan 11 Academy Awards.'),
    ],
    'Musik': [
       Question('Siapa penyanyi yang dikenal dengan lagu "Thriller"?', ['Michael Jackson', 'Elvis Presley', 'Prince'], 0, 'Penyanyi ini dijuluki sebagai "The King of Pop".'),
    Question('Genre musik yang berasal dari Jamaika adalah...', ['Reggae', 'Rock', 'Pop'], 0, 'Genre musik ini terkenal dengan ritme yang santai dan pesan-pesan sosial.'),
    Question('Siapa penyanyi yang dikenal dengan lagu "Shape of You"?', ['Ed Sheeran', 'Justin Bieber', 'Ariana Grande'], 0, 'Penyanyi asal Inggris ini dikenal dengan lagu-lagu hitsnya.'),
    Question('Alat musik yang dipetik dan memiliki 6 senar adalah...', ['Gitar', 'Piano', 'Drum'], 0, 'Alat musik ini sering digunakan dalam berbagai genre musik.'),
    Question('Siapa yang dikenal sebagai "The Queen of Pop"?', ['Madonna', 'Beyoncé', 'Lady Gaga'], 0, 'Dia adalah salah satu ikon terbesar dalam dunia musik pop.'),
    Question('Siapa penyanyi yang dikenal dengan lagu "Rolling in the Deep"?', ['Adele', 'Katy Perry', 'Taylor Swift'], 0, 'Penyanyi ini dikenal dengan suara khasnya yang kuat.'),
    Question('Alat musik yang memiliki tuts dan dipukul adalah...', ['Piano', 'Gitar', 'Saksophone'], 0, 'Alat musik ini digunakan dalam banyak konser orkestra.'),
    Question('Siapa musisi legendaris yang terkenal dengan lagu "Imagine"?', ['John Lennon', 'Paul McCartney', 'George Harrison'], 0, 'Dia adalah anggota The Beatles yang sangat berpengaruh.'),
    Question('Benda yang digunakan untuk memukul drum adalah...', ['Stik drum', 'Gitar', 'Microphone'], 0, 'Ini adalah alat yang digunakan dalam permainan drum untuk memukul membran.'),
    Question('Siapa penyanyi yang terkenal dengan lagu "Bad Romance"?', ['Lady Gaga', 'Beyoncé', 'Kesha'], 0, 'Penyanyi ini dikenal dengan penampilannya yang teatrikal dan lagu-lagu hitsnya.'),
    ],
    'Sastra': [
      Question('Siapa pengarang novel "Don Quixote"?', ['Miguel de Cervantes', 'William Shakespeare', 'Homer'], 0, 'Penulis asal Spanyol ini terkenal dengan novel klasiknya.'),
    Question('Novel "Harry Potter" ditulis oleh?', ['J.K. Rowling', 'George R.R. Martin', 'J.R.R. Tolkien'], 0, 'Penulis asal Inggris ini dikenal dengan karya tentang penyihir muda.'),
    Question('Siapa pengarang "Laskar Pelangi"?', ['Andrea Hirata', 'Pramoedya Ananta Toer', 'Ayu Utami'], 0, 'Penulis asal Indonesia ini menulis tentang kehidupan di Belitung.'),
    Question('Buku "The Great Gatsby" ditulis oleh?', ['F. Scott Fitzgerald', 'Ernest Hemingway', 'Mark Twain'], 0, 'Penulis ini menggambarkan kehidupan mewah pada era 1920-an.'),
    Question('Siapa penulis "1984"?', ['George Orwell', 'Aldous Huxley', 'Ray Bradbury'], 0, 'Penulis ini terkenal dengan karyanya tentang dunia distopia.'),
    Question('Buku "The Catcher in the Rye" ditulis oleh?', ['J.D. Salinger', 'William Golding', 'John Steinbeck'], 0, 'Penulis ini mengisahkan kehidupan remaja di New York City.'),
    Question('Siapa pengarang "To Kill a Mockingbird"?', ['Harper Lee', 'Jane Austen', 'Charles Dickens'], 0, 'Penulis asal Amerika ini menggambarkan isu-isu rasial di Selatan AS.'),
    Question('Siapa yang menulis "Pride and Prejudice"?', ['Jane Austen', 'Charlotte Brontë', 'Emily Dickinson'], 0, 'Penulis ini dikenal dengan novel romantis yang tajam.'),
    Question('Siapa pengarang "The Hobbit"?', ['J.R.R. Tolkien', 'C.S. Lewis', 'J.K. Rowling'], 0, 'Penulis asal Inggris ini menciptakan dunia fiksi Middle-earth.'),
    Question('Siapa penulis "Moby Dick"?', ['Herman Melville', 'Mark Twain', 'Nathaniel Hawthorne'], 0, 'Penulis ini terkenal dengan karya-karyanya yang berhubungan dengan laut.'),
    ],
    'Filsafat': [
      Question('Siapa tokoh yang dikenal dengan teori "Tabula Rasa"?', ['John Locke', 'Immanuel Kant', 'Jean-Jacques Rousseau'], 0, 'Filsuf ini berpendapat bahwa pikiran manusia pada awalnya seperti kertas kosong.'),
    Question('Filsuf yang terkenal dengan konsep "Cogito, ergo sum" adalah...', ['René Descartes', 'Aristoteles', 'Plato'], 0, 'Filsuf ini dikenal dengan pernyataan "Aku berpikir, maka aku ada".'),
    Question('Apa yang dimaksud dengan "Nirvana" dalam ajaran Buddha?', ['Keadaan tanpa penderitaan', 'Pencerahan', 'Kehidupan setelah mati'], 0, 'Nirvana adalah tujuan akhir dalam ajaran Buddha, menghapus penderitaan dan keinginan.'),
    Question('Tokoh yang mencetuskan teori "Tanggung Jawab Individu" adalah...', ['Jean-Paul Sartre', 'Karl Marx', 'Friedrich Nietzsche'], 0, 'Filsuf ini dikenal dengan pandangannya tentang eksistensialisme.'),
    Question('Filsuf Yunani yang terkenal dengan teori "Form" adalah...', ['Plato', 'Socrates', 'Aristoteles'], 0, 'Filsuf ini mengembangkan teori tentang ide atau bentuk ideal.'),
    Question('Siapa filsuf yang menulis buku "The Republic"?', ['Plato', 'Aristotle', 'Socrates'], 0, 'Filsuf ini menggambarkan konsep negara ideal dalam karyanya.'),
    Question('Siapa yang mengemukakan teori "Empirisme" dalam filsafat?', ['John Locke', 'David Hume', 'Bertrand Russell'], 0, 'Filsuf ini berpendapat bahwa pengetahuan berasal dari pengalaman.'),
    Question('Apa yang dimaksud dengan "Alam Semesta" dalam filsafat?', ['Totalitas dari segala sesuatu', 'Keadaan alami manusia', 'Fenomena pikiran'], 0, 'Konsep ini mencakup semua yang ada dalam dunia fisik dan non-fisik.'),
    Question('Filsuf yang terkenal dengan prinsip "Berani Mengetahui" adalah...', ['Immanuel Kant', 'René Descartes', 'Friedrich Nietzsche'], 0, 'Filsuf ini terkenal dengan ajaran tentang pentingnya rasio dan akal.'),
    Question('Ajaran Stoisisme diajarkan oleh tokoh bernama...', ['Zeno dari Citium', 'Socrates', 'Aristoteles'], 0, 'Filsuf ini mengajarkan pengendalian diri dan ketenangan batin di tengah kesulitan.'),
    ],
    'Olahraga': [
     Question('Pemain sepak bola dengan julukan "CR7" adalah...', ['Cristiano Ronaldo', 'Lionel Messi', 'Neymar'], 0, 'Pemain asal Portugal ini dikenal dengan skill dan dedikasinya di lapangan.'),
    Question('Tim yang memenangkan Piala Dunia 2018 adalah...', ['Prancis', 'Brazil', 'Jerman'], 0, 'Tim ini mengalahkan Kroasia di final dan meraih gelar ke-2 mereka.'),
    Question('Atlet yang memenangkan 8 medali emas di Olimpiade 2008 adalah...', ['Michael Phelps', 'Usain Bolt', 'Mark Spitz'], 0, 'Atlet renang asal Amerika ini memecahkan banyak rekor dunia.'),
    Question('Jenis olahraga yang dimainkan di lapangan berpasir adalah...', ['Volleyball Pantai', 'Sepak Bola', 'Tenis'], 0, 'Olahraga ini dimainkan oleh dua tim di pantai dengan bola besar.'),
    Question('Pemain tenis yang dikenal dengan julukan "King of Clay" adalah...', ['Rafael Nadal', 'Roger Federer', 'Novak Djokovic'], 0, 'Pemain tenis asal Spanyol ini terkenal dengan dominasi di lapangan tanah liat.'),
    Question('Olahraga yang menggunakan raket dan shuttlecock disebut...', ['Badminton', 'Tenis', 'Squash'], 0, 'Olahraga ini biasanya dimainkan di dalam ruangan dengan dua atau empat pemain.'),
    Question('Lari marathon biasanya diadakan dalam jarak...', ['42,195 km', '25 km', '50 km'], 0, 'Marathon adalah lomba lari jarak jauh yang diakui secara internasional.'),
    Question('Siapa pelari tercepat di dunia saat ini?', ['Usain Bolt', 'Tyson Gay', 'Yohan Blake'], 0, 'Atlet asal Jamaika ini memegang rekor dunia untuk lari 100m dan 200m.'),
    Question('Di mana Olimpiade pertama kali diselenggarakan?', ['Athena, Yunani', 'Roma, Italia', 'Paris, Prancis'], 0, 'Olimpiade pertama kali diadakan pada tahun 776 SM di kota ini.'),
    Question('Pemenang Liga Champions 2020 adalah...', ['Bayern Munich', 'Paris Saint-Germain', 'Liverpool'], 0, 'Tim Jerman ini mengalahkan PSG di final untuk memenangkan trofi mereka yang keenam.'),
    ],
  };
void answerQuestion(int selectedIndex) {
  if (selectedIndex == questions[widget.category]![currentQuestionIndex].correctAnswer) {
    score++;
  }

  setState(() {
    currentQuestionIndex++;
  });
}

 @override
Widget build(BuildContext context) {
  String category = widget.category;
  String backgroundImage = 'assets/futuristic_purple_background.png';

  bool isQuizCompleted = currentQuestionIndex >= questions[category]!.length;

  return Scaffold(
    appBar: AppBar(
      title: Text(category),
    ),
    body: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(backgroundImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isQuizCompleted
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Kuis Selesai!',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Skor Kamu: $score / ${questions[category]!.length}',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          currentQuestionIndex = 0;
                          score = 0;
                        });
                      },
                      child: Text('Main Lagi'),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Kembali ke halaman sebelumnya
                      },
                      child: Text('Kembali'),
                    ),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        questions[category]![currentQuestionIndex].question,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ...questions[category]![currentQuestionIndex].options.asMap().entries.map(
                    (entry) {
                      int index = entry.key;
                      String option = entry.value;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            if (index == questions[category]![currentQuestionIndex].correctAnswer) {
                              score++;
                            }
                            setState(() {
                              currentQuestionIndex++;
                            });
                          },
                          child: Text(option, style: TextStyle(fontSize: 16)),
                       ),
                        );
                      },
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}