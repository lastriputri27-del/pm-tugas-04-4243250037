
import 'package:test/test.dart';
import 'package:pm_tugas_04_4243250037/jenis_kendaraan.dart';

void main() {
  group('Pengujian Kendaraan', () {
    final waktuMasuk = DateTime(2026, 10, 31, 8, 0);

    test('Motor menghitung biaya parkir 1 jam', () {
      final motor = Motor(
        plat: 'BK 1234 AB',
        waktuMasuk: waktuMasuk,
      );

      final biaya = motor.biaya(
        DateTime(2026, 10, 31, 9, 0),
      );

      expect(biaya, 6000);
    });

    test('Mobil menghitung biaya parkir 2 jam', () {
      final mobil = Mobil(
        plat: 'BK 88 UN',
        waktuMasuk: waktuMasuk,
      );

      final biaya = mobil.biaya(
        DateTime(2026, 10, 31, 10, 0),
      );

      expect(biaya, 10000);
    });

    test('Mobil member mendapat diskon 50%', () {
      final mobil = MobilMember(
        plat: 'BK 7 MIPA',
        waktuMasuk: waktuMasuk,
      );

      final biaya = mobil.biaya(
        DateTime(2026, 10, 31, 10, 0),
      );

      expect(biaya, 5000);
    });
  });
}
