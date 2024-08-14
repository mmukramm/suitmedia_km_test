import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:suitmedia_km_test/bloc/third_screen/third_screen_bloc.dart';
import 'package:suitmedia_km_test/bloc/third_screen/third_screen_event.dart';
import 'package:suitmedia_km_test/bloc/third_screen/third_screen_state.dart';
import 'package:suitmedia_km_test/bloc/username/username_bloc.dart';
import 'package:suitmedia_km_test/bloc/username/username_event.dart';
import 'package:suitmedia_km_test/models/user_response.dart';
import 'package:suitmedia_km_test/styles/colors.dart';
import 'package:suitmedia_km_test/widgets/custom_app_bar.dart';
import 'package:suitmedia_km_test/widgets/loading_animation.dart';
import 'package:suitmedia_km_test/widgets/user_item.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key});

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  late List<UserResponse> users;
  late final ScrollController scrollController;
  late int pageData;
  late bool isFetchAll;
  late final ThirdScreenBloc thirdScreenBloc;

  @override
  void initState() {
    super.initState();
    users = [];
    pageData = 1;
    isFetchAll = false;

    thirdScreenBloc = context.read<ThirdScreenBloc>();
    thirdScreenBloc.add(FetchData(page: pageData));

    scrollController = ScrollController();
    scrollController.addListener(
      () {
        if (scrollController.position.pixels ==
                scrollController.position.maxScrollExtent &&
            !isFetchAll) {
          pageData++;
          thirdScreenBloc.add(FetchMoreData(page: pageData));
        } else {
          debugPrint('All data fetched');
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    thirdScreenBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(72),
        child: CustomAppBar(
          title: 'Third Screen',
        ),
      ),
      body: BlocBuilder<ThirdScreenBloc, ThirdScreenState>(
        builder: (context, state) {
          if (state is Loading) {
            return const Center(
              child: LoadingAnimation(),
            );
          }

          if (state is Success) {
            if (state.data!.isNotEmpty) {
              users.addAll(state.data!);
            } else {
              isFetchAll = true;
            }
          }

          return RefreshIndicator(
            onRefresh: refreshPage,
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: [
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    shrinkWrap: true,
                    itemCount: users.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return UserItem(
                        user: user,
                        onClick: () => changeSelectedUsername(user),
                      );
                    },
                  ),

                  if (!isFetchAll) const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: LoadingAnimation(),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void changeSelectedUsername(UserResponse user) {
    context.read<UsernameBloc>().add(
          ChangeUsername(
            username: '${user.firstName} ${user.lastName}',
          ),
        );
    Navigator.pop(context);
  }

  Future<void> refreshPage() async {
    users.clear();
    pageData = 1;
    thirdScreenBloc.add(FetchData(page: pageData));
  }
}
