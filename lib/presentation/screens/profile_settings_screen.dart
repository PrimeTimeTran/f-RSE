import 'package:flutter/material.dart';

import 'package:rse/all.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Settings'),
        leading: const ArrowBackButton(screenCode: '3-0', root: '/profile'),
      ),
      body: const Text('Hi'),
    );
  }
}
