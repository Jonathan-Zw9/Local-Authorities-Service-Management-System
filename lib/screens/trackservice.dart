// ignore_for_file: avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:laas/models/database.dart';

class TrackService extends StatefulWidget {
  const TrackService({super.key});

  @override
  State<TrackService> createState() => _TrackServiceState();
}

class _TrackServiceState extends State<TrackService> {
  TextEditingController serviceDescriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController serviceCategoryController = TextEditingController();

  List<dynamic> serviceCategoryList = [];

  String? serviceCategory;
  String? location;
  String? serviceDescription;

//   List<Segment> segments = [
//   Segment(value: 80, color: Colors.purple, label: Text("Done")),
//   Segment(value: 14, color: Colors.deepOrange, label: Text("In progress")),
//   Segment(value: 6, color: Colors.green, label: Text("Open")),
// ];

  @override
  void initState() {
    getontheload();
    super.initState();

    serviceCategoryList.add({"id": "1", "label": "Permits"});
    serviceCategoryList.add({"id": "2", "label": "Licenses"});
    serviceCategoryList.add({"id": "3", "label": "Waste Management"});
    serviceCategoryList.add({"id": "4", "label": "Utilities"});
    serviceCategoryList.add({"id": "5", "label": "Animal Control"});
    serviceCategoryList.add({"id": "6", "label": "Public Works"});
    serviceCategoryList.add({"id": "7", "label": "Other"});
  }

  Stream<QuerySnapshot>? serviceStream;

  getontheload() async {
    serviceStream = await DatabaseMethods().getServiceDetails();
    setState(() {});
  }

  Widget allServiceDetails() {
    return StreamBuilder<QuerySnapshot>(
        stream: serviceStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data!.docs[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 20.0),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 230, 240, 247),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Service ID: ${ds['Id']}',
                                    style: const TextStyle(
                                      color: Colors.red,
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      serviceCategoryController.text =
                                          ds['Service Category'];
                                      locationController.text = ds['Location'];
                                      serviceDescriptionController.text =
                                          ds['Service Description'];
                                      editServiceDetails(ds['Id']);
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: Color.fromARGB(255, 82, 238, 87),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () async {
                                      await DatabaseMethods()
                                          .deleteServiceDetails(ds['Id']);
                                      // Handle potential deletion errors (optional)
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'Service Category: ${ds['Service Category']}',
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontSize: 16.0,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Location:  ${ds['Location']}',
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 10, 173, 16),
                                  fontSize: 16.0,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Service Description: ${ds['Service Description']}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              const Center(
                                child: Text(
                                  'Service Status',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Center(
                                child: Text(
                                  'Status: ${ds['status'] ?? 'RECEIVED'}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              ProgressBar(status: ds['status']),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: LinearProgressIndicator(
                      backgroundColor: const Color.fromARGB(255, 81, 195, 240),
                      minHeight: 15.0,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
        });
  }

  @override
  Widget build(BuildContext context) {
    // final progressBar = PrimerProgressBar(segments: segments);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 252, 252),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
        ),
        title: const Text('Manage Services'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
        child: Column(
          children: [
            Expanded(child: allServiceDetails()),
          ],
        ),
      ),
    );
  }

  Future editServiceDetails(String id) => showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              content: Container(
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(Icons.cancel),
                        ),
                        const SizedBox(width: 60.0),
                        const Text(
                          'Edit Details',
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.only(left: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Service Category',
                          contentPadding: EdgeInsets.zero,
                        ),
                        value: serviceCategory,
                        onChanged: (value) {
                          setState(() {
                            serviceCategory = value;
                          });
                        },
                        items: serviceCategoryList
                            .map<DropdownMenuItem<String>>((item) {
                          return DropdownMenuItem<String>(
                            value: item['label'],
                            child: Text(item['label']!),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Location',
                          prefixIcon: Icon(Icons.location_on),
                          contentPadding: EdgeInsets.zero,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter location';
                          }
                          return null;
                        },
                        onSaved: (value) => location = value,
                        controller: locationController,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Container(
                      padding: const EdgeInsets.only(left: 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextFormField(
                        maxLines: 4,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          labelText: 'Service Description',
                          contentPadding: EdgeInsets.zero,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter problem description';
                          }
                          return null;
                        },
                        onSaved: (value) => serviceDescription = value,
                        controller: serviceDescriptionController,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Center(
                      child: ElevatedButton(
                          onPressed: () async {
                            Map<String, dynamic> updateInfo = {
                              'Service Category':
                                  serviceCategoryController.text,
                              'Location': locationController.text,
                              'Service Description':
                                  serviceDescriptionController.text,
                            };
                            await DatabaseMethods()
                                .updateServiceDetails(id, updateInfo)
                                .then((value) {
                              Navigator.pop(context);
                            });
                          },
                          child: const Text('Update!')),
                    )
                  ],
                ),
              ),
            )),
      );
}

class ProgressBar extends StatelessWidget {
  final String status;

  const ProgressBar({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    double progressValue = 0.0;
    Color progressColor = Colors.red;

    if (status == 'RECEIVED') {
      progressValue = 0.2;
      progressColor = const Color.fromARGB(255, 236, 93, 83);
    } else if (status == 'INPROGRESS') {
      progressValue = 0.7;
      progressColor = const Color.fromARGB(255, 179, 243, 181);
    } else if (status == 'COMPLETED') {
      progressValue = 1.0;
      progressColor = const Color.fromARGB(255, 6, 245, 14);
    }

    return
        // Center(
        //   child: SizedBox(
        //     width: 200,
        //     child: LinearProgressIndicator(
        //       value: progressValue,
        //       backgroundColor: Colors.white,
        //       valueColor: AlwaysStoppedAnimation<Color>(progressColor),
        //       minHeight: 12,
        //       borderRadius: BorderRadius.circular(10),
        //     ),
        //   ),
        // );
        Center(
      child: SizedBox(
        width:
            200.0, // Set the desired width of the circular progress indicator
        height: 100,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircularProgressIndicator(
              strokeWidth: 50.0, // Set the desired thickness of the circle
              backgroundColor: Colors.white,
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              value: progressValue,
            ),
            Text(
              '${(progressValue * 100).toInt()}%',
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
