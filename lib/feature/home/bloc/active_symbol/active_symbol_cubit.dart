import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_tracker/core/domain/remote/api_repository.dart';
import 'package:price_tracker/feature/home/data/active_symbol/active_symbol_response.dart';
import 'package:price_tracker/feature/home/data/active_symbol/active_symbols_data.dart';

part 'active_symbol_state.dart';

class ActiveSymbolCubit extends Cubit<ActiveSymbolState> {
  final ApiRepository _apiRepository = ApiRepository();

  ActiveSymbolCubit() : super(ActiveSymbolInitial());

  void getActiveSymbolData(String data) {
    emit(ActiveSymbolLoading());
    ActiveSymbolResponse activeSymbolResponse =
        _apiRepository.getActiveSymbols(data: data);
    List<ActiveSymbolsData>? activeSymbolsData =
        activeSymbolResponse.activeSymbols;
    if (activeSymbolsData != null) {
      Set<String?> set = <String?>{};
      for (var element in activeSymbolsData) {
        set.add(element.market);
        //set.add('${element.displayName} (${element.market})');
      }
      emit(ActiveSymbolLoaded( activeSymbolsData: activeSymbolsData,marketList: set.toList()));
    }else{
      emit(const ActiveSymbolError('Something went wrong, please try again in sometime!'));
    }
  }

  void updateMarket(String market) {
    if (state is ActiveSymbolLoaded) {
      var currState = state as ActiveSymbolLoaded;
      emit(currState.copyWith(marketValue: market));
    }
  }

  void updateAsset(String asset) {
    if (state is ActiveSymbolLoaded) {
      var currState = state as ActiveSymbolLoaded;
      List<ActiveSymbolsData>? assetList = currState.activeSymbolsData
          ?.where((element) => element.market == currState.marketValue)
          .toList();
      emit(currState.copyWith(assetValue: asset,assetSymbol: assetList?.first.symbol));
    }
  }

  void getAssetList(String marketValue) {
    if (state is ActiveSymbolLoaded) {
      var currState = state as ActiveSymbolLoaded;
      emit(currState.copyWith(status: ActiveSymbolLoadedStatus.initial));
      List<ActiveSymbolsData>? assetList = currState.activeSymbolsData
          ?.where((element) => element.market == marketValue)
          .toList();
      emit(
        ActiveSymbolLoaded(
          activeSymbolsData: currState.activeSymbolsData,
          marketList: currState.marketList,
          marketValue: currState.marketValue,
          assetList: assetList,
          assetValue: null,
          assetSymbol: null,
        ),
      );
    }
  }
}
