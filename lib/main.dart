import 'package:ecom_app/blocs/cart/cart_bloc.dart';
import 'package:ecom_app/blocs/product/product_bloc.dart';
import 'package:ecom_app/blocs/product/product_event.dart';
import 'package:ecom_app/blocs/user/user_bloc.dart';
import 'package:ecom_app/blocs/user/user_event.dart';
import 'package:ecom_app/path/path.dart';
import 'package:ecom_app/repositories/product_repository.dart';
import 'package:ecom_app/repositories/user_repository.dart';
import 'package:ecom_app/util/theme/dark_theme.dart';
import 'package:ecom_app/util/theme/light_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  // Ensure WidgetsBinding is initialized.
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables.
  await dotenv.load(fileName: ".env");

  // Splash Screen setting.
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(
    const Duration(seconds: 1),
  );
  FlutterNativeSplash.remove();

  final productRepository = ProductRepository();
  final userRepository = UserRepository();
  runApp(MyApp(
    productRepository: productRepository,
    userRepository: userRepository,
  ));
}

class MyApp extends StatelessWidget {
  final ProductRepository productRepository;
  final UserRepository userRepository;
  const MyApp({
    super.key,
    required this.productRepository,
    required this.userRepository,
  });

  @override
  Widget build(BuildContext context) {
    // Device orientation lock.
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ProductBloc(productRepository)..add(FetchProducts()),
        ),
        BlocProvider(create: (_) => CartBloc()),
        BlocProvider(
          create: (_) => UserBloc(userRepository)..add(FetchUser()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Ecom App',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
