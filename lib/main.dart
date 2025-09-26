import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  StateMachineController? _controller;
  SMIBool? _dragActive;
  SMIBool? _arrowActive;
  SMIBool? _textActive;
  SMIBool? _strokeActive;

  void _riveInit(Artboard artboard) async {
    final controller = StateMachineController.fromArtboard(
      artboard,
      'State Machine 1',
    );
    if (controller != null) {
      artboard.addController(controller);
      setState(() => _controller = controller);
    }
    _dragActive = controller?.findInput('Drag Active') as SMIBool;
    _arrowActive = controller?.findInput('Arrow Active') as SMIBool;
    _textActive = controller?.findInput('Text Active') as SMIBool;
    _strokeActive = controller?.findInput('Stroke Active') as SMIBool;
    print(_controller!.inputs.map((i) => i.name).toList());
    print(_controller!.inputs.map((i) => i.type).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: GestureDetector(
        // onTapDown: (_) {
        //   _arrowActive?.value = true; // start arrow animation
        //   _textActive?.value = true; // start text animation
        // },
        // onTapUp: (_) {
        //   _arrowActive?.value = false; // stop arrow animation
        //   _textActive?.value = false; // stop text animation
        // },
        // onTapCancel: () {
        //   // Ensure we stop if the tap is cancelled
        //   _arrowActive?.value = false;
        //   _textActive?.value = false;
        // },
        onPanStart: (_) => _dragActive?.value = true, // start dragging
        onPanEnd: (_) => _dragActive?.value = false,
        child: RiveAnimation.asset(
          'assets/animations/sketch_to_illustration.riv',
          onInit: (artboard) => _riveInit(artboard),
        ),
      ),
    );
  }
}
