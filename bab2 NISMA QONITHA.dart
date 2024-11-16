import 'dart:async';

enum Kategori { DataManagement, NetworkAutomation }

class ProdukDigital {
  String namaProduk;
  double harga;
  Kategori kategori;
  int jumlahTerjual;

  ProdukDigital(this.namaProduk, this.harga, this.kategori, {this.jumlahTerjual = 0});

  void terapkanDiskon() {
    if (kategori == Kategori.NetworkAutomation && jumlahTerjual > 50) {
      double diskon = harga * 0.15;
      double hargaSetelahDiskon = harga - diskon;
      if (hargaSetelahDiskon < 200000) {
        print("Diskon tidak diterapkan, harga final tidak boleh di bawah 200000.");
      } else {
        harga = hargaSetelahDiskon;
        print("Diskon 15% diterapkan, harga baru: Rp${harga.toStringAsFixed(0)}");
      }
    } else {
      print("Produk tidak memenuhi syarat untuk diskon.");
    }
  }
}

abstract class Karyawan {
  String nama;
  int umur;
  String peran;

  Karyawan(this.nama, {required this.umur, required this.peran});

  void bekerja();
}

class KaryawanTetap extends Karyawan {
  KaryawanTetap(String nama, {required int umur, required String peran})
      : super(nama, umur: umur, peran: peran);

  @override
  void bekerja() {
    print("$nama yang berperan sebagai $peran sedang bekerja secara tetap.");
  }
}

class KaryawanKontrak extends Karyawan {
  KaryawanKontrak(String nama, {required int umur, required String peran})
      : super(nama, umur: umur, peran: peran);

  @override
  void bekerja() {
    print("$nama yang berperan sebagai $peran sedang bekerja secara kontrak.");
  }
}

mixin Kinerja {
  int produktivitas = 100;

  void tambahProduktivitas(int nilai) {
    if (nilai >= 0 && nilai <= 100) {
      produktivitas += nilai;
      if (produktivitas > 100) produktivitas = 100;
      print("Produktivitas meningkat: $produktivitas");
    }
  }

  void kurangiProduktivitas(int nilai) {
    if (nilai >= 0 && nilai <= 100) {
      produktivitas -= nilai;
      if (produktivitas < 0) produktivitas = 0;
      print("Produktivitas menurun: $produktivitas");
    }
  }
}

class Manager extends Karyawan with Kinerja {
  Manager(String nama, {required int umur}) : super(nama, umur: umur, peran: 'Manager');

  @override
  void bekerja() {
    if (produktivitas >= 85) {
      print("$nama sedang bekerja sebagai Manager dengan produktivitas tinggi: $produktivitas.");
    } else {
      print("$nama tidak bisa bekerja sebagai Manager karena produktivitas rendah.");
    }
  }
}

enum FaseProyek { Perencanaan, Pengembangan, Evaluasi }

class Proyek {
  FaseProyek fase = FaseProyek.Perencanaan;
  int jumlahKaryawanAktif;
  int hariBerjalan;

  Proyek(this.jumlahKaryawanAktif, this.hariBerjalan);

  void nextFase() {
    if (fase == FaseProyek.Perencanaan && jumlahKaryawanAktif >= 5) {
      fase = FaseProyek.Pengembangan;
      print("Berpindah ke fase Pengembangan.");
    } else if (fase == FaseProyek.Pengembangan && hariBerjalan > 45) {
      fase = FaseProyek.Evaluasi;
      print("Berpindah ke fase Evaluasi.");
    } else {
      print("Tidak bisa berpindah fase, syarat belum terpenuhi.");
    }
  }
}

class Perusahaan {
  List<Karyawan> karyawanAktif = [];
  List<Karyawan> karyawanNonAktif = [];

  void tambahKaryawan(Karyawan karyawan) {
    if (karyawanAktif.length < 20) {
      karyawanAktif.add(karyawan);
      print("${karyawan.nama} ditambahkan sebagai karyawan aktif.");
    } else {
      print("Tidak bisa menambahkan karyawan, jumlah maksimal tercapai.");
    }
  }

  void karyawanResign(Karyawan karyawan) {
    karyawanAktif.remove(karyawan);
    karyawanNonAktif.add(karyawan);
    print("${karyawan.nama} telah resign dan menjadi karyawan non-aktif.");
  }
}

void main() {
  ProdukDigital produk1 = ProdukDigital("Sistem Otomasi Jaringan", 250000, Kategori.NetworkAutomation, jumlahTerjual: 60);
  ProdukDigital produk2 = ProdukDigital("Sistem Manajemen Data", 150000, Kategori.DataManagement);

  produk1.terapkanDiskon();
  produk2.terapkanDiskon();

  KaryawanTetap dev = KaryawanTetap("sila", umur: 20, peran: "Developer");
  Manager manajer = Manager("nisma", umur: 20);

  manajer.tambahProduktivitas(5);
  manajer.bekerja();

  Proyek proyek = Proyek(6, 50);
  proyek.nextFase();

  Perusahaan perusahaan = Perusahaan();
  perusahaan.tambahKaryawan(dev);
  perusahaan.tambahKaryawan(manajer);

  perusahaan.karyawanResign(dev);
}