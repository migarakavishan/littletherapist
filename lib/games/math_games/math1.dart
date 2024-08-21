import 'package:flutter/material.dart';

class Math1 extends StatefulWidget {
  const Math1({super.key});

  @override
  State<Math1> createState() => _Math1State();
}

class _Math1State extends State<Math1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: const Color(0xFF4CA5C1),
          title: const Text(
            "Give Correct Ansewer",
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 50,
                          height: 50,
                          child: CircularProgressIndicator(
                            // value: _progress,
                            backgroundColor: Colors.grey[300],
                            color: Colors.blue,
                            strokeWidth: 6,
                          ),
                        ),
                        const Text("s"),
                      ],
                    ),
                    const Text(
                      "Level 1",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Container(
                          width: 45,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.blue.shade500,
                              borderRadius: const BorderRadiusDirectional.only(
                                  topStart: Radius.circular(10),
                                  bottomStart: Radius.circular(10))),
                          child: const Center(
                              child: Text(
                            "Score",
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                        Container(
                          width: 45,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.blue.shade400,
                              borderRadius: const BorderRadiusDirectional.only(
                                  topEnd: Radius.circular(10),
                                  bottomEnd: Radius.circular(10))),
                          child: const Center(
                            child: Text('ss',
                                style: TextStyle(color: Colors.white)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                width: 500,
                height: 200,
                decoration: const BoxDecoration(color: Colors.amber),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          "assets/images/appleright.png",
                          height: 50,
                        ),
                        const Text("="),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(color: Colors.red),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
