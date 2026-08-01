class Stock {
  final String symbol;
  final double ltp; // Latest trade price
  final double change;
  final double changePercent;

  Stock({
    required this.symbol,
    required this.ltp,
    required this.change,
    required this.changePercent,
  });

  static List<Stock> getInitialStocks() {
    return [
      Stock(
        symbol: 'RELIANCE',
        ltp: 2450.00,
        change: 15.50,
        changePercent: 0.64,
      ),
      Stock(symbol: 'TCS', ltp: 3520.00, change: -12.30, changePercent: -0.35),
      Stock(symbol: 'INFY', ltp: 1480.00, change: 8.20, changePercent: 0.56),
      Stock(
        symbol: 'HDFCBANK',
        ltp: 1650.00,
        change: 5.00,
        changePercent: 0.30,
      ),
      Stock(
        symbol: 'ICICIBANK',
        ltp: 950.00,
        change: -4.50,
        changePercent: -0.47,
      ),
      Stock(symbol: 'SBIN', ltp: 580.00, change: 3.10, changePercent: 0.54),
      Stock(symbol: 'ITC', ltp: 440.00, change: 1.20, changePercent: 0.27),
      Stock(symbol: 'LT', ltp: 3100.00, change: 25.00, changePercent: 0.81),
      Stock(
        symbol: 'BHARTIARTL',
        ltp: 890.00,
        change: -2.00,
        changePercent: -0.22,
      ),
      Stock(
        symbol: 'AXISBANK',
        ltp: 1020.00,
        change: 12.40,
        changePercent: 1.23,
      ),
    ];
  }
}
