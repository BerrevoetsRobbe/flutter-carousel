import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final SlideRoll _slideRoll = SlideRoll(
    <SlideRollItem>[
      SlideRollItem(1, "graphics/Belgium.png"),
      SlideRollItem(2, "graphics/Flanders.png"),
      SlideRollItem(3, "graphics/Wallonia.png"),
    ],
    5,
  );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: SlideRollWidget(
        slideRoll: _slideRoll,
      ),
    );
  }
}

class SlideRoll {
  final List<SlideRollItem> slideRollItems;
  final int duration;

  SlideRoll(this.slideRollItems, this.duration);
}

class SlideRollItem {
  final int id;
  final String name;

  SlideRollItem(this.id, this.name);
}

class SlideRollWidget extends StatefulWidget {
  const SlideRollWidget({Key key, this.slideRoll}) : super(key: key);
  final SlideRoll slideRoll;

  @override
  _SlideRollWidgetState createState() => _SlideRollWidgetState();
}

class _SlideRollWidgetState extends State<SlideRollWidget> {
  int _counter;
  List<SlideWidget> _widgets;

  @override
  void initState() {
    super.initState();

    _counter = 0;
    _widgets = widget.slideRoll.slideRollItems
        .map(
          (slideRollItem) => SlideWidget(
            key: ValueKey(slideRollItem.id),
            slideRollItem: slideRollItem,
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return _widgets.length > 0
        ? Column(
            children: [
              PageTransitionSwitcher(
                duration: Duration(milliseconds: 1000),
                transitionBuilder: (
                  child,
                  animation,
                  secondaryAnimation,
                ) {
                  return FadeThroughTransition(
                    animation: animation,
                    secondaryAnimation: secondaryAnimation,
                    child: child,
                    fillColor: Colors.black,
                  );
                },
                child: _widgets[_counter],
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _counter = (_counter + 1) % _widgets.length;
                  });
                },
                child: Text("increment"),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _counter = (_counter - 1) % _widgets.length;
                  });
                },
                child: Text("decrement"),
              )
            ],
          )
        : SizedBox.shrink();
  }
}

class SlideWidget extends StatelessWidget {
  const SlideWidget({Key key, this.slideRollItem}) : super(key: key);

  final SlideRollItem slideRollItem;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        slideRollItem.name,
        fit: BoxFit.contain,
      ),
      height: MediaQuery.of(context).size.height * 0.9,
      width: MediaQuery.of(context).size.width,
    );
  }
}
