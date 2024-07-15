import 'package:flutter/material.dart';
import 'package:littletherapist/games/puzzles/models/datamodel_puzzle1.dart';
import 'package:littletherapist/games/puzzles/puzzle2.dart';
import 'package:littletherapist/utils/navigation/custom_navigation.dart';

class Puzzle1 extends StatefulWidget {
  const Puzzle1({super.key});

  @override
  State<Puzzle1> createState() => _Puzzle1State();
}

class _Puzzle1State extends State<Puzzle1> {
  List<DatamodelPuzzle1> dataModel = [];
  List<DatamodelPuzzle1> dataModel2 = [];
  int rows = 2, columns = 2;

  void _incrementCounter() {
    for (var i = 1; i <= rows * columns; i++) {
      dataModel.add(DatamodelPuzzle1(
        text: 'Image',
        number: i,
        imagePath: 'assets/images/puzzle1/image_$i.jpg', // Add image path
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    _incrementCounter();
    for (var model in dataModel) {
      dataModel2.add(DatamodelPuzzle1(
        text: model.text,
        number: model.number,
        imagePath: model.imagePath,
      ));
    }
    dataModel2.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF4CA5C1),
        title: const Text(
          "title",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 100,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/turtle.jpg"))),
            ),
            const SizedBox(
              height: 10,
            ),
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: dataModel.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: rows,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
              ),
              itemBuilder: (context, index) {
                return Center(
                  child: DragTarget<DatamodelPuzzle1>(
                    builder: (BuildContext context, List<Object?> candidateData,
                        List<dynamic> rejectedData) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.green.shade300,
                            border: dataModel[index].dataModel == null
                                ? Border.all(color: Colors.blue)
                                : null),
                        child: Center(
                          child: dataModel[index].dataModel == null
                              ? Text("${index + 1}")
                              : Image.asset(
                                  dataModel[index].dataModel!.imagePath,
                                  fit: BoxFit.cover,
                                  width: 200,
                                ),
                        ),
                      );
                    },
                    onAccept: (data) {
                      setState(() {
                        if (data.number == dataModel[index].number) {
                          dataModel[index].dataModel = data;
                          dataModel2.remove(data);
                        }
                      });
                    },
                    onWillAccept: (data) {
                      return data?.number == dataModel[index].number;
                    },
                  ),
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 80,
              child: ListView.builder(
                itemCount: dataModel2.length,
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LongPressDraggable<DatamodelPuzzle1>(
                      data: dataModel2[index],
                      feedback: Material(
                        child: Image.asset(
                          dataModel2[index].imagePath,
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                        ),
                      ),
                      childWhenDragging: Container(),
                      child: Image.asset(
                        dataModel2[index].imagePath,
                        fit: BoxFit.cover,
                        width: 60,
                        height: 60,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                CustomNavigation.nextPage(context, const Puzzle2());
              },
              child: const CircleAvatar(
                child: Icon(Icons.arrow_right_alt_rounded),
              ),
            )
          ],
        ),
      ),
    );
  }
}
