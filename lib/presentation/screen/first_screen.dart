import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_list_test/common/route/route.dart';
import 'package:simple_list_test/presentation/widget/my_button.dart';
import 'package:simple_list_test/presentation/widget/my_text_field.dart';

import '../bloc/shared_bloc.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final GlobalKey<FormState> _formName = GlobalKey<FormState>();
  final GlobalKey<FormState> _formPalindrome = GlobalKey<FormState>();

  TextEditingController? cteName;
  TextEditingController? cteTextPalindrome;

  @override
  void initState() {
    cteName = TextEditingController(
        text: (context.read<SharedBloc>().state is SharedLoaded
            ? (context.read<SharedBloc>().state as SharedLoaded).name
            : ""));
    cteTextPalindrome = TextEditingController(
        text: (context.read<SharedBloc>().state is SharedLoaded
            ? (context.read<SharedBloc>().state as SharedLoaded).textPalindrome
            : ""));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    cteTextPalindrome?.dispose();
    cteName?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/bg/bg-app.png"), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildPhoto(),
                    SizedBox(
                      height: 40,
                    ),
                    _buildInputField(),
                    SizedBox(
                      height: 40,
                    ),
                    _buildBottomButton(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField() {
    return Column(
      children: [
        Form(
          key: _formName,
          child: MyTextField(
            textPlaceholder: "Name",
            controller: cteName!,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Form(
          key: _formPalindrome,
          child: MyTextField(
            textPlaceholder: "Palindrome",
            controller: cteTextPalindrome!,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBottomButton() {
    return Column(
      children: [
        BlocListener<SharedBloc, SharedState>(
          listener: (context, state) {
            if (state is SharedLoaded && state.textPalindrome.isNotEmpty) {
              showDialog(
                context: context,
                builder: (context) => _buildDialog(state.isPalindrome),
              );
            }
          },
          child: MyButton(
            text: "CHECK",
            onPressed: () {
              if (_formPalindrome.currentState!.validate()) {
                context.read<SharedBloc>().add(
                      SharedPalindromeChangedEvent(
                          textPalindrome: cteTextPalindrome!.text),
                    );
              }
            },
          ),
        ),
        SizedBox(
          height: 10,
        ),
        MyButton(
          text: "NEXT",
          onPressed: () {
            if (_formName.currentState!.validate()) {
              context.read<SharedBloc>().add(
                    SharedNameChangedEvent(name: cteName!.text),
                  );
              Navigator.pushNamed(context, secondScreenRouteName);
            }
          },
        ),
      ],
    );
  }

  Widget _buildPhoto() {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white54),
      child: Icon(
        Icons.person_add_alt_1_rounded,
        size: 32,
        color: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  Widget _buildDialog(bool value) {
    return AlertDialog(
      title: Text(
        "Result",
        style: Theme.of(context)
            .textTheme
            .headlineMedium
            ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      content: Text(
        value ? "isPalindrome" : "Not Palindrome",
        style: Theme.of(context).textTheme.bodyLarge,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: Text(
            'OK',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
        ),
      ],
    );
  }
}
