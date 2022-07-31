import 'package:final_app/ui/screens/city_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // showPerformanceOverlay: true,
      home: CityScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<Offset> _animationOffset;

  var _weatherIconAlignment = Alignment.bottomCenter;

  void _show() {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        barrierColor: Colors.transparent,
        transitionAnimationController: _animationController,
        context: context,
        builder: (context) {
          return Container(
            height: 400,
            color: Colors.red,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Container(
        height: 600,
        width: double.infinity,
        color: Colors.black,
        child: Stack(
          children: [
            Align(
              alignment: _weatherIconAlignment,
              child: const SizedBox(
                width: 200,
                height: 200,
                child: Card(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _show,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _onListenerAnimation() {
    setState(() {
      _weatherIconAlignment = Alignment(_animationOffset.value.dx, _animationOffset.value.dy);
    });
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 200))..addListener(_onListenerAnimation);

    _animationOffset = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(-1, -1),
    ).animate(_animationController);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController
      ..removeListener(_onListenerAnimation)
      ..dispose();
  }
}
