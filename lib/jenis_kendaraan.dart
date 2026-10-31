
import 'kendaraan.dart';

// Mixin untuk kendaraan yang memiliki keanggotaan.
mixin Berlangganan {
  int diskon(int biaya) {
    return (biaya * 0.5).round();
  }
}

class Motor extends Kendaraan {
  Motor({
    required super.plat,
    required super.waktuMasuk,
  });

  @override
  String get jenis => 'Motor';

  @override
  int get tarifPerJam => 6000;
}

class Mobil extends Kendaraan {
  Mobil({
    required super.plat,
    required super.waktuMasuk,
  });

  @override
  String get jenis => 'Mobil';

  @override
  int get tarifPerJam => 5000;
}

class Truk extends Kendaraan {
  Truk({
    required super.plat,
    required super.waktuMasuk,
  });

  @override
  String get jenis => 'Truk';

  @override
  int get tarifPerJam => 10000;
}

// Mobil dengan fasilitas member.
class MobilMember extends Mobil with Berlangganan {
  MobilMember({
    required super.plat,
    required super.waktuMasuk,
  });

  @override
  int biaya(DateTime keluar) {
    final biayaNormal = super.biaya(keluar);
    return diskon(biayaNormal);
  }
}