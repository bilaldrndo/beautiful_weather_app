import 'package:final_app/ui/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class CityScreen extends StatefulWidget {
  const CityScreen({Key? key}) : super(key: key);

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class TopSizeSizes {
  static double big = 140;
  static double small = 50;
}

class _CityScreenState extends State<CityScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;

  late Animation<Offset> _iconAnimationOffset;
  var _weatherIconAlignment = Alignment.bottomCenter;

  late Animation<Offset> _textAnimationOffset;
  var _textAlignment = Alignment.topCenter;

  late Animation<double> _iconAnimationSize;
  var _iconSize = 220.0;

  late Animation<double> _textAnimationSize;
  var _textSize = 140.0;

  late Animation<double> _smallTextAnimationSize;
  var _smallTextSize = 30.0;

  void _onListenerAnimation() {
    setState(() {
      _weatherIconAlignment = Alignment(_iconAnimationOffset.value.dx, _iconAnimationOffset.value.dy);
      _textAlignment = Alignment(_textAnimationOffset.value.dx, _textAnimationOffset.value.dy);
      _iconSize = _iconAnimationSize.value;
      _textSize = _textAnimationSize.value;
      _smallTextSize = _smallTextAnimationSize.value;
    });
  }

  double size = 1;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(_onListenerAnimation);

    _animationController.addListener(() {
      size = 1 - _animationController.value;
      setState(() {});
      if (size <= 0.5) {
        size = 0;
      }
      // setState(() {
      //   if (newSize <= 1 && newSize >= 0.5) {
      //     size = 1 - _animationController.value - 0.5;
      //   } else if (newSize >= 0 && newSize <= 0.5) {
      //     size = 0.2;
      //   }
      //   // if (size <= 0.5) {
      //   //   // size = _animationController.value + 0.5;
      //   // }
      // });
      print(size);
    });

    _iconAnimationOffset = Tween<Offset>(
      begin: const Offset(0, 1),
      end: const Offset(-1, -1),
    ).animate(_animationController);

    _textAnimationOffset = Tween<Offset>(
      begin: const Offset(0, -1),
      end: const Offset(1, -1),
    ).animate(_animationController);

    _iconAnimationSize = Tween<double>(
      begin: 220,
      end: 170,
    ).animate(_animationController);

    _textAnimationSize = Tween<double>(
      begin: 140,
      end: 110,
    ).animate(_animationController);

    _smallTextAnimationSize = Tween<double>(
      begin: 30,
      end: 0,
    ).animate(_animationController);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController
      ..removeListener(_onListenerAnimation)
      ..dispose();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   _animationController = BottomSheet.createAnimationController(this);
  //   _animationController.duration = Duration(milliseconds: 200);

  //   bottomSheetController.addListener(() {
  //     double size = (bottomSheetController.value.toDouble() - 1) * -1;

  //     setState(() {
  //       if (size != 0) {
  //         bsOffset = size;
  //       }
  //     });
  //   });
  // }

  // @override
  // void dispose() {
  //   bottomSheetController.dispose();
  //   super.dispose();
  // }

  void _handleFABPressed() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      transitionAnimationController: _animationController,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Popover(
          child: Container(
            height: 590,
            // color: Colors.lightBlue,
          ),
        );
      },
    );
  }

  final end = Alignment.topLeft;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 130, 192, 247),
              Color.fromRGBO(80, 113, 203, 1),
              Color.fromRGBO(89, 114, 225, 1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 15,
              ),
              Text(
                'Los Angeles',
                style: TextStyle(
                  fontSize: 33,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Opacity(
                opacity: size,
                child: Container(
                  height: _smallTextSize,
                  child: Text(
                    'Chances of rain: 3%',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  width: double.infinity,
                  height: 300,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Align(
                        alignment: _textAlignment,
                        child: Text(
                          '23°',
                          style: TextStyle(
                            fontSize: _textSize,
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Align(
                        alignment: _weatherIconAlignment,
                        child: Container(
                          width: _iconSize,
                          child: Image.asset(
                            'assets/images/8.png',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    basicInfoCard(),
                    basicInfoCard(),
                    basicInfoCard(),
                    basicInfoCard(),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                  child: Text(
                    'Today',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 145,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (contex, index) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            height: 135,
                            width: 65,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: Offset(1, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 20),
                                Text(
                                  '12:00',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                ),
                                SizedBox(height: 7),
                                Image.asset(
                                  'assets/images/8.png',
                                  height: 45,
                                ),
                                SizedBox(height: 7),
                                Text(
                                  ' 23°',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black.withOpacity(0.55),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Expanded(child: SizedBox()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: GestureDetector(
                  onTap: () {
                    _handleFABPressed();
                  },
                  child: Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        'Next Seven Days',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget basicInfoCard() {
    return Container(
      width: 70,
      // height: 60,
      // color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Wind',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
          SizedBox(height: 3),
          Text(
            '9 km/h',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
