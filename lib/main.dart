import 'package:codigo7_provider/providers/counter_provider.dart';
import 'package:codigo7_provider/providers/login_provider.dart';
import 'package:codigo7_provider/providers/product_provider.dart';
import 'package:codigo7_provider/providers/register_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
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
        ChangeNotifierProvider(create: (context) => ProductProvider()),
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
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ProductProvider productProvider =
          Provider.of<ProductProvider>(context, listen: false);
      productProvider.getProducts2();
    });
  }

  @override
  Widget build(BuildContext context) {
    CounterProvider counterProvider =
        Provider.of<CounterProvider>(context, listen: false);
    print("BUILD!!!!");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(
          "Provider",
        ),
        actions: [
          // Text(counterProvider.counter.toString())
          Consumer<CounterProvider>(
            builder: (context, provider, _) {
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
            Consumer<CounterProvider>(
              builder: (context, provider, _) {
                return Text(provider.selectedName);
              },
            ),
            ElevatedButton(
              child: Text("Contar"),
              onPressed: () {
                counterProvider.changeCounter();
              },
            ),
            ElevatedButton(
              child: Text("Agregar Nombre"),
              onPressed: () {
                //Aquí debemos de agregar un nombre a la lista del Provider.
                counterProvider.addName("Juan");
              },
            ),
            ElevatedButton(
              child: Text("Ir"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DetailPage()));
              },
            ),
            Consumer<ProductProvider>(
              builder: (context, provider, _) {
                return Text(provider.products.toString());
              },
            )
          ],
        ),
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Consumer<CounterProvider>(
          builder: (context, provider, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(provider.counter.toString()),
                ...provider.names.map((e) => Text(e)),
                Consumer<CounterProvider>(
                  builder: (context, provider, _) {
                    return DropdownButton(
                      value: provider.selectedName,
                      items: provider.names
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ),
                          )
                          .toList(),
                      onChanged: (String? value) {
                        provider.changeName(value!);
                      },
                    );
                  },
                ),
                Consumer<ProductProvider>(
                  builder: (context, provider, _) {
                    return FutureBuilder(
                      future: provider.getProducts(),
                      builder: (BuildContext context, AsyncSnapshot snap) {
                        if (snap.hasData) {
                          List products = snap.data;
                          return Column(
                            children: products.map((e) => Text(e)).toList(),
                          );
                        }
                        return CircularProgressIndicator();
                      },
                    );
                  },
                ),
                Consumer<ProductProvider>(
                  builder: (context, provider, _) {
                    return Text(provider.products.toString());
                  },
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
