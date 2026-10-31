
import 'dart:async';

import 'kendaraan.dart';

class ParkirPenuh implements Exception {
  @override
  String toString() => 'Parkiran penuh';
}

class Parkiran {
  final int kapasitas;

  // Data kendaraan dibuat private.
  final List<Kendaraan> _kendaraan = [];

  int _pendapatan = 0;

  // Stream untuk mengirimkan informasi aktivitas parkir.
  final StreamController<String> _controller =
      StreamController<String>.broadcast();

  Parkiran({required this.kapasitas});

  // Getter untuk melihat sisa kapasitas.
  int get sisa => kapasitas - _kendaraan.length;

  // Getter untuk melihat total pendapatan.
  int get pendapatan => _pendapatan;

  // Stream yang dapat didengarkan oleh main.
  Stream<String> get events => _controller.stream;

  // Proses kendaraan masuk.
  Future<void> masuk(Kendaraan kendaraan) async {
    await Future.delayed(const Duration(seconds: 1));

    if (sisa <= 0) {
      throw ParkirPenuh();
    }

    _kendaraan.add(kendaraan);

    _controller.add(
      'MASUK ${kendaraan.jenis} ${kendaraan.plat} (sisa $sisa)',
    );
  }

  // Proses kendaraan keluar.
  Future<void> keluar(
    String plat,
    DateTime waktuKeluar,
  ) async {
    await Future.delayed(const Duration(seconds: 1));

    final index = _kendaraan.indexWhere(
      (kendaraan) => kendaraan.plat == plat,
    );

    if (index == -1) {
      throw Exception('Kendaraan tidak ditemukan');
    }

    final kendaraan = _kendaraan[index];
    final biaya = kendaraan.biaya(waktuKeluar);

    _kendaraan.removeAt(index);
    _pendapatan += biaya;

    _controller.add(
      'KELUAR ${kendaraan.jenis} ${kendaraan.plat} '
      'bayar Rp$biaya',
    );
  }

  // Menutup StreamController.
  Future<void> dispose() async {
    await _controller.close();
  }
}
