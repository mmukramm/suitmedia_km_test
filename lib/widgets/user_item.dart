import 'package:flutter/material.dart';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:suitmedia_km_test/models/user_response.dart';
import 'package:suitmedia_km_test/styles/colors.dart';

class UserItem extends StatelessWidget {
  final UserResponse user;
  final VoidCallback onClick;
  const UserItem({
    super.key,
    required this.user,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: secondaryColor,
      borderRadius: BorderRadius.circular(12),
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Row(
          children: [
            Container(
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: CachedNetworkImage(
                width: 60,
                height: 60,
                fit: BoxFit.cover,
                imageUrl: user.avatar!,
                errorWidget: (context, _, __) => const Text("Image Error"),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${user.firstName} ${user.lastName}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  Text(
                    user.email!,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
