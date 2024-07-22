import 'package:flutter/material.dart';
import 'package:fubble_animations/Animations/Stars/stars_animation.dart';

class StarSetting extends StatefulWidget {
  @override
  _StarSettingState createState() => _StarSettingState();
}

class _StarSettingState extends State<StarSetting> {

  //initials values for sliders
  double starCount = 200;
  double maxStarSize = 20;
  double speed = 1;
  late Color color = Colors.red;
  late double canvasWidth = 120.0;
  late double canvasHeight;
  late String animation = 'Default';
  late String gesture = 'Default';

//Color List for Bubble color
  static const colors = <Color>[
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.blueGrey
  ];

//gestures  or   On Draw Effects
  static const gestur = [
    'Default',
    'CenterBlast',
    'Dart',
    'Attract',
    'Eraser'];

  //Star Animations
  static const star = [
    'Default',
    'WallBreaker',
    'OnWeed',
    'Goodnbad',
    'Battle',
    'Rain'
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    canvasWidth = MediaQuery.of(context).size.width;
    canvasHeight = MediaQuery.of(context).size.height;
  }


  // mapping the star animation list
  List<DropdownMenuItem<String>> animationList = star.map((b) {
    return DropdownMenuItem<String>(
      value: b,
      child: Text(
        b,
        style: TextStyle(color: Colors.black),
      ),
    );
  }).toList();


  // mapping the gesture or on draw effects  list
  final List<DropdownMenuItem<String>> gestureList = gestur.map((animation) {
    return DropdownMenuItem<String>(
      value: animation,
      child: Text(
        animation,
        style: TextStyle(color: Colors.black),
      ),
    );
  }).toList();


  // mapping the Colors list
  final List<DropdownMenuItem<Color>> colorsList = colors.map((colr) {
    return DropdownMenuItem<Color>(
      value: colr,
      child: Text(
        colr.toString().padRight(5),
        style: TextStyle(color: colr),
      ),
    );
  }).toList();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.settings_backup_restore),
            onPressed: () {
              setState(() {
                starCount = 200;
                maxStarSize = 20;
                speed = 1;
                color = Colors.red;
                canvasWidth = 420;
                canvasHeight = 420;
              });
            },
          )
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => Stars(
                    starCount: starCount,
                    maxStarSize: maxStarSize,
                    speed: speed,
                    canvasWidth: MediaQuery.of(context).size.width,
                    canvasHeight: MediaQuery.of(context).size.height,
                  ))),
        ),
        title: Text('Settings'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              elevation: 5,
              child: SingleChildScrollView(
                child: Column(
                  children:[
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Number of Stars',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Slider(
                      activeColor: Colors.indigoAccent,
                      min: 120.0,
                      divisions: 1040,
                      label: '${starCount.round()}',
                      max: 423.5294196844927,
                      onChanged: (value) {
                        setState(() => starCount = value);
                      },
                      value: starCount,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Card(
              elevation: 5,
              child: Column(
                children: [
                  const Text(
                    'Star Size',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Slider(
                    activeColor: Colors.indigoAccent,
                    min: 8.0,
                    divisions: 1040,
                    label: '${maxStarSize.round()}',
                    max: 50.0,
                    onChanged: (value) {
                      setState(() => maxStarSize = value);
                    },
                    value: maxStarSize,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Card(
              elevation: 5,
              child: Column(
                children: <Widget>[
                  const Text(
                    'Star Speed',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Slider(
                    activeColor: Colors.indigoAccent,
                    min: 1.0,
                    divisions: 140,
                    label: '${speed.round()}',
                    max: 23.0,
                    onChanged: (value) {
                      setState(() => speed = value);
                    },
                    value: speed,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Card(
              elevation: 5,
              child: Column(
                children: <Widget>[
                  const Text(
                    'Canvas width',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Slider(
                    activeColor: Colors.indigoAccent,
                    min: 120.0,
                    // label: '${canvasWidth}',
                    max: MediaQuery.of(context).size.width,
                    onChanged: (value) {
                      setState(() => canvasWidth = value);
                    },
                    value: canvasWidth ?? MediaQuery.of(context).size.width,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Card(
              elevation: 5,
              child: Column(
                children:[
                  const Text(
                    'Canvas Height',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Slider(
                    activeColor: Colors.indigoAccent,
                    min: 120.0,
                    max: MediaQuery.of(context).size.height,
                    onChanged: (value) {
                      setState(() => canvasHeight = value);
                    },
                    value: canvasHeight ?? MediaQuery.of(context).size.height,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Card(
              elevation: 5,
              child: Column(
                children: <Widget>[
                  const Text(
                    'Star color',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 9, right: 9),
                    child: DropdownButton(
                      underline: Container(),
                      value: color,
                      hint: const Text('Choose custom bubble color'),
                      onChanged: (value) {
                        setState(() {
                          color = value!;
                        });
                      },
                      items: colorsList,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Card(
                  elevation: 5,
                  child: Column(
                    children: [
                      const Text(
                        'Star animation',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 9, right: 9),
                        child: DropdownButton(
                          underline: Container(),
                          value: animation,
                          hint: const Text('Default'),
                          onChanged: (value) {
                            setState(() {
                              animation = value!;
                            });
                          },
                          items: animationList,
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 5,
                  child: Column(
                    children:[
                      const Text(
                        'On Draw Effect',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 9, right: 9),
                        child: DropdownButton(
                          underline: Container(),
                          value: gesture,
                          hint: const Text('Default'),
                          onChanged: (value) {
                            setState(() {
                              gesture = value!;
                            });
                          },
                          items: gestureList,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Stars(
                            starCount: starCount,
                            maxStarSize: maxStarSize,
                            speed: speed,
                            color: color,
                            animation: animation,
                            gesture: gesture,
                            canvasWidth: canvasWidth,
                            canvasHeight: canvasHeight,
                          )));
                },
                child: const Text(
                  'Save Settings',
                  style: TextStyle(color: Colors.white),
                ),
                // color: Theme.of(context).primaryColor,
              ),
            ),
            const Text(
              'Fubble v1.0',
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}

