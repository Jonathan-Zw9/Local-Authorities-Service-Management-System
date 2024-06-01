// ignore_for_file: sort_child_properties_last, deprecated_member_use

import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:laas/chatbot/chatpage.dart';
import 'package:laas/screens/myaccount.dart';
import 'package:laas/screens/myservices.dart';
import 'package:laas/screens/newservices.dart';
import 'package:laas/screens/reportproblem.dart';
import 'package:laas/screens/requestservice.dart';
import 'package:laas/screens/servicerating.dart';

import 'package:laas/screens/trackservice.dart';
import 'package:laas/sidebar/sidebar_ui.dart';
import '../bloc.navigation_bloc/navigation_bloc.dart';

import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget implements NavigationStates {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  late String title;
  final screens = [
    const MyAccount(),
    const ChatBotScreen(),
    const MyServices(),
  ];

  final items = <Widget>[
    const Icon(size: 30, color: Colors.white, Icons.manage_history),
    const Icon(size: 35, color: Colors.white, Icons.chat),
    const Icon(size: 30, color: Colors.white, Icons.playlist_add),
  ];

  @override
  Widget build(BuildContext context) {
    final List<CarouselItem> carouselItems = [
      CarouselItem(
        assetImage: 'assets/images/smart.jpg',
        title: 'Harare City Council to destroy condemned buildings',
        url:
            'https://www.thezimbabwemail.com/zimbabwe/harare-city-council-to-destroy-condemned-buildings/#google_vignette',
      ),
      CarouselItem(
          assetImage: 'assets/images/laas.png',
          title: 'Harare-goes-after-debtors',
          url: 'https://www.sundaymail.co.zw/harare-goes-after-debtors'),
      CarouselItem(
        assetImage: 'assets/images/pic001.jpeg',
        title: 'Shake-up-at-harare-city-council',
        url:
            'https://www.newsday.co.zw/thestandard/news/article/200022071/shake-up-at-harare-city-council',
      ),
      CarouselItem(
          assetImage: 'assets/images/pic002.jpeg',
          title: 'Harare-city-council-claims-ratepayers-owe-zig940-million',
          url:
              'https://www.pindula.co.zw/2024/05/01/harare-city-council-claims-ratepayers-owe-zig940-million/'),
      CarouselItem(
          assetImage: 'assets/images/pic003.jpeg',
          title: 'Harare-city-adopt-digital-systems-to-improve-efficiency',
          url:
              'https://www.newzimbabwe.com/harare-city-council-moves-to-adopt-digital-systems-to-improve-efficiency/'),
      CarouselItem(
          assetImage: 'assets/images/sofa.jpeg',
          title: 'Harare-city-council-summons-defaulters/',
          url:
              'https://dailynews.co.zw/harare-city-council-summons-defaulters/'),
      //...
    ];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 224, 224),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
        ),
        title: const Text('Local Services'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        actions: [
          IconButton(
            color: Colors.white,
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            color: Colors.white,
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          )
        ],
      ),

      drawer: const SideBarUI(),

      // HomePage body
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              'Community News',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 1.5,
                viewportFraction: 0.95,
                enlargeCenterPage: true,
                enableInfiniteScroll: false,
                initialPage: 2,
                autoPlay: true,
              ),
              items: carouselItems.map((item) => item.build(context)).toList(),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: Row(
                children: [
                  GestureDetector(
                    child: ServiceCard(
                      icon: Icons.playlist_add,
                      iconColor: Colors.green,
                      title: 'Request Service',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RequestService()),
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    child: ServiceCard(
                      icon: Icons.manage_history,
                      iconColor: Colors.green,
                      title: 'Track Service',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TrackService()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6.0),
              child: Row(
                children: [
                  GestureDetector(
                    child: ServiceCard(
                      icon: Icons.warning,
                      iconColor: Colors.red,
                      title: 'Report Problem',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ReportProblem()),
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    child: ServiceCard(
                      icon: Icons.star_half,
                      iconColor: Colors.brown,
                      title: 'Service Rating',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ServiceRating()),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 6.0,
                left: 5.0,
                right: 10,
              ),
              child: GestureDetector(
                child: CustomServiceCard(
                  icon: Icons.add_box,
                  iconColor: Colors.blue,
                  title: 'New Services',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NewServices()),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),

      //HomePage footer

      //bottom curved navigation bar here
      //------------------------------------------------------------------------

      bottomNavigationBar: CurvedNavigationBar(
        color: Colors.blue,
        backgroundColor: const Color.fromARGB(255, 224, 224, 224),
        items: items,
        index: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => screens[_selectedIndex]));
        },
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  // Define the attributes for customization
  final IconData icon;
  final Color iconColor;
  final double iconSize = 40;
  final String title;
  final VoidCallback onTap;

  const ServiceCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3, right: 5, top: 2),
      child: SizedBox(
        height: 100,
        width: 160,
        child: InkWell(
          onTap: onTap,
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center vertically
                children: [
                  Icon(
                    icon,
                    size: iconSize,
                    color: iconColor,
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const Spacer(), // Spacer to fill remaining space
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//------------------------------------------------------------------------------
//CustomServiceCard class
//------------------------------------------------------------------------------
class CustomServiceCard extends StatelessWidget {
  // Define the attributes for customization
  final IconData icon;
  final Color iconColor;
  final double iconSize = 40;
  final String title;
  final VoidCallback onTap;

  const CustomServiceCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 3, right: 5, top: 2),
      child: SizedBox(
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: InkWell(
          onTap: onTap,
          child: Card(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center vertically
                children: [
                  Icon(
                    icon,
                    size: iconSize,
                    color: iconColor,
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                  const Spacer(), // Spacer to fill remaining space
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CarouselItem {
  final String assetImage;
  final String title;
  final String url;

  CarouselItem({
    required this.assetImage,
    required this.title,
    required this.url,
  });

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final uri = Uri.parse(url);
        if (await canLaunch(uri.toString())) {
          await launch(uri.toString());
        } else {
          throw 'Could not launch $uri';
        }
      },
      child: Container(
        margin: const EdgeInsets.all(5.0),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              Image.asset(
                assetImage,
                fit: BoxFit.cover,
                width: 1000.0,
              ),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  ),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
