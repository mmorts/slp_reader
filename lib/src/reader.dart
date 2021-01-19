import 'dart:typed_data';

abstract class C {
  int get offset;
}

/// A fixed length string
class CFixedLenString implements C {
  final int length;

  final int offset;

  const CFixedLenString(this.length, {this.offset});
}

class CInt32 implements C {
  final int offset;

  const CInt32({this.offset});
}

class CUInt32 implements C {
  final int offset;

  const CUInt32({this.offset});
}

class Header {
  @CFixedLenString(4)
  List<int> version;

  @CInt32()
  int frameCount;

  @CFixedLenString(24)
  List<int> comment;

  Header({this.version, this.frameCount, this.comment});

  static Header parse(Uint8List data) {
    ByteData byteData = data.buffer.asByteData();

    List<int> version = data.take(4).toList();
    int frameCount = byteData.getUint32(4, Endian.little);
    List<int> comment = data.skip(8).take(24).toList();

    return Header(version: version, frameCount: frameCount, comment: comment);
  }

  String get versionStr => String.fromCharCodes(version);

  String get commentStr => String.fromCharCodes(comment);

  String toString() => {
    'version': versionStr,
    'Frame count': frameCount,
    'comment': commentStr,
  }.toString();
}

class FrameInfo {
  @CUInt32()
  int qdlTableOffset;

  @CUInt32()
  int outlineTableOffset;

  @CUInt32()
  int paletteOffset;

  @CUInt32()
  int properties;

  @CInt32()
  int width;

  @CInt32()
  int height;

  @CInt32()
  int hotspotX;

  @CInt32()
  int hotspotY;

  FrameInfo(
      {this.qdlTableOffset,
      this.outlineTableOffset,
      this.paletteOffset,
      this.properties,
      this.width,
      this.height,
      this.hotspotX,
      this.hotspotY});
}
