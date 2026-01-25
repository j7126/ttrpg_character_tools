import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/service/static_service.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Service.appName),
      ),
      body: const Center(
        child: Text('An unknown error has occurred.'),
      ),
    );
  }
}
