import 'dart:io';
import 'message.dart';

Message welcome = Message(MessageType.welcome);

Future<void> main() async {
  // Use 0.0.0.0 to listen on all interfaces
  final socket = await RawDatagramSocket.bind(InternetAddress.anyIPv4, 8888);
  print('UDP socket listening on ${socket.address.address}:${socket.port}');

  socket.listen((event) {
    switch (event) {
      case RawSocketEvent.read:
        final dg = socket.receive();
        if (dg != null) {
          print('Received message: ${Message.fromBytes(dg.data).type}');
          final payload = welcome.toBytes();
          socket.send(payload, dg.address, dg.port);
        }
        break;
    }
  });
}
