import 'dart:typed_data';

enum MessageType { hello, welcome, requestData, data, ack, end, error }

class Message {
  MessageType type;
  String? content;

  Message(this.type, [this.content]);

  Uint8List toBytes() {
    return Uint8List.fromList([type.index]);
  }

  static Message fromBytes(Uint8List bytes) {
    return Message(MessageType.values[bytes[0]]);
  }
}
