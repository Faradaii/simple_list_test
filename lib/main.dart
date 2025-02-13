import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_list_test/common/constant/constant.dart';

import 'common/route/route.dart';
import 'di/injection.dart';
import 'presentation/bloc/shared_bloc.dart';
import 'presentation/screen/first_screen.dart';
import 'presentation/screen/second_screen.dart';
import 'presentation/screen/third_screen.dart';

void main() async {
  Bloc.observer = MyObserver();
  await inject();
  runApp(
    BlocProvider(
        create: (context) => getIt<SharedBloc>(),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SharedBloc, SharedState>(
      builder: (context, state) {
        return MaterialApp(
          title: 'Simple List Test',
          theme: ThemeData.light().copyWith(
            colorScheme: kColorScheme,
            primaryColor: cPrimaryColor,
            scaffoldBackgroundColor: Colors.white,
            textTheme: kTextTheme,
          ),
          home: FirstScreen(),
          navigatorObservers: [RouteObserver<ModalRoute>()],
          onGenerateRoute: (RouteSettings settings) {
            switch (settings.name) {
              case firstScreenRouteName:
                return MaterialPageRoute(builder: (_) => FirstScreen());
              case secondScreenRouteName:
                return MaterialPageRoute(builder: (_) => SecondScreen());
              case thirdScreenRouteName:
                return MaterialPageRoute(builder: (_) => ThirdScreen());
              default:
                return MaterialPageRoute(
                    builder: (_) => Scaffold(
                          body: Center(child: Text("Page not found")),
                        ));
            }
          },
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class MyObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint('bloc change ${bloc.runtimeType} ${bloc.state.toString()}');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint('bloc transition ${bloc.runtimeType}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    debugPrint('bloc error ${bloc.runtimeType}');
  }
}