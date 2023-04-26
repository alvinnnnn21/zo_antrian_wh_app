// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:sutindo_supir_app/models/pengeluaran_model.dart';
import 'package:sutindo_supir_app/services/pengeluaran_service.dart';

class PengeluaranProvider extends ChangeNotifier {
  Pengeluaran _pengeluaran = Pengeluaran();

  Pengeluaran get pengeluaran => _pengeluaran;

  set pengeluaran(Pengeluaran pengeluaran) {
    _pengeluaran = pengeluaran;
    notifyListeners();
  }

  Future<dynamic> GetDetailPengeluaran(
      {required String token, required String id}) async {
    try {
      Pengeluaran pengeluaran =
          await PengeluaranService().GetDetailPengeluaran(token: token, id: id);
      _pengeluaran = pengeluaran;

      notifyListeners();

      return true;
    } catch (e) {
      return e.toString().replaceAll("Exception: ", "");
    }
  }
}
