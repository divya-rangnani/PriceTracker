import 'echo_req.dart';
import 'subscription.dart';
import 'tick.dart';

class TicksResponse {
  TicksResponse({
      this.echoReq, 
      this.msgType, 
      this.subscription, 
      this.tick,});

  TicksResponse.fromJson(dynamic json) {
    echoReq = json['echo_req'] != null ? EchoReq.fromJson(json['echo_req']) : null;
    msgType = json['msg_type'];
    subscription = json['subscription'] != null ? Subscription.fromJson(json['subscription']) : null;
    tick = json['tick'] != null ? Tick.fromJson(json['tick']) : null;
  }
  EchoReq? echoReq;
  String? msgType;
  Subscription? subscription;
  Tick? tick;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (echoReq != null) {
      map['echo_req'] = echoReq?.toJson();
    }
    map['msg_type'] = msgType;
    if (subscription != null) {
      map['subscription'] = subscription?.toJson();
    }
    if (tick != null) {
      map['tick'] = tick?.toJson();
    }
    return map;
  }

}