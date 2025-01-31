import 'package:flipkart/data/cart_data/cart_data_service.dart';
import 'package:flipkart/data/cart_data/product_model.dart';
import 'package:flipkart/data/offline_data/offline_data_provider.dart';
import 'package:flipkart/data/offline_data/offline_data_service.dart';
import 'package:flipkart/ui/screens/cart/bloc/cart_bloc.dart';
import 'package:flipkart/ui/screens/dashboard/bloc/dashboard_bloc.dart';
import 'package:flipkart/ui/screens/home/bloc/home_bloc.dart';
import 'package:flipkart/ui/screens/product/bloc/product_bloc.dart';
import 'package:flipkart/ui/screens/splash/bloc/splash_bloc.dart';
import 'package:flipkart/ui/screens/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(ProductAdapter());
  await Hive.openBox<Product>('cartBox');


  runApp(
      MultiBlocProvider(
        providers: [
          RepositoryProvider(
              lazy: false,
              create: (context)=>OfflineDataService()),
          RepositoryProvider(
              lazy: false,
              create: (context)=>OfflineDataProvider(
              context.read<OfflineDataService>()
          )),
           RepositoryProvider(
              lazy: false,
              create: (context)=>CartDataService()
           ),
          BlocProvider<CartBloc>(
            create: (context) => CartBloc(context.read<CartDataService>()),
          ),
          BlocProvider<SplashBloc>(
            create: (context) => SplashBloc(),
          ),
          BlocProvider<DashboardBloc>(
            create: (context) => DashboardBloc(),
          ),
           BlocProvider<HomeBloc>(
            create: (context) => HomeBloc(),
          ),
           BlocProvider<ProductBloc>(
            create: (context) => ProductBloc(context.read<CartBloc>()),
          ),

        ],
        child: const MyApp(),
      )
      );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: SplashView(),
    );
  }
}

