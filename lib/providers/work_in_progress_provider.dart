import 'package:flutter/material.dart';
import 'package:sutindo_supir_app/models/work_in_progress_model.dart';
import 'package:sutindo_supir_app/services/work_in_progress_service.dart';

class WorkInProgressProvider extends ChangeNotifier {
  WorkInProgress _work = WorkInProgress();

  WorkInProgress get work => _work;

  set work(WorkInProgress work) {
    _work = work;
    notifyListeners();
  }

  Future<dynamic> GetWorkInProgress(
      {required String token, required int id}) async {
    try {
      WorkInProgress work =
          await WorkInProgressService().GetWorkInProgress(token: token, id: id);

      _work = work;

      notifyListeners();

      return true;
    } catch (e) {
      print("error : $e");
      return e.toString().replaceAll("Exception:", "");
    }
  }

  Future<dynamic> AddPocketMoney(
      {required String token,
      required String nominal,
      required String keterangan,
      required String id}) async {
    try {
      bool response = await WorkInProgressService().AddPocketMoney(
          token: token, nominal: nominal, keterangan: keterangan, id: id);

      return true;
    } catch (e) {
      return e.toString().replaceAll("Exception:", "");
    }
  }

  Future<dynamic> UpdateProgress(
      {required String token,
      required String keterangan,
      required String id,
      required String customer,
      required String progress}) async {
    try {
      bool response = await WorkInProgressService().UpdateProgress(
          token: token,
          progress: progress,
          keterangan: keterangan,
          id: id,
          customer: customer);

      return true;
    } catch (e) {
      return e.toString().replaceAll("Exception:", "");
    }
  }

  Future<dynamic> HapusRute({
    required String token,
    required String keterangan,
    required String id,
    required String customer,
  }) async {
    try {
      bool response = await WorkInProgressService().HapusRute(
          token: token, keterangan: keterangan, id: id, customer: customer);

      return true;
    } catch (e) {
      return e.toString().replaceAll("Exception:", "");
    }
  }

  Future<dynamic> EditPocketMoney(
      {required String token,
      required String nominal,
      required String keterangan,
      required String id}) async {
    try {
      bool response = await WorkInProgressService().EditPocketMoney(
          token: token, nominal: nominal, keterangan: keterangan, id: id);

      return true;
    } catch (e) {
      print(e);
      return e.toString().replaceAll("Exception:", "");
    }
  }

  void ShowHideDetail(int index, bool isShow, WorkInProgress work) {
    work.list_task[index].is_show = isShow;

    notifyListeners();
  }
}
