import 'dart:math';
import 'dart:ui';

class RandomColorUtil{
  Color getRandomColor(int index) {
    List<Color> colors = <Color>[];

    if (index >= colors.length) {
      colors.add(Color.fromARGB(255, Random.secure().nextInt(255),
          Random.secure().nextInt(255), Random.secure().nextInt(255)));
    }

    return colors[index];
  }
}