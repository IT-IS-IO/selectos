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
  @override
  void initState() {
    super.initState();
  }

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
              searchable: true,
              controller: SelectosController(
                options: const [
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
                ],
              ),
              validators: const [ SelectosValidator.required ],
              title: "Selectos",
              hintText: "Select an option",
              remote: ({String? query}) async {
                await Future.delayed(const Duration(seconds: 2));
                return const SelectosRemoteResponse(options: []);
              },
            ),
          ),
        ),
      ),
    );
  }
}
