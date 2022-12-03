import 'dart:convert';

import 'package:price_tracker/consts/app_const.dart';
import 'package:price_tracker/core/domain/remote/app_repository.dart';
import 'package:price_tracker/core/services/base_dio_client.dart';
import 'package:price_tracker/core/services/dio_client.dart';
import 'package:price_tracker/feature/home/data/active_symbol/active_symbol_response.dart';
import 'package:price_tracker/feature/home/data/tick_price/ticks_response.dart';

class ApiRepository extends AppRepository {
  /*final BaseDioClient _dioClient = DioClient(AppConst.baseUrl, null, []);

  @override
  Future<List<ActiveSymbolsData>> getActiveSymbols(
      {required Map<String, dynamic> data}) async {

    final data = {"active_symbols": "full", "product_type": "basic"};

    final response = await _dioClient.dioInstance!
        .get("${_dioClient.baseUrl}", queryParameters: data);
    if (response.statusCode == 200) {
      return ActiveSymbolResponse.fromJson(response.data).activeSymbols ?? [];
    } else {
      return [];
    }
  }*/

  @override
  ActiveSymbolResponse getActiveSymbols({required String data}) {
    Map<String, dynamic> jsonData = json.decode(data);
    ActiveSymbolResponse response = ActiveSymbolResponse.fromJson(jsonData);
    return response;
  }

  @override
  TicksResponse getTickPrices({required String data}) {
    Map<String, dynamic> jsonData = json.decode(data);
    TicksResponse response = TicksResponse.fromJson(jsonData);
    return response;
  }


}
