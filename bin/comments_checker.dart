import 'dart:io';

import 'package:args/args.dart';
import 'package:comments_checker/comments_checker.dart';

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
