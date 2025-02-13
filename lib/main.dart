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
