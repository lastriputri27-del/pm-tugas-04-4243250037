
abstract class Kendaraan {
  final String plat;
  final DateTime waktuMasuk;

  Kendaraan({
    required this.plat,
    required this.waktuMasuk,
  });

  String get jenis;

  int get tarifPerJam;

  int biaya(DateTime keluar) {
    final durasi = keluar.difference(waktuMasuk);
    final totalMenit = durasi.inMinutes;

    // Minimal biaya parkir adalah 1 jam.
    final jumlahJam = (totalMenit / 60).ceil();
    final jamDibayar = jumlahJam < 1 ? 1 : jumlahJam;

    return jamDibayar * tarifPerJam;
  }
}
