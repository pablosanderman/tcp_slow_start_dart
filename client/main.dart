import 'dart:io';
import 'message.dart';

Message hello = Message(MessageType.hello);

Future<void> main() async {
  // Use IPv4 loopback address directly to avoid potential resolution issues
  final socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 0);

  final serverAddress = InternetAddress('127.0.0.1');
  final serverPort = 8888;

  print(
    'UDP Client started, connecting to ${serverAddress.address}:$serverPort',
  );

  socket.send(
    hello.toBytes(),
    serverAddress,
    serverPort,
  );
  print('Sent hello to server $serverAddress:$serverPort');

  socket.listen(
    (event) {
      switch (event) {
        case RawSocketEvent.read:
          final dg = socket.receive();
          if (dg != null) {
            print('Received message: ${Message.fromBytes(dg.data).type}');
            socket.close();
          }
          break;
      }
    },
  );
}
