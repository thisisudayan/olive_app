import 'package:flutter/material.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          pinned: true,
          expandedHeight: 160.0,
          flexibleSpace: const FlexibleSpaceBar(
            title: Text('Settings'),
            centerTitle: true,
          ),
        ),
        SliverList.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.person_outline),
              title: Text('Profile Settings'),
              onTap: () {},
            );
          },
        ),
      ],
    );
  }
}