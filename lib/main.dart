import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pharma_tv/presentation/screens/welcome_screen.dart';
import 'package:pharma_tv/shared/bloc_observer.dart';
import 'package:pharma_tv/shared/cashHelper/chash_helper.dart';
import 'package:pharma_tv/shared/styels.dart';
import 'bussiness_logic/home_bloc/cubit.dart';
import 'bussiness_logic/movie_bloc/cubit.dart';
import 'bussiness_logic/signing_bloc/cubit.dart';
import 'presentation/screens/signin_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //stop mobile rotation
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  //track bloc states
  Bloc.observer = MyBlocObserver();
  //initialize shared preferences
  await CashHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (BuildContext context) => SingingCubit()..createDB(),
        ),
        BlocProvider(
          create: (BuildContext context) => HomeCubit(),
        ),
        BlocProvider(
          create: (BuildContext context) => MovieCubit(),
        ),
      ],
      child: ScreenUtilInit(
          designSize: const Size(1080, 1920),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: customThemeData,
              title: 'MinaPharma Tv',
              home: CashHelper.getData(key: 'name') != null
                  ? const WelcomeScreen()
                  : const SigninScreen(),
            );
          }),
    );
  }
}
