import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_list_test/common/constant/constant.dart';
import 'package:simple_list_test/data/repositories/app_repository_impl.dart';
import 'package:simple_list_test/presentation/bloc/shared_bloc.dart';
import 'package:simple_list_test/presentation/screen/first_screen.dart';

import 'common/route/route.dart';
import 'domain/usecases/check_palindrome_usecase.dart';

void main() {
  runApp(
    BlocProvider(
        create: (context) => SharedBloc(
              checkPalindromeUseCase:
                  CheckPalindromeUseCase(appRepository: AppRepositoryImpl()),
            ),
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
