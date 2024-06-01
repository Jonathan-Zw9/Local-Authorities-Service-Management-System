import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:laas/models/database.dart';
import 'package:random_string/random_string.dart';

class RequestService extends StatefulWidget {
  const RequestService({super.key});

  @override
  State<RequestService> createState() => _RequestServiceState();
}

class _RequestServiceState extends State<RequestService> {
  TextEditingController serviceDescriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController serviceCategoryController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<dynamic> serviceCategoryList = [];

  String? serviceCategory;
  String? location;
  String? serviceDescription;

  @override
  void initState() {
    super.initState();

    serviceCategoryList.add({"id": "1", "label": "Permits"});
    serviceCategoryList.add({"id": "2", "label": "Licenses"});
    serviceCategoryList.add({"id": "3", "label": "Waste Management"});
    serviceCategoryList.add({"id": "4", "label": "Utilities"});
    serviceCategoryList.add({"id": "5", "label": "Animal Control"});
    serviceCategoryList.add({"id": "6", "label": "Public Works"});
    serviceCategoryList.add({"id": "7", "label": "Other"});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 224, 224),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text('Request For A Service'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),

      //Page Body
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, top: 100.0, right: 20.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        String id = randomAlphaNumeric(6);

                        Map<String, dynamic> serviceInfoMap = {
                          'Id': id,
                          'Service Category': serviceCategory!,
                          'Location': locationController.text,
                          'Service Description':
                              serviceDescriptionController.text,
                        };

                        await DatabaseMethods()
                            .addServiceDetails(serviceInfoMap, id)
                            .then((value) {
                          String toastMsg =
                              "Your service request (ID: $id) has been added successfully";
                          Fluttertoast.showToast(
                            msg: toastMsg,
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 3,
                            backgroundColor: Colors.blue,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blue), // Background color
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white), // Text color
                      ),
                      child: const Text('Submit Request'),
                    ),
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
