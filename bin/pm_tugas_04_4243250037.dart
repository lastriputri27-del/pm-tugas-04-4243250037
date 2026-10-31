
import 'package:pm_tugas_04_4243250037/jenis_kendaraan.dart';
import 'package:pm_tugas_04_4243250037/kendaraan.dart';
import 'package:pm_tugas_04_4243250037/parkiran.dart';

Future<void> main() async {
  print('=== SISTEM PARKIR KAMPUS FMIPA ===');

  final parkiran = Parkiran(kapasitas: 3);

  final subscription = parkiran.events.listen((event) {
    print(event);
  });

  final waktuMasuk = DateTime(2026, 10, 31, 8, 0);

  final List<Kendaraan> kendaraan = [
    Motor(plat: 'BK 1234 AB', waktuMasuk: waktuMasuk),
    Mobil(plat: 'BK 88 UN', waktuMasuk: waktuMasuk),
    MobilMember(plat: 'BK 7 MIPA', waktuMasuk: waktuMasuk),
  ];

  for (final item in kendaraan) {
    try {
      await parkiran.masuk(item);
    } on ParkirPenuh catch (e) {
      print('Ditolak: $e');
    }
  }

  try {
    await parkiran.masuk(
      Truk(plat: 'BK 9999 TR', waktuMasuk: waktuMasuk),
    );
  } on ParkirPenuh catch (e) {
    print('Ditolak: $e (kapasitas ${parkiran.kapasitas})');
  }

  await parkiran.keluar(
    'BK 1234 AB',
    DateTime(2026, 10, 31, 9, 0),
  );

  await parkiran.keluar(
    'BK 88 UN',
    DateTime(2026, 10, 31, 11, 0),
  );

  await parkiran.keluar(
    'BK 7 MIPA',
    DateTime(2026, 10, 31, 11, 0),
  );

// Memberi waktu agar seluruh event Stream ditampilkan.
await Future<void>.delayed(
  const Duration(milliseconds: 100),
);

print('Pendapatan: Rp${parkiran.pendapatan}');

await subscription.cancel();
await parkiran.dispose();
}