// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class InterestPage extends StatefulWidget {
  const InterestPage({super.key});

  @override
  State<InterestPage> createState() => _InterestPageState();
}

class _InterestPageState extends State<InterestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Text("Interests"),
              Text(
                  "Let everyone know what you’re interestedin by adding it to your profile."),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    width: 1,
                    color: Color.fromRGBO(191, 195, 207, 1),
                  ),
                ),
                child: Text("90s Kid"),
              ),
              Container(
                decoration:
                    BoxDecoration(color: Color.fromRGBO(235, 236, 239, 1)),
                child: Text("Continue"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
