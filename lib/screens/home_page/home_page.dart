import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 60,
              decoration: BoxDecoration(color: Colors.grey.shade200),
              child: Row(
                children: [
                  IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
                  const Text(
                    "Hello,",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Text(
                    "Peter",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 180,
                  ),
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWomPds9w5emH_C6RY8xF7KRCJe6I5zwVsuw&s"),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
