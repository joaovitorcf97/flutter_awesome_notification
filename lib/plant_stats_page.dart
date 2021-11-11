import 'package:flutter/material.dart';
import 'package:flutter_awesome_notification/widget.dart';

class PlantStatsPage extends StatelessWidget {
  const PlantStatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBarTitle(),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Your Plant Stats',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: 45),
              PlantImage(),
              SizedBox(height: 25),
              PlantStats(),
            ],
          ),
        ),
      ),
    );
  }
}
