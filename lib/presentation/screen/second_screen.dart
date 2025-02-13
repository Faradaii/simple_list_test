import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_list_test/common/route/route.dart';
import 'package:simple_list_test/presentation/bloc/shared_bloc.dart';
import 'package:simple_list_test/presentation/widget/my_app_bar.dart';
import 'package:simple_list_test/presentation/widget/my_button.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: "Second Screen"),
      bottomNavigationBar: _buildBottomButton(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildGreeting(),
              Expanded(
                child: Center(
                  child: BlocBuilder<SharedBloc, SharedState>(
                    builder: (context, state) {
                      if (state is SharedLoaded &&
                          state.selectedUser.isNotEmpty) {
                        return Text(
                          state.selectedUser,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(color: Colors.black),
                        );
                      }
                      return Text(
                        "Selected User Name",
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(color: Colors.black),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGreeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          "Welcome",
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.black),
        ),
        BlocBuilder<SharedBloc, SharedState>(
          builder: (context, state) {
            if (state is SharedLoaded && state.name.isNotEmpty) {
              return Text(
                state.name,
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: Colors.black),
              );
            }
            return Text(
              "No Name",
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(color: Colors.black),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBottomButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: MyButton(
        text: "Choose a User",
        onPressed: () {Navigator.pushNamed(context, thirdScreenRouteName);},
      ),
    );
  }
}
