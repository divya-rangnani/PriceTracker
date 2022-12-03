class EchoReq {
  EchoReq({
    this.activeSymbols,
    this.productType,
  });

  EchoReq.fromJson(dynamic json) {
    activeSymbols = json['active_symbols'];
    productType = json['product_type'];
  }
  String? activeSymbols;
  String? productType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['active_symbols'] = activeSymbols;
    map['product_type'] = productType;
    return map;
  }
}
