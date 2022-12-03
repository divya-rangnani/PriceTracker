class EchoReq {
  EchoReq({
      this.subscribe, 
      this.ticks,});

  EchoReq.fromJson(dynamic json) {
    subscribe = json['subscribe'];
    ticks = json['ticks'];
  }
  int? subscribe;
  String? ticks;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['subscribe'] = subscribe;
    map['ticks'] = ticks;
    return map;
  }

}