import 'package:flutter/material.dart';
import 'package:selectos/selectos.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  final OPTIONS = [
    SelectosOption(
      value: '1',
      text: Text('Option 1'),
    ),
    SelectosOption(
      value: '2',
      text: Text('Option 2'),
    ),
    SelectosOption(
      value: '3',
      text: Text('Option 3'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Selectos plugin example app'),
        ),
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(16),
            constraints: const BoxConstraints(maxWidth: 414),
            child: Selectos(
              title: "Selectos",
              hintText: "Select an option",
              searchable: true,
              controller: SelectosController(options: []),
              validators: const [ SelectosValidator.required ],
              remote: ({ String? query }) async {
                await Future.delayed(const Duration(seconds: 1));
                return SelectosRemoteResponse(options: OPTIONS.where((element) => element.getValueAsString.contains(query ?? '')).toList());
              },
            ),
          ),
        ),
      ),
    );
  }
}
