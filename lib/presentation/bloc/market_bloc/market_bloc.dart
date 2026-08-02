import 'dart:async';

import 'package:trade_app/exports/exports.dart';

part 'market_event.dart';
part 'market_state.dart';

class MarketBloc extends Bloc<MarketEvent, MarketState> {
  final MarketRepository repository;
  StreamSubscription<Map<String, Stock>>? _subscription;

  MarketBloc(this.repository) : super(MarketState(stocks: repository.getInitialStocks())) {
    on<StartMarketStreamEvent>(_onStartStreaming);
    on<TickPricesEvent>(_onTickPrices);
  }

  void _onStartStreaming(StartMarketStreamEvent event, Emitter<MarketState> emit) {
    _subscription?.cancel();
    repository.startPriceStream();

    _subscription = repository.getMarketPrices().listen((updatedStocks) {
      add(TickPricesEvent(updatedStocks));
    });
  }

  void _onTickPrices(TickPricesEvent event, Emitter<MarketState> emit) {
    String? changedSymbol;
    bool? isUp;

    for (var entry in event.updatedStock.entries) {
      if (state.stocks[entry.key]?.ltp != entry.value.ltp) {
        changedSymbol = entry.key;
        isUp = entry.value.ltp >= (state.stocks[entry.key]?.ltp ?? entry.value.ltp);
        break;
      }
    }

    emit(state.copyWith(
      stocks: event.updatedStock,
      lastUpdatedSymbol: changedSymbol,
      lastDirectionUp: isUp,
    ));
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    repository.startPriceStream();
    return super.close();
  }
}
