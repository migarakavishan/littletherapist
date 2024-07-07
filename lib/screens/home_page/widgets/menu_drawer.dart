import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:littletherapist/controllers/auth_controller.dart';
import 'package:littletherapist/providers/auth_provider.dart' as auth_provider;
import 'package:littletherapist/screens/edit_profile/edit_profile.dart';
import 'package:littletherapist/utils/navigation/custom_navigation.dart';
import 'package:provider/provider.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(color: Colors.grey.shade700),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWomPds9w5emH_C6RY8xF7KRCJe6I5zwVsuw&s'),
                ),
                const Text(
                  "Peter Andesan",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Text(
                  "${Provider.of<auth_provider.AuthProvider>(context).user!.email}",
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                        text: TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                CustomNavigation.nextPage(
                                    context, const EditProfile());
                              },
                            text: "Edit Profile",
                            style: TextStyle(color: Colors.grey.shade400))),
                    Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey.shade400,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.star_border),
          title: const Text("Favorite"),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.score),
          title: const Text("My Points"),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text("Setting"),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text("About us"),
          onTap: () {},
        ),
        const Divider(),
        ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
            ),
            title: const Text(
              "Logout",
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              AuthController().signOutUser();
            })
      ],
    );
  }
}
