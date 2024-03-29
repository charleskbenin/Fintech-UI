import 'package:flutter/material.dart';
import 'package:test/utils/exports.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Profile"),
      body: Column(
        children: const [
          Divider(),
          Center(
            child: Text("Profile"),
          ),
        ],
      ),
    );
  }
}
