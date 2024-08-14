import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:suitmedia_km_test/utils/dio_client.dart';
import 'package:suitmedia_km_test/screens/third_screen.dart';
import 'package:suitmedia_km_test/widgets/custom_app_bar.dart';
import 'package:suitmedia_km_test/bloc/username/username_bloc.dart';
import 'package:suitmedia_km_test/bloc/third_screen/third_screen_bloc.dart';


class SecondScreen extends StatelessWidget {
  final String username;
  const SecondScreen({
    super.key,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(72),
        child: CustomAppBar(
          title: 'Second Screen',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome',
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  username,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            BlocBuilder<UsernameBloc, String>(
              builder: (context, state) {
                return Text(
                  state,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider(
                        create: (context) => ThirdScreenBloc(DioClient()),
                        child: BlocProvider.value(
                          value: context.read<UsernameBloc>(),
                          child: const ThirdScreen(),
                        ),
                      ),
                    ),
                  );
                },
                child: const Text('Choose a User'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
