// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:laas/models/database.dart';
import 'package:random_string/random_string.dart';
import 'package:tflite_v2/tflite_v2.dart';

class ReportProblem extends StatefulWidget {
  const ReportProblem({super.key});

  @override
  State<ReportProblem> createState() => _ReportProblemState();
}

class _ReportProblemState extends State<ReportProblem> {
  //----------------------------------------------------------------------------
  //image selection and recognition process
  //----------------------------------------------------------------------------
  final ImagePicker _picker = ImagePicker();
  XFile? _image;
  File? file;
  var _recognitions;
  String v = "";
//------------------------------------------------------------------------------
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<dynamic> problemCategoryList = [];
  TextEditingController problemDescriptionController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController problemCategoryController = TextEditingController();
  String? problemCategory;
  String? location;
  String? problemDescription;
  //----------------------------------------------------------------------------
  // Combined initStates()
  //----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    loadmodel().then((value) {
      setState(() {});
    });
    initializeProblemCategories();
  }

  void initializeProblemCategories() {
    problemCategoryList.add({"id": "1", "label": "Potholes"});
    problemCategoryList.add({"id": "2", "label": "Traffic lights"});
    problemCategoryList.add({"id": "3", "label": "Street lights"});
    problemCategoryList.add({"id": "4", "label": "Burst water pipes"});
    problemCategoryList.add({"id": "5", "label": "Sewer backup"});
    problemCategoryList.add({"id": "6", "label": "Illegal dumping"});
    problemCategoryList.add({"id": "7", "label": "Fire hazards"});
    problemCategoryList.add({"id": "8", "label": "Other"});
  }

  //----------------------------------------------------------------------------
  //Model loading function
  //----------------------------------------------------------------------------
  Future<void> loadmodel() async {
    await Tflite.loadModel(
      model: "assets/model_unquant.tflite",
      labels: "assets/labels.txt",
    );
  }

  //----------------------------------------------------------------------------
  // Image picking and detection functions
  //----------------------------------------------------------------------------
  //Taking image from gallery
  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
        file = File(image!.path);
      });
      detectimage(file!);
    } catch (e) {
      if (kDebugMode) {
        print('Error picking image: $e');
      }
    }
  }

  //Taking an image using device camera
  Future<void> _takePicture() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      setState(() {
        _image = image;
        file = File(image!.path);
      });
      detectimage(file!);
    } catch (e) {
      if (kDebugMode) {
        print('Error taking picture: $e');
      }
    }
  }

  //Image recognition logic
  Future detectimage(File image) async {
    int startTime = DateTime.now().millisecondsSinceEpoch;
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _recognitions = recognitions;
      v = recognitions.toString();
      // dataList = List<Map<String, dynamic>>.from(jsonDecode(v));
    });
    if (kDebugMode) {
      print(
          "///////////////////////////////////////////////////////////////////");
    }
    if (kDebugMode) {
      print(_recognitions);
    }
    // print(dataList);
    if (kDebugMode) {
      print(
          "///////////////////////////////////////////////////////////////////");
    }
    int endTime = DateTime.now().millisecondsSinceEpoch;
    if (kDebugMode) {
      print("Inference took ${endTime - startTime}ms");
    }
  }

  //----------------------------------------------------------------------------
  //Build method
  //----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 224, 224),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text('Report a Problem'),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
      //Page Body
      body: Container(
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
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
                        labelText: 'Problem Category',
                        contentPadding: EdgeInsets.zero,
                      ),
                      value: problemCategory,
                      onChanged: (value) {
                        setState(() {
                          problemCategory = value;
                        });
                      },
                      items: problemCategoryList
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
                        labelText: 'Problem Description',
                        contentPadding: EdgeInsets.zero,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter problem description';
                        }
                        return null;
                      },
                      onSaved: (value) => problemDescription = value,
                      controller: problemDescriptionController,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  const Center(
                      child: Text(
                    'Upload or take an image',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: _pickImage,
                        icon: const Icon(
                          Icons.photo_library,
                          color: Color.fromARGB(223, 70, 224, 31),
                          size: 50,
                        ),
                        tooltip: 'Pick Image from Gallery',
                      ),
                      IconButton(
                        onPressed: _takePicture,
                        icon: const Icon(
                          Icons.camera_alt,
                          size: 50,
                        ),
                        tooltip: 'Take Camera Image',
                      ),
                    ],
                  ),
                  //--------------------------------------------------------------
                  if (_image != null)
                    Center(
                      child: Image.file(
                        File(_image!.path),
                        height: 180,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    )
                  else
                    const Center(
                        child: Text(
                      'No image selected',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                    )),
                  const SizedBox(height: 3),
                  Text(v),
                  const SizedBox(height: 3),
                  //--------------------------------------------------------------
                  //Submit button
                  //--------------------------------------------------------------
                  Center(
                    child: SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          String id = randomAlphaNumeric(6);

                          Map<String, dynamic> problemInfoMap = {
                            'Id': id,
                            'Problem Category': problemCategory!,
                            'Location': locationController.text,
                            'Problem Description':
                                problemDescriptionController.text,
                          };

                          await ReportProblems()
                              .addProblemDetails(problemInfoMap, id)
                              .then((value) {
                            String toastMsg =
                                "Your problem (ID: $id) has been reported successfully";
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
      ),
    );
  }
}
