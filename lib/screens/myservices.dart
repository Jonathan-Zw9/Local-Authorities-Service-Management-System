import 'package:flutter/material.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';

class MyServices extends StatelessWidget implements NavigationStates {
  const MyServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 224, 224),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
        ),
        title: const Text('My Services'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),

      //Screen body
      body: Column(
        children: [
          ServiceCard(
            icon: Icons.playlist_add,
            iconColor: Colors.green,
            iconSize: 40,
            title: 'Request Service',
            subtitle: 'Prompt assistance for your needs',
            onTap: () {},
          ),
          ServiceCard(
            icon: Icons.manage_history,
            iconColor: Colors.green,
            iconSize: 40,
            title: 'Track Service',
            subtitle: 'Stay updated on service progress',
            onTap: () {},
          ),
          ServiceCard(
            icon: Icons.favorite_outline,
            iconColor: Colors.red,
            iconSize: 40,
            title: 'Suggested Services',
            subtitle: 'Explore services you may like',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  // Define the attributes for customization
  final IconData icon;
  final Color iconColor;
  final double iconSize;
  final String title;
  final String subtitle;
  final VoidCallback onTap; // Function type for onTap

  const ServiceCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconSize,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(3, 5, 3, 0),
      child: SizedBox(
        height: 90,
        child: InkWell(
          onTap: onTap,
          child: Card(
            color: Colors.white,
            child: Column(
              children: [
                ListTile(
                  title: Center(
                    child: Text(
                      title,
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ),
                  subtitle: Center(child: Text(subtitle)),
                  leading: Icon(
                    icon,
                    size: iconSize,
                    color: iconColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
