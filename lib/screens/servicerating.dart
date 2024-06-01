import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';

class ServiceRating extends StatefulWidget {
  const ServiceRating({super.key});

  @override
  State<ServiceRating> createState() => _ServiceRatingState();
}

class _ServiceRatingState extends State<ServiceRating> {
  double value = 3.5;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 224, 224, 224),
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          toolbarHeight: 50,
          elevation: 10,
          title: const Text("Service Rating"),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          color: Colors.blueGrey,
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RatingWidget(
                title: 'Waste Management',
                value: 3.5,
                onValueChanged: (value) {
                  // handle value change
                },
              ),
              RatingWidget(
                title: 'Licensing',
                value: 3.5,
                onValueChanged: (value) {
                  // handle value change
                },
              ),
              RatingWidget(
                title: 'Permits',
                value: 2,
                onValueChanged: (value) {
                  // handle value change
                },
              ),
              RatingWidget(
                title: 'Public Works',
                value: 3.5,
                onValueChanged: (value) {
                  // handle value change
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RatingWidget extends StatelessWidget {
  final String title;
  final double value;
  final ValueChanged<double> onValueChanged;

  const RatingWidget({
    super.key,
    required this.title,
    required this.value,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.blueGrey,
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 10),
          RatingStars(
            axis: Axis.horizontal,
            value: value,
            onValueChanged: onValueChanged,
            starCount: 5,
            starSize: 35,
            valueLabelColor: const Color(0xff9b9b9b),
            valueLabelTextStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.normal,
                fontSize: 12.0),
            valueLabelRadius: 10,
            maxValue: 5,
            starSpacing: 2,
            maxValueVisibility: true,
            valueLabelVisibility: true,
            animationDuration: const Duration(milliseconds: 1000),
            valueLabelPadding:
                const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
            valueLabelMargin: const EdgeInsets.only(right: 8),
            starOffColor: const Color(0xffe7e8ea),
            starColor: Colors.yellow,
            angle: 12,
          ),
        ],
      ),
    );
  }
}
