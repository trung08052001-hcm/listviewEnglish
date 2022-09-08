import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:listviewtukhoa/data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Map<String, dynamic> _allWords = jsonDecode(data);
  late List<String> _allKeys;

  @override
  void initState() {
    super.initState();
    _allKeys = _allWords.keys.toList();
  }

  @override
  Widget build(BuildContext context) {
    print(_allWords['abacus']![0]);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dummy Fresher'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                setState(() {
                  _allKeys = _allWords.keys
                      .where((key) =>
                          key.toLowerCase().contains(value.toLowerCase()))
                      .toList();
                });
              },
              onSubmitted: (value) {},
              decoration: const InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _allKeys.length,
                itemBuilder: (BuildContext context, int index) {
                  final String key = _allKeys[index];
                  return ListTile(
                    title: Text(key),
                    subtitle: Text(_allWords[key][0]),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => DetailView(
                              word: key,
                              definition: _allWords[key][0],
                              pronounce: _allWords[key][1]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailView extends StatelessWidget {
  const DetailView(
      {Key? key,
      required this.word,
      required this.definition,
      required this.pronounce})
      : super(key: key);
  final String word;
  final String definition;
  final String pronounce;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(word),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(pronounce),
              Text(definition),
            ],
          ),
        ),
      ),
    );
  }
}
