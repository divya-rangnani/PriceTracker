import 'package:price_tracker/feature/home/data/active_symbol/active_symbol_response.dart';
import 'package:price_tracker/feature/home/data/tick_price/ticks_response.dart';

abstract class AppRepository {
  ActiveSymbolResponse getActiveSymbols({required String data});

  TicksResponse getTickPrices({required String data});
}
