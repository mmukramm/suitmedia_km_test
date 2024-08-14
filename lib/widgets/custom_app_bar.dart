import 'package:flutter/material.dart';

import 'package:suitmedia_km_test/styles/colors.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  const CustomAppBar({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 72,
      title: Text(title),
      centerTitle: true,
      leading: IconButton(
        padding: const EdgeInsets.all(8),
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios_new_sharp,
          color: secondaryColor,
        ),
      ),
      shape: LinearBorder.bottom(
        side: const BorderSide(
          width: 1,
          color: Colors.grey,
        ),
      ),
    );
  }
}
