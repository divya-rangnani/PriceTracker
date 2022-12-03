import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_tracker/core/domain/remote/api_repository.dart';
import 'package:price_tracker/feature/home/data/tick_price/tick.dart';
import 'package:price_tracker/feature/home/data/tick_price/ticks_response.dart';

part 'tick_price_state.dart';

class TickPriceCubit extends Cubit<TickPriceState> {
  final ApiRepository _apiRepository = ApiRepository();

  TickPriceCubit() : super(TickPriceInitial());

  void getTickPriceData(String data) {
    num previousPrice = 0;
    if (state is TickPriceLoaded) {
      var currState = state as TickPriceLoaded;
      previousPrice = currState.ticksResponseData?.quote ?? 0;
    }
    emit(TickPriceLoading());
    TicksResponse ticksResponse = _apiRepository.getTickPrices(data: data);
    Tick? ticksResponseData = ticksResponse.tick;
    String? subscriptionId = ticksResponse.subscription?.id;
    if (ticksResponseData != null) {
      emit(TickPriceLoaded(
          ticksResponseData: ticksResponseData,
          subscriptionId: subscriptionId,
          previousPrice: previousPrice));
    }else{
      emit(const TickPriceError());
    }
  }

  void resetState(){
    emit(TickPriceInitial());
  }

  void showError(String error){
    emit(TickPriceError(message: error));
  }

}
