


import 'package:codigo7_provider/providers/counter_provider.dart';
import 'package:codigo7_provider/providers/login_provider.dart';
import 'package:codigo7_provider/providers/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CounterProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => RegisterProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int contador = 0;

  @override
  Widget build(BuildContext context) {
    
    CounterProvider counterProvider = Provider.of<CounterProvider>(context, listen: false);
    print("BUILD!!!!");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text("Provider",),
        actions: [
          // Text(counterProvider.counter.toString())
          Consumer<CounterProvider>(
            builder: (context, provider, _){
              print(provider.counter);
              return Text(provider.counter.toString());
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(counterProvider.counter.toString()),
            ElevatedButton(
              child: Text("Contar"),
              onPressed: (){
                counterProvider.changeCounter();
              },
            ),
          ],
        ),
      ),
    );
  }
}