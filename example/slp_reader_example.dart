import 'dart:io';
import 'dart:typed_data';
import 'package:slp_reader/slp_reader.dart';

main() async {
  final bytes =
      Uint8List.fromList(await File('example/3836.slp').readAsBytes());
  final header = Header.parse(bytes);

  print(header);
}
