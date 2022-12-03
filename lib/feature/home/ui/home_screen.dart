import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:price_tracker/consts/app_const.dart';
import 'package:price_tracker/feature/common_widgets/common_drop_down.dart';
import 'package:price_tracker/feature/home/bloc/active_symbol/active_symbol_cubit.dart';
import 'package:price_tracker/feature/home/bloc/tick_price/tick_price_cubit.dart';
import 'package:web_socket_channel/io.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late IOWebSocketChannel _channel;

  @override
  void initState() {
    _connectSocket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text(
            AppConst.appTitle,
          ),
        ),
        body: StreamBuilder(
            stream: _channel.stream,
            builder: (context, snapshot) {
              if(snapshot.hasData){
                if(snapshot.data.toString().contains('error')){
                  BlocProvider.of<TickPriceCubit>(context).showError(jsonDecode(snapshot.data)['error']['message']);
                }else if (snapshot.data.toString().contains('ticks')) {
                  BlocProvider.of<TickPriceCubit>(context).getTickPriceData(snapshot.data);
                } else if (snapshot.data.toString().contains('active_symbols')) {
                  BlocProvider.of<ActiveSymbolCubit>(context).getActiveSymbolData(snapshot.data);
                }
              }
            return Center(
              child: BlocBuilder<ActiveSymbolCubit, ActiveSymbolState>(
                builder: (context, activeSymbolState) {
                  if (activeSymbolState is ActiveSymbolLoaded) {
                    TickPriceState tickState =
                        BlocProvider.of<TickPriceCubit>(context).state;
                    if (activeSymbolState.assetSymbol != null) {
                      _channel.sink.add(
                          '{"ticks": "${activeSymbolState.assetSymbol}","subscribe": 1}');
                      //_channel.sink.add('{"ticks": "R_50","subscribe": 1}');
                    }
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CommonDropDown(
                            value: activeSymbolState.marketValue,
                            hintText: 'Select a Market',
                            items: activeSymbolState.marketList
                                ?.map<DropdownMenuItem<String>>((String? value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value ?? '--'),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              if (value != null) {
                                if (tickState is TickPriceLoaded) {
                                  _channel.sink
                                      .add({"forget": tickState.subscriptionId});
                                  BlocProvider.of<TickPriceCubit>(context).resetState();
                                }
                                context.read<ActiveSymbolCubit>().updateMarket(value);
                                //context.read<ActiveSymbolCubit>().getAssetList(value.split(" ").first);
                                context.read<ActiveSymbolCubit>().getAssetList(value);
                              }
                            },
                          ),
                          const SizedBox(height: 20.0),
                          CommonDropDown(
                            value: activeSymbolState.assetValue,
                            hintText: 'Select a Asset',
                            items: activeSymbolState.assetList
                                ?.map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem<String>(
                                value: value?.displayName,
                                child: Text(value?.displayName ?? '--'),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              if (tickState is TickPriceLoaded) {
                                _channel.sink
                                    .add({"forget": tickState.subscriptionId});
                                BlocProvider.of<TickPriceCubit>(context).resetState();
                              }
                              context
                                  .read<ActiveSymbolCubit>()
                                  .updateAsset(value ?? '');
                              //context.read<ActiveSymbolCubit>().getPrice(value ?? '');
                            },
                          ),
                          const SizedBox(height: 90.0),
                          (activeSymbolState.assetSymbol == null)
                              ? const SizedBox()
                              : BlocBuilder<TickPriceCubit, TickPriceState>(
                                  builder: (context, tickState) {
                                  if (tickState is TickPriceLoading) {
                                    return const CircularProgressIndicator(
                                        color: Colors.blue);
                                  } else if (tickState is TickPriceLoaded &&
                                      tickState.ticksResponseData?.quote != null) {
                                    return RichText(
                                      text: TextSpan(
                                        children: [
                                          const TextSpan(
                                            text: 'Price: ',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                          TextSpan(
                                            text:
                                                '${tickState.ticksResponseData?.quote}',
                                            style: TextStyle(
                                              color: (tickState.previousPrice != 0 &&
                                                      tickState.ticksResponseData
                                                              ?.quote !=
                                                          null &&
                                                      tickState.previousPrice ==
                                                          tickState.ticksResponseData
                                                              ?.quote)
                                                  ? Colors.black45
                                                  : (tickState.ticksResponseData
                                                                  ?.quote ??
                                                              0) >
                                                          (tickState.previousPrice ??
                                                              0)
                                                      ? Colors.green
                                                      : (tickState.ticksResponseData
                                                                      ?.quote ??
                                                                  0) <
                                                              (tickState
                                                                      .previousPrice ??
                                                                  0)
                                                          ? Colors.red
                                                          : Colors.black,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      ),
                                    );
                                  } else if (tickState is TickPriceError) {
                                    return Text(tickState.message??
                                        'Sorry, Not able to get price of ${activeSymbolState.assetValue}!');
                                  }
                                  return const SizedBox();
                                }),
                        ],
                      ),
                    );
                  }else if(activeSymbolState is ActiveSymbolLoading){
                    return const CircularProgressIndicator(color: Colors.blue);
                  }else if (activeSymbolState is ActiveSymbolError) {
                    return const Text('Something went wrong, please try again in sometime!');
                  }
                  return const CircularProgressIndicator(color: Colors.blue);

                },
              ),
            );
          }
        ),
      ),
    );
  }

  void _connectSocket() {
    _channel = IOWebSocketChannel.connect(Uri.parse(AppConst.baseUrl));
    _channel.sink.add('{"active_symbols": "full", "product_type": "basic"}');
  }

  @override
  void dispose() {
    TickPriceState tickState = BlocProvider.of<TickPriceCubit>(context).state;
    if (tickState is TickPriceLoaded) {
      //_channel.sink.add({"forget": "1c99bd19-9b0a-0ac1-338e-9ae9701d9eca"});
      _channel.sink.add({"forget": tickState.subscriptionId});
      BlocProvider.of<TickPriceCubit>(context).resetState();
    }

    _channel.sink.close();
    super.dispose();
  }
}
