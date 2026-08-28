import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:test_packegs/blocs/Loginbloc/auth_bloc/auth_bloc.dart';
import 'package:test_packegs/blocs/cart_bloc/cart_bloc.dart';
import 'package:test_packegs/blocs/category_bloc/category_bloc.dart';
import 'package:test_packegs/blocs/local_search_product_bloc/local_search_product_bloc.dart';
import 'package:test_packegs/blocs/product_bloc/product_bloc.dart';
import 'package:test_packegs/core/user_session/user_session_bloc.dart';
import 'package:test_packegs/firebase_options.dart';
import 'package:test_packegs/models/product_model.dart';
import 'package:test_packegs/services/authservice.dart';
import 'package:test_packegs/services/cart_local_data_source.dart';
import 'package:test_packegs/services/di.dart';
import 'package:test_packegs/services/product_service.dart';
import 'package:test_packegs/services/user_session_service.dart';
import 'package:test_packegs/view/LoginView.dart';
import 'package:test_packegs/view/nav_bar_view.dart';
import 'package:test_packegs/view/onboarding_view.dart' show OnboardingView;
import 'package:test_packegs/view/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Hive.registerAdapter<ProductModel>(ProductModelAdapter());
  await setup();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    FirebaseAuth.instance.userChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
    super.initState();
  }

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
              CartBloc(cartLocalDataSource: CartLocalDataSource())
                ..add(InitiliazeCart()),
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
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            home: BlocBuilder<UserSessionBloc, UserSessionState>(
              builder: (context, state) {
                if (state is UserSessionInitial) {
                  return const SplashView();
                } else if (state is UserFirstTimeState) {
                  return const OnboardingView();
                } else if (state is UserAuthenticated) {
                  return const NavBarView();
                } else if (state is UserUnAuth) {
                  return LoginView();
                }
                return const SplashView();
              },
            ),
          );
        },
      ),
    );
  }
}
