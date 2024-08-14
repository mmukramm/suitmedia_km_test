import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:suitmedia_km_test/widgets/user_item.dart';
import 'package:suitmedia_km_test/models/user_response.dart';
import 'package:suitmedia_km_test/widgets/custom_app_bar.dart';
import 'package:suitmedia_km_test/widgets/loading_animation.dart';
import 'package:suitmedia_km_test/bloc/username/username_bloc.dart';
import 'package:suitmedia_km_test/bloc/username/username_event.dart';
import 'package:suitmedia_km_test/bloc/third_screen/third_screen_bloc.dart';
import 'package:suitmedia_km_test/bloc/third_screen/third_screen_event.dart';
import 'package:suitmedia_km_test/bloc/third_screen/third_screen_state.dart';

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

          if (state is Error) {
            return buildErrorWidget(
              message:
                  state.message ?? "There's something Error on your request.",
            );
          }

          if (state is Empty) {
            return buildEmptyWidget();
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
                  if (!isFetchAll)
                    const Padding(
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
    isFetchAll = false;
    thirdScreenBloc.add(FetchData(page: pageData));
  }

  Widget buildErrorWidget({required String message}) => RefreshIndicator(
        onRefresh: refreshPage,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 100,
            child: Center(
              child: Text(
                message,
              ),
            ),
          ),
        ),
      );

  Widget buildEmptyWidget() => RefreshIndicator(
        onRefresh: refreshPage,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height - 100,
            child: const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.hourglass_empty,
                    size: 80,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Data is Empty',
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
