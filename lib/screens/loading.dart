import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.black,
    body: InkWell(
      child: Stack(
        fit: StackFit.expand,
        children: [
          /// Paint the area where the inner widgets are loaded with the
          /// background to keep consistency with the screen background
          Container(
            decoration: const BoxDecoration(color: Colors.black),
          ),
          /// Render the Title widget, loader and messages below each other
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 30.0),
                    ),
                    Text('Application Title'),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    /// Loader Animation Widget
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.green),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                    Text('오늘을 그린다.'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}