import 'package:flutter/material.dart';

class NewServices extends StatelessWidget {
  const NewServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 224, 224),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        toolbarHeight: 70,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(30),
          ),
        ),
        elevation: 10,
        title: const Text("New Services"),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),

      //------------------------------------------------------------------------
      //Body of the page
      //------------------------------------------------------------------------

      body: const TextCards(
        title:
            'This is were newly introduced services will appear. Do not worry about keeping on visiting, we will notify you!',
      ),
    );
  }
}

class TextCards extends StatelessWidget {
  // Define the attributes for customization

  final String title;

  const TextCards({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SizedBox(
        height: 150,
        width: MediaQuery.of(context).size.width,
        child: InkWell(
          child: Card(
            elevation: 20,
            color: const Color.fromARGB(255, 191, 243, 193),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center vertically
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
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
