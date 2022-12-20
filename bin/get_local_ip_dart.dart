import 'dart:io';

Future<void> main() async {
  final id = await getIP();
  print('IP: $id');
}

Future<String?> getIP() async {
  try {
    final addresses = await NetworkInterface.list();
    final address = addresses
        .where((ni) => ni.addresses.any((ia) => ia.address.startsWith('192')));
    if (address.isEmpty) return null;
    return address.first.addresses
        .firstWhere((v) => v.address.startsWith('192'))
        .address;
  } on SocketException catch (e) {
    print('Error: $e');
    return null;
  }
}
