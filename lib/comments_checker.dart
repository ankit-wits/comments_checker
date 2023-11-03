import 'dart:io';

import 'package:args/args.dart';

void main(List<String> arguments) {
  final parser = ArgParser()
    ..addFlag('help', abbr: 'h', help: 'Print this usage information.');

  final argResults = parser.parse(arguments);

  if (argResults['help']) {
    print('Usage: my_cli_app [options]');
    print(parser.usage);
    return;
  }

  final currentDirectory = Directory.current;
  final libPath = Directory('${currentDirectory.path}/lib');

  if (!libPath.existsSync()) {
    print('The "lib" folder does not exist in the current working directory.');
    return;
  }

  checkDoubleLineCommentsInLibFolder(libPath);
}

void checkDoubleLineCommentsInLibFolder(Directory libDirectory) {
  libDirectory.listSync(recursive: true).whereType<File>().forEach(
    (file) {
      if (file.path.endsWith('.dart')) {
        final lines = file.readAsLinesSync();
        for (int i = 0; i < lines.length; i++) {
          if (lines[i].trim().startsWith('//')) {
            print('Double line comment found in ${file.path}:${i + 1}');
          }
        }
      }
    },
  );

  print('Double line comment check completed.');
}
