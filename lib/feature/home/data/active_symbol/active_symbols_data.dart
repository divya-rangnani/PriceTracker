class ActiveSymbolsData {
  ActiveSymbolsData({
    this.allowForwardStarting,
    this.delayAmount,
    this.displayName,
    this.displayOrder,
    this.exchangeIsOpen,
    this.exchangeName,
    this.intradayIntervalMinutes,
    this.isTradingSuspended,
    this.market,
    this.marketDisplayName,
    this.pip,
    this.quotedCurrencySymbol,
    this.spot,
    this.spotAge,
    this.spotPercentageChange,
    this.spotTime,
    this.subgroup,
    this.subgroupDisplayName,
    this.submarket,
    this.submarketDisplayName,
    this.symbol,
    this.symbolType,
  });

  ActiveSymbolsData.fromJson(dynamic json) {
    allowForwardStarting = json['allow_forward_starting'];
    delayAmount = json['delay_amount'];
    displayName = json['display_name'];
    displayOrder = json['display_order'];
    exchangeIsOpen = json['exchange_is_open'];
    exchangeName = json['exchange_name'];
    intradayIntervalMinutes = json['intraday_interval_minutes'];
    isTradingSuspended = json['is_trading_suspended'];
    market = json['market'];
    marketDisplayName = json['market_display_name'];
    pip = json['pip'];
    quotedCurrencySymbol = json['quoted_currency_symbol'];
    spot = json['spot'];
    spotAge = json['spot_age'];
    spotPercentageChange = json['spot_percentage_change'];
    spotTime = json['spot_time'];
    subgroup = json['subgroup'];
    subgroupDisplayName = json['subgroup_display_name'];
    submarket = json['submarket'];
    submarketDisplayName = json['submarket_display_name'];
    symbol = json['symbol'];
    symbolType = json['symbol_type'];
  }
  num? allowForwardStarting;
  num? delayAmount;
  String? displayName;
  num? displayOrder;
  num? exchangeIsOpen;
  String? exchangeName;
  num? intradayIntervalMinutes;
  num? isTradingSuspended;
  String? market;
  String? marketDisplayName;
  num? pip;
  String? quotedCurrencySymbol;
  num? spot;
  String? spotAge;
  String? spotPercentageChange;
  String? spotTime;
  String? subgroup;
  String? subgroupDisplayName;
  String? submarket;
  String? submarketDisplayName;
  String? symbol;
  String? symbolType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['allow_forward_starting'] = allowForwardStarting;
    map['delay_amount'] = delayAmount;
    map['display_name'] = displayName;
    map['display_order'] = displayOrder;
    map['exchange_is_open'] = exchangeIsOpen;
    map['exchange_name'] = exchangeName;
    map['intraday_interval_minutes'] = intradayIntervalMinutes;
    map['is_trading_suspended'] = isTradingSuspended;
    map['market'] = market;
    map['market_display_name'] = marketDisplayName;
    map['pip'] = pip;
    map['quoted_currency_symbol'] = quotedCurrencySymbol;
    map['spot'] = spot;
    map['spot_age'] = spotAge;
    map['spot_percentage_change'] = spotPercentageChange;
    map['spot_time'] = spotTime;
    map['subgroup'] = subgroup;
    map['subgroup_display_name'] = subgroupDisplayName;
    map['submarket'] = submarket;
    map['submarket_display_name'] = submarketDisplayName;
    map['symbol'] = symbol;
    map['symbol_type'] = symbolType;
    return map;
  }
}
