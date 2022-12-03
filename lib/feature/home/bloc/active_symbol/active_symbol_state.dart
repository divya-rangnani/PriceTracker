part of 'active_symbol_cubit.dart';

enum ActiveSymbolLoadedStatus { initial, loading, loaded, error }

abstract class ActiveSymbolState extends Equatable {
  const ActiveSymbolState();
}

class ActiveSymbolInitial extends ActiveSymbolState {
  @override
  List<Object> get props => [];
}

class ActiveSymbolLoading extends ActiveSymbolState {
  @override
  List<Object> get props => [];
}

class ActiveSymbolLoaded extends ActiveSymbolState {
  final List<ActiveSymbolsData>? activeSymbolsData;
  final List<String?>? marketList;
  final List<ActiveSymbolsData?>? assetList;
  final String? marketValue;
  final String? assetValue;
  final String? assetSymbol;
  final String? assetPrice;
  final ActiveSymbolLoadedStatus? status;

  const ActiveSymbolLoaded({
    this.activeSymbolsData,
    this.marketList,
    this.assetList,
    this.marketValue,
    this.assetValue,
    this.assetSymbol,
    this.status,
    this.assetPrice
  });

  @override
  List<Object?> get props => [activeSymbolsData, marketList, assetList, marketValue, assetValue,assetSymbol, status,assetPrice];

  ActiveSymbolLoaded copyWith({
    List<ActiveSymbolsData>? activeSymbolsData,
    List<String?>? marketList,
    List<ActiveSymbolsData?>? assetList,
    String? marketValue,
    String? assetValue,
    String? assetSymbol,
    ActiveSymbolLoadedStatus? status,
    String? assetPrice
  }) {
    return ActiveSymbolLoaded(
      activeSymbolsData: activeSymbolsData ?? this.activeSymbolsData,
      marketList: marketList ?? this.marketList,
      assetList: assetList ?? this.assetList,
      marketValue: marketValue ?? this.marketValue,
      assetValue: assetValue ?? this.assetValue,
      assetSymbol:assetSymbol??this.assetSymbol,
      status: status ?? this.status,
        assetPrice:assetPrice??this.assetPrice
    );
  }
}

class ActiveSymbolError extends ActiveSymbolState {
  final String message;

  const ActiveSymbolError(this.message);

  @override
  List<Object> get props => [message];
}
