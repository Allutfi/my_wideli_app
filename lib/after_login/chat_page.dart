import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pesan ke Penjual"),
      ),
      body: const Center(
        child: Text(
          "Ini halaman pesan/chat ke penjual.\nNanti bisa integrasi ke fitur chat.",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
