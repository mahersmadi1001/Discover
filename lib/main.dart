import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:Discover/blocs/Loginbloc/auth_bloc/auth_bloc.dart';
import 'package:Discover/blocs/cart_bloc/cart_bloc.dart';
import 'package:Discover/blocs/category_bloc/category_bloc.dart';
import 'package:Discover/blocs/local_search_product_bloc/local_search_product_bloc.dart';
import 'package:Discover/blocs/product_bloc/product_bloc.dart';
import 'package:Discover/core/user_session/user_session_bloc.dart';
import 'package:Discover/firebase_options.dart';
import 'package:Discover/models/product_model.dart';
import 'package:Discover/models/user_info_model.dart';
import 'package:Discover/services/authservice.dart';
import 'package:Discover/services/cart_local_data_source.dart';
import 'package:Discover/services/di.dart';
import 'package:Discover/services/product_service.dart';
import 'package:Discover/services/user_session_service.dart';
import 'package:Discover/view/Login/LoginView.dart';
import 'package:Discover/view/nav_bar_view.dart';
import 'package:Discover/view/onboarding_view.dart' show OnboardingView;
import 'package:Discover/view/splash_view.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Hive.registerAdapter<ProductModel>(ProductModelAdapter());
  Hive.registerAdapter<UserInfoModel>(UserInfoModelAdapter());
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(
    analytics: analytics,
  );
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              UserSessionBloc(getIt.get<UserSessionService>())
                ..add(UserSessionCheckStatus()),
        ),
        BlocProvider(create: (context) => AuthBloc(getIt.get<AuthService>())),
        BlocProvider(
          create: (context) =>
              CartBloc(cartLocalDataSource: CartLocalDataSource()),
        ),
        BlocProvider(
          create: (context) => LocalSearchProductBloc()..add((GetAllData())),
        ),
        BlocProvider(
          create: (context) =>
              CategoryBloc(productService: getIt.get<ProductService>())
                ..add(LoadCategories()),
        ),
        BlocProvider(
          create: (context) =>
              ProductBloc(productService: getIt.get<ProductService>()),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return BlocConsumer<UserSessionBloc, UserSessionState>(
            listener: (context, state) {
              if (state is UserAuthenticated) {
                navigatorKey.currentState?.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const NavBarView()),
                  (route) => false,
                );
              } else if (state is UserUnAuth) {
                navigatorKey.currentState?.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => LoginView()),
                  (route) => false,
                );
              } else if (state is UserFirstTimeState) {
                navigatorKey.currentState?.pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => OnboardingView()),
                  (route) => false,
                );
              }
            },
            builder: (context, state) {
              return MaterialApp(
                navigatorObservers: [observer],
                theme: ThemeData(
                  colorScheme: const ColorScheme.light(
                    primary: Colors.black,
                    onPrimary: Colors.white,
                    surface: Colors.white,
                    onSurface: Colors.black,
                    secondary: Color(0xFF333333),
                    onSecondary: Colors.white,
                  ),
                ),
                navigatorKey: navigatorKey,
                debugShowCheckedModeBanner: false,

                home: SplashView(),
              );
            },
          );
        },
      ),
    );
  }
}
