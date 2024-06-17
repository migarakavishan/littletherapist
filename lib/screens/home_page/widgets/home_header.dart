import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, required this.size});

  final Size size;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: size.width,
      decoration: BoxDecoration(color: Colors.grey.shade200),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Builder(builder: (context) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(Icons.menu));
          }),
          const Row(
            children: [
              Text(
                "Hello,",
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
              Text(
                "Peter",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTWomPds9w5emH_C6RY8xF7KRCJe6I5zwVsuw&s"),
          )
        ],
      ),
    );
  }
}
