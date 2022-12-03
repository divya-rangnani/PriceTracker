class Tick {
  Tick({
      this.ask, 
      this.bid, 
      this.epoch, 
      this.id, 
      this.pipSize, 
      this.quote, 
      this.symbol,});

  Tick.fromJson(dynamic json) {
    ask = json['ask'];
    bid = json['bid'];
    epoch = json['epoch'];
    id = json['id'];
    pipSize = json['pip_size'];
    quote = json['quote'];
    symbol = json['symbol'];
  }
  double? ask;
  double? bid;
  int? epoch;
  String? id;
  int? pipSize;
  double? quote;
  String? symbol;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['ask'] = ask;
    map['bid'] = bid;
    map['epoch'] = epoch;
    map['id'] = id;
    map['pip_size'] = pipSize;
    map['quote'] = quote;
    map['symbol'] = symbol;
    return map;
  }

}