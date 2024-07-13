import 'package:flutter/material.dart';
import 'package:littletherapist/providers/auth_provider.dart' as auth_provider;
import 'package:provider/provider.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.size});

  final Size size;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Builder(builder: (context) {
          return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu));
        }),
        CircleAvatar(
          radius: 20,
          backgroundImage: NetworkImage(
            Provider.of<auth_provider.AuthProvider>(context).userModel!.image,
          ),
        )
      ],
    );
  }
}
