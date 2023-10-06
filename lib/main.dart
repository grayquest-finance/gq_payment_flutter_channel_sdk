import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'GrayQuest Payment SDK',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const platform = MethodChannel('GQPaymentSDK/channel');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: Center(
          child: ElevatedButton(
            onPressed: () {
              _loadGQSDK();
            },
            child: const Text("Open SDK"),

        ),
      ),
    );
  }

  Future _loadGQSDK() async {
    try {
      await platform
          .invokeMethod('initiateGQPayment', 'Open SDK')
          .then((result) {
            print(result);
      });
    } on PlatformException catch (e) {
      print("Error load SDK");
      print(e.message);
    }
  }
}
