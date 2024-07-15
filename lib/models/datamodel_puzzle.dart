class DatamodelPuzzle {
  String text;
  int number;
  DatamodelPuzzle? dataModel;
  String imagePath;

  DatamodelPuzzle({
    required this.text,
    required this.number,
    this.dataModel,
    required this.imagePath,
  });
}
