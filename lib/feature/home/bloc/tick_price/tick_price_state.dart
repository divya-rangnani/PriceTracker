part of 'tick_price_cubit.dart';

enum TickPriceLoadedStatus { initial, loading, loaded, error }

abstract class TickPriceState extends Equatable {
  const TickPriceState();
}

class TickPriceInitial extends TickPriceState {
  @override
  List<Object> get props => [];
}

class TickPriceLoading extends TickPriceState {
  @override
  List<Object> get props => [];
}

class TickPriceLoaded extends TickPriceState {
  final Tick? ticksResponseData;
  final String? subscriptionId;
  final num? previousPrice;

  const TickPriceLoaded({
    required this.ticksResponseData,
    required this.subscriptionId,
    required this.previousPrice,
  });

  @override
  List<Object?> get props => [ticksResponseData,subscriptionId,previousPrice];
}

class TickPriceError extends TickPriceState {
  final String? message;

  const TickPriceError({this.message});

  @override
  List<Object> get props => [message??''];
}
