import 'dart:io';
import 'dart:convert';

void convertTxtToJson(String inputTxtPath, String outputJsonPath) {
  final txtFile = File(inputTxtPath);
  final lines = txtFile.readAsLinesSync();

  final jsonList = [];

  for (var line in lines) {
    final parts = line.trim().split(' ');
    if (parts.length == 5) {
      final objId = int.parse(parts[0]);
      final x = double.parse(parts[1]);
      final y = double.parse(parts[2]);
      final width = double.parse(parts[3]);
      final height = double.parse(parts[4]);

      final jsonItem = {
        "image_rotation": 0,
        "value": {
          "x": x,
          "y": y,
          "width": width,
          "height": height,
          "rotation": 0,
          "rectanglelabels": [objId.toString()]
        }
      };

      jsonList.add(jsonItem);
    }
  }

  final jsonString = jsonEncode(jsonList);
  File(outputJsonPath).writeAsStringSync(jsonString, flush: true);

  // Read and print the generated JSON data
  final generatedJson = File(outputJsonPath).readAsStringSync();
  print(generatedJson);
}

void main() {
  final inputTxtPath = 'assets/image1.txt';
  final outputJsonPath = 'assets/image.json';
  convertTxtToJson(inputTxtPath, outputJsonPath);
}
