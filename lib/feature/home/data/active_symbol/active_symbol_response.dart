import 'package:price_tracker/feature/home/data/active_symbol/active_symbols_data.dart';
import 'package:price_tracker/feature/home/data/active_symbol/echo_req.dart';

class ActiveSymbolResponse {
  ActiveSymbolResponse({
    this.activeSymbols,
    this.echoReq,
    this.msgType,
  });

  ActiveSymbolResponse.fromJson(dynamic json) {
    if (json['active_symbols'] != null) {
      activeSymbols = [];
      json['active_symbols'].forEach((v) {
        activeSymbols?.add(ActiveSymbolsData.fromJson(v));
      });
    }
    echoReq = json['echo_req'] != null ? EchoReq.fromJson(json['echo_req']) : null;
    msgType = json['msg_type'];
  }
  List<ActiveSymbolsData>? activeSymbols;
  EchoReq? echoReq;
  String? msgType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (activeSymbols != null) {
      map['active_symbols'] = activeSymbols?.map((v) => v.toJson()).toList();
    }
    if (echoReq != null) {
      map['echo_req'] = echoReq?.toJson();
    }
    map['msg_type'] = msgType;
    return map;
  }
}
