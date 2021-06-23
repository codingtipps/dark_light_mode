import 'package:dark_light_mode_example/theme.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => MyTheme(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),),
      darkTheme: ThemeData.dark().copyWith(
        textTheme: TextTheme(
          bodyText1: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      themeMode: context.watch<MyTheme>().currentTheme(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Switch Dark Light Mode'),
        actions: [
          InkWell(
          onTap: () {
            if (context.read<MyTheme>().currentTheme() == ThemeMode.light) {
              _controller.forward();
            } else {
              _controller.reverse();
            }
            context.read<MyTheme>().switchTheme();
          },
          child: Lottie.network(
              'https://assets6.lottiefiles.com/packages/lf20_duNn3g.json',
              height: 50, width: 50,
              controller: _controller, onLoaded: (composition) {
            _controller.duration = composition.duration;
          }),
        ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
            child: RichText(text: TextSpan(
              text: 'Follow ',style: Theme.of(context).textTheme.bodyText1,
              children: [
                TextSpan(text: '@Codingtipps', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: ' for more awesome'),
                TextSpan(text: ' Flutter',style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),

                TextSpan(text: ' Content'),
              ]
            ),),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person),
          ),
          BottomNavigationBarItem(
            label: 'Add',
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

