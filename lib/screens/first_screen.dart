import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:suitmedia_km_test/widgets/custom_input.dart';
import 'package:suitmedia_km_test/screens/second_screen.dart';
import 'package:suitmedia_km_test/widgets/gradient_background.dart';
import 'package:suitmedia_km_test/bloc/username/username_bloc.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  late final TextEditingController usernameController;
  late final TextEditingController palindromeController;
  @override
  void initState() {
    super.initState();
    usernameController = TextEditingController();
    palindromeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const GradientBackground(),
          Positioned.fill(
            child: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/ic_photo.png',
                        width: 160,
                      ),
                      const SizedBox(height: 40),
                      CustomInput(
                        textEditingController: usernameController,
                        hintText: 'Username',
                      ),
                      const SizedBox(height: 12),
                      CustomInput(
                        textEditingController: palindromeController,
                        hintText: 'Palindrome',
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: palindromeChecker,
                          child: const Padding(
                            padding: EdgeInsets.all(12),
                            child: Text(
                              'Check',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: navigateToNextPage,
                          child: const Padding(
                            padding: EdgeInsets.all(12),
                            child: Text(
                              'Next',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void navigateToNextPage() {
    final username = usernameController.value.text;

    if (username.isEmpty) {
      showSnackBar(text: 'Username field is required to navigate to the next page.');
      return;
    }

    FocusScope.of(context).requestFocus(FocusNode());
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => UsernameBloc(),
          child: SecondScreen(
            username: username,
          ),
        ),
      ),
    );
  }

  void palindromeChecker() {
    FocusScope.of(context).requestFocus(FocusNode());
    final rawText = palindromeController.value.text;

    if (rawText.isEmpty) {
      showSnackBar(text: 'Cannot check palindrome of empty String.');
      return;
    }

    showPalindromeResultDialog(
      '"$rawText" is \n ${isPalindrome(rawText) ? 'Palindrome' : 'Not Palindrome'}',
    );
  }

  void showSnackBar({required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
        duration: const Duration(milliseconds: 2000),
      ),
      snackBarAnimationStyle: AnimationStyle(
        duration: const Duration(milliseconds: 200),
      ),
    );
  }

  void showPalindromeResultDialog(String resultText) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          clipBehavior: Clip.hardEdge,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  resultText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Close'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  bool isPalindrome(String rawText) {
    final text = rawText
        .toLowerCase()
        .split('')
        .where((element) => element != ' ')
        .join();
    final reversedText = text.split('').reversed.join();

    return text == reversedText;
  }
}
