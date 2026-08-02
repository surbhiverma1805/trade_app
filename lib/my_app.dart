import 'package:trade_app/exports/exports.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Initialize the SizeConfig singleton
    SizeConfig.init(context);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => WatchlistServiceImpl()),
        RepositoryProvider(
          create: (context) =>
              WatchlistRepository(context.read<WatchlistServiceImpl>()),
        ),
        RepositoryProvider(create: (context) => MarketServiceImpl()),
        RepositoryProvider(
          create: (context) =>
              MarketRepository(context.read<MarketServiceImpl>()),
        ),
        RepositoryProvider(create: (context) => TradingServiceImpl()),
        RepositoryProvider(
          create: (context) =>
              TradingRepository(context.read<TradingServiceImpl>()),
        ),
        RepositoryProvider(create: (context) => PortfolioServiceImpl()),
        RepositoryProvider(
          create: (context) =>
              PortfolioRepository(context.read<PortfolioServiceImpl>()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                WatchlistBloc(context.read<WatchlistRepository>()),
          ),
          BlocProvider(
            create: (context) => MarketBloc(context.read<MarketRepository>()),
          ),
          BlocProvider(
            create: (context) => TradingBloc(context.read<TradingRepository>()),
          ),
          BlocProvider(
            create: (context) =>
                PortfolioBloc(context.read<PortfolioRepository>()),
          ),
        ],
        child: MaterialApp(
          title: AppStrings.appName,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: AppColors.deepMidNightColor,
            primaryColor: AppColors.primary,
          ),
          initialRoute: AppRoutes.initialRoute,
          onGenerateRoute: AppRoutes.generateRoute,
        ),
      ),
    );
  }
}
