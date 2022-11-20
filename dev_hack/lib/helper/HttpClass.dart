import 'dart:convert';
import 'package:http/http.dart';
import 'PostModel.dart';

class HttpService {
  final String fit_bit_row_data_url = "";
  final String stress_level_url = "";
  final String vacantion_needed_url = "";
  final String stress_level_interval_url = "";

  Future<T?> getRequest<T> () async {
    T? data;
    Response res;
    if (T is FitBitRowData) {
      res = await get(Uri.parse(fit_bit_row_data_url));

      if (res.statusCode == 200) {
        dynamic body = json.decode(res.body);
        FitBitRowData get_data = FitBitRowData.fromJson(body);
        data = get_data as T?;
      }
    } else if (T is StressLevel) {
      res = await get(Uri.parse(stress_level_url));

      if (res.statusCode == 200) {
        dynamic body = json.decode(res.body);
        StressLevel get_data = StressLevel.fromJson(body);
        data = get_data as T?;
      }
    } else if (T is VacantionNeeded) {
      res = await get(Uri.parse(vacantion_needed_url));

      if (res.statusCode == 200) {
        dynamic body = json.decode(res.body);
        VacantionNeeded get_data = VacantionNeeded.fromJson(body);
        data = get_data as T?;
      }
    } else if (T is StressLevelInterval) {
      res = await get(Uri.parse(stress_level_interval_url));

      if (res.statusCode == 200) {
        dynamic body = json.decode(res.body);
        StressLevelInterval get_data = StressLevelInterval.fromJson(body);
        data = get_data as T?;
      }
    }

    return data;
  }
}