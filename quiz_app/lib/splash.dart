

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:quizapp/animation.dart';
import 'package:quizapp/wrapper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{

  AnimationController _scaleController;
  AnimationController _scale2Controller;
  AnimationController _widthController;
  AnimationController _positionController;

  Animation<double> _scaleAnimation;
  Animation<double> _scale2Animation;
  Animation<double> _widthAnimation;
  Animation<double> _positionAnimation;

  bool hideIcon = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _scaleController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300)
    );

    _scaleAnimation = Tween<double>(
        begin: 1.0, end: 0.8
    ).animate(_scaleController)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _widthController.forward();
      }
    });

    _widthController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 600)
    );

    _widthAnimation = Tween<double>(
        begin: 80.0,
        end: 300.0
    ).animate(_widthController)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _positionController.forward();
      }
    });

    _positionController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1000)
    );

    _positionAnimation = Tween<double>(
        begin: 0.0,
        end: 215.0
    ).animate(_positionController)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          hideIcon = true;
        });
        _scale2Controller.forward();
      }
    });

    _scale2Controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300)
    );

    _scale2Animation = Tween<double>(
        begin: 1.0,
        end: 32.0
    ).animate(_scale2Controller)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: Wrapper()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      body: Container(
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            Positioned(
              height: 360,
              left: 0,
              child: FadeAnimation(1, Container(
                width: width,
                height: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage( "images/qu.png",),


                    )
                ),
              )),
            ),


            SizedBox(height: 0,),
            Container(
              padding: EdgeInsets.all(1.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 15.0,),
                  FadeAnimation(1.3, Text("Welcome ",
                    style: TextStyle(color: Colors.white.withOpacity(.7), height: 1.4, fontSize: 40),)),
                  SizedBox(height: 25,),
                  Text("A quiz is a form of game or mind sport, attempt to answer questions correctly. It is a game to test knowledge about a certain subject",

                    style: TextStyle(color: Colors.white.withOpacity(.3)),),
                  FadeAnimation(1.6, AnimatedBuilder(
                    animation: _scaleController,
                    builder: (context, child) => Transform.scale(
                        scale: _scaleAnimation.value,
                        child: Center(
                          child: AnimatedBuilder(
                            animation: _widthController,
                            builder: (context, child) => Container(
                              width: _widthAnimation.value,
                              height: 80,
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.blue.withOpacity(.4)
                              ),
                              child: InkWell(
                                onTap: () {
                                  _scaleController.forward();
                                },
                                child: Stack(
                                    children: <Widget> [
                                      AnimatedBuilder(
                                        animation: _positionController,
                                        builder: (context, child) => Positioned(
                                          left: _positionAnimation.value,
                                          child: AnimatedBuilder(
                                            animation: _scale2Controller,
                                            builder: (context, child) => Transform.scale(
                                                scale: _scale2Animation.value,
                                                child: Container(
                                                  width: 60,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.blue
                                                  ),
                                                  child: hideIcon == false ? Icon(Icons.arrow_forward, color: Colors.white,) : Container(),
                                                )
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]
                                ),
                              ),
                            ),
                          ),
                        )),
                  )),
                  SizedBox(height: 60,),
                  Text("                                   Touch on the Arror\n "
                      "                                    To open Sign Page",style: TextStyle(color: Colors.white30),),
                  SizedBox(height: 30,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
