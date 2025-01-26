import 'dart:math';

String getRandomProfilePath() {
  List<String> filePaths = [
    'assassin1.png',
    'assassin2.png',
    'assassin3.png',
    'dwarf1.png',
    'dwarf2.png',
    'dwarf3.png',
    'elf1.png',
    'elf2.png',
    'elf3.png',
    'golem1.png',
    'golem2.png',
    'golem3.png',
    'knight1.png',
    'knight2.png',
    'knight3.png',
    'orc1.png',
    'orc2.png',
    'skeleton1.png',
    'skeleton2.png',
    'skeleton3.png',
    'wizard1.png',
    'wizard2.png',
    'wizard3.png'
  ];

  Random random = Random();
  int index = random.nextInt(filePaths.length);
  return filePaths[index];
}
