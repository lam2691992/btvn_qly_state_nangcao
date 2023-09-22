import 'package:flutter/material.dart';

import 'bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'phương trình bậc 2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _aController = TextEditingController();
  final TextEditingController _bController = TextEditingController();
  final TextEditingController _cController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giải phương trình bậc hai'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _aController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nhập số a',
              ),
            ),
            TextField(
              controller: _bController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nhập số b',
              ),
            ),
            TextField(
              controller: _cController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Nhập số c',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final a = double.tryParse(_aController.text);
                final b = double.tryParse(_bController.text);
                final c = double.tryParse(_cController.text);

                if (a == null || b == null || c == null) {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Lỗi'),
                        content: const Text('Vui lòng nhập các hệ số hợp lệ'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  bloc.solveQuadraticEquation(a, b, c);
                }
              },
              child: const Text('Giải phương trình'),
            ),
            StreamBuilder<String>(
              stream: bloc.resultStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final result = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      result ?? "",
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
