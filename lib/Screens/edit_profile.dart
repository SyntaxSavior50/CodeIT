import 'dart:io';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:intl/intl.dart';
import 'package:realpalooza/Screens/base_screen.dart';
import 'package:realpalooza/constant/icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shimmer/shimmer.dart';

class EditProfille extends StatefulWidget {
  const EditProfille({Key? key}) : super(key: key);

  @override
  State<EditProfille> createState() => _EditProfilleState();
}

class _EditProfilleState extends State<EditProfille> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final UserNameController = TextEditingController();
  final instituteController = TextEditingController();

  String imageUrl = '';
  String previousimg = '';
  String previousName = '';
  String previousInstitute = '';
  String previousGender = '';
  DateTime previousDate = DateTime.now();
  bool isUploading = false;
  FocusNode myFocusNode = FocusNode();
  DateTime selectedDate = DateTime.now();
  String selectedGender = 'Male';

  String formatTimestampToDDMMYY(Timestamp timestamp) {
    DateTime dateTime = timestamp.toDate();
    String day = dateTime.day.toString().padLeft(2, '0');
    String month = dateTime.month.toString().padLeft(2, '0');
    String year = dateTime.year.toString().substring(2);
    if(year=='88')return 'DD-MM-YY';
    return '$day-$month-$year';
  }
  DateTime convertTimestampToDateTime(Timestamp timestamp) {
    return timestamp.toDate();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      try {
        await FirebaseFirestore.instance.collection("Users").doc(currentUser.email).set({
          'dp': imageUrl == '' ? previousimg : imageUrl,
          'username': UserNameController.text == '' ? previousName : UserNameController.text,
          'dateOfBirth': selectedDate,
          'institute': instituteController.text == '' ? previousInstitute : instituteController.text,
          'Email': currentUser.email,
          'gender': selectedGender,
        });
      } catch (error) {
        print(error);
      }
    }
  }

  Future submitFile() async {
    try {
      FirebaseFirestore.instance.collection("Users").doc(currentUser.email).set({
        'dp': imageUrl==''?previousimg:imageUrl,
        'username': UserNameController.text == ''
            ? previousName
            : UserNameController.text,
        'dateOfBirth': selectedDate,
        'institute': instituteController.text == ''
            ? previousInstitute
            : instituteController.text,
        'Email': currentUser.email,
        'gender':selectedGender,
      });
    } catch (error) {
      print(error);
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const BaseScreen(selectedIndex: 0);
        },
      ),
    );
  }

  Future ByCamera() async {
    Navigator.pop(context);
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);

    if (file == null) return;

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');

    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    setState(() {
      isUploading = true;
    });

    try {
      await referenceImageToUpload.putFile(File(file.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
      setState(() {
        isUploading = false;
      });

      // Update Firestore collection immediately
      await FirebaseFirestore.instance.collection("Users").doc(currentUser.email).set({
        'dp': imageUrl,
        'username': UserNameController.text == '' ? previousName : UserNameController.text,
        'dateOfBirth': selectedDate,
        'institute': instituteController.text == '' ? previousInstitute : instituteController.text,
        'Email': currentUser.email,
        'gender':selectedGender
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        isUploading = false;
      });
    }
  }

  Future ByGallery() async {
    Navigator.pop(context);
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);

    if (file == null) return;

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');

    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    setState(() {
      isUploading = true;
    });

    try {
      await referenceImageToUpload.putFile(File(file.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
      setState(() {
        isUploading = false;
      });

      // Update Firestore collection immediately
      await FirebaseFirestore.instance.collection("Users").doc(currentUser.email).set({
        'dp': imageUrl,
        'username': UserNameController.text == '' ? previousName : UserNameController.text,
        'dateOfBirth': selectedDate,
        'institute': instituteController.text == '' ? previousInstitute : instituteController.text,
        'Email': currentUser.email,
        'gender':selectedGender
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        isUploading = false;
      });
    }
  }

  Future AltCamera() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.background,
          title: BounceInDown(
            child: Center(
              child: Text(
                'Choose your Options',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 16,
                  fontFamily: 'Comfortaa',
                ),
              ),
            ),
          ),
          content: Row(
            children: [
              const SizedBox(width: 40,),
              BounceInLeft(
                child: IconButton(
                  onPressed: () {
                    ByCamera();
                  },
                  icon: Icon(Icons.camera_alt),
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.white.withOpacity(.8)
                      : Colors.grey[800],
                  iconSize: 50,
                ),
              ),
              const SizedBox(width: 30,),
              BounceInLeft(
                child: GestureDetector(
                  onTap: ByGallery,
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        image: AssetImage(
                          Theme.of(context).brightness == Brightness.dark
                              ? gallery2
                              : gallery,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30,),
            ],
          ),
        );
      },
    );
  }

  void dispose() {
    UserNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Edit Profile',
          style: TextStyle(
            fontFamily: 'Comfortaa',
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return BaseScreen(selectedIndex: 0);
                },
              ),(route)=>false,
            );
          },
          icon: Icon(Icons.navigate_before_rounded, size: 30,),
        ),
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection("Users").doc(currentUser.email).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Map<String, dynamic> userData = <String, dynamic>{};
            if (snapshot.data!.data() != null) {
              userData = snapshot.data!.data() as Map<String, dynamic>;
              previousimg = userData['dp'];
              previousName = userData['username'];
              previousInstitute = userData['institute'];
              previousDate = convertTimestampToDateTime(userData['dateOfBirth']);
              selectedGender = userData['gender'];
            } else {
              userData['username'] = currentUser.email?.split('@')[0];
              userData['dp'] = 'https://i.postimg.cc/CL3mxvsB/emptyprofile.jpg';
              previousimg = userData['dp'];
              previousName = userData['username'];
              previousInstitute = userData['institute'];
              previousDate = convertTimestampToDateTime(userData['dateOfBirth']);
              selectedGender = userData['gender'];
            }
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 20, 20),
                    child: Row(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.pinkAccent, width: 3),
                              ),
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: NetworkImage(userData['dp']),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 0,
                                    color: Colors.redAccent,
                                  ),
                                  color: Colors.pinkAccent,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    AltCamera();
                                  },
                                  icon: Icon(FontAwesome5.camera, size: 20, color: Colors.white,),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 30,),
                        Text(
                          userData['username']==Null?' ':userData['username'],
                          style: TextStyle(
                            color: Colors.pinkAccent,
                            fontFamily: 'Comfortaa',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Text(
                          'User Name',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Comfortaa',
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Icon(
                          Icons.edit,
                          size: 24,
                          color: Colors.pinkAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: UserNameController,
                      decoration: InputDecoration(
                        hintText: userData['username']==Null?' ':userData['username'],
                        hintStyle: TextStyle(
                          color: Colors.grey
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Text(
                          'Institute Name',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Comfortaa',
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Icon(
                          Icons.edit,
                          size: 24,
                          color: Colors.pinkAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: instituteController,
                      decoration: InputDecoration(
                        hintText: userData['institute']==Null?' ':userData['institute'],
                        hintStyle: TextStyle(
                          color: Colors.grey
                        ),
                        fillColor: Colors.grey[200],
                        filled: true,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Text(
                          'Date of birth',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Comfortaa',
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Icon(
                          Icons.edit,
                          size: 24,
                          color: Colors.pinkAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  GestureDetector(
                    onTap: (){
                      _selectDate(context);
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 12, 0, 5),
                        child: Text(
                            formatTimestampToDDMMYY(userData['dateOfBirth'])
                            ,style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                        )
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25),
                        child: Text(
                          'Gender',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Comfortaa',
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Icon(
                          Icons.edit,
                          size: 24,
                          color: Colors.pinkAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Row(
                          children: [
                            Radio(
                              value: 'Male',
                              groupValue: selectedGender,
                              onChanged: (value) async {
                                setState(() {
                                  selectedGender = value.toString();
                                });
                                try {
                                  await FirebaseFirestore.instance.collection("Users").doc(currentUser.email).set({
                                    'dp': imageUrl == '' ? previousimg : imageUrl,
                                    'username': UserNameController.text == '' ? previousName : UserNameController.text,
                                    'dateOfBirth': userData['dateOfBirth'],
                                    'institute': instituteController.text == '' ? previousInstitute : instituteController.text,
                                    'Email': currentUser.email,
                                    'gender': selectedGender,
                                  });
                                } catch (error) {
                                  print(error);
                                }
                              },
                              activeColor: Colors.pinkAccent,
                            ),
                            Text('Male'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Row(
                          children: [
                            Radio(
                              value: 'Female',
                              groupValue: selectedGender,
                              onChanged: (value) async {
                                setState(()  {
                                  selectedGender = value.toString();
                                });
                                try {
                                  await FirebaseFirestore.instance.collection("Users").doc(currentUser.email).set({
                                    'dp': imageUrl == '' ? previousimg : imageUrl,
                                    'username': UserNameController.text == '' ? previousName : UserNameController.text,
                                    'institute': instituteController.text == '' ? previousInstitute : instituteController.text,
                                    'Email': currentUser.email,
                                    'gender': selectedGender,
                                    'dateOfBirth': userData['dateOfBirth'],

                                  });
                                } catch (error) {
                                  print(error);
                                }
                              },
                              activeColor: Colors.pinkAccent,
                            ),
                            Text('Female'),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: Row(
                          children: [
                            Radio(
                              value: 'Other',
                              groupValue: selectedGender,
                              onChanged: (value) async {
                                setState(()  {
                                  selectedGender = value.toString();
                                });
                                try {
                                  await FirebaseFirestore.instance.collection("Users").doc(currentUser.email).set({
                                    'dp': imageUrl == '' ? previousimg : imageUrl,
                                    'username': UserNameController.text == '' ? previousName : UserNameController.text,
                                    'institute': instituteController.text == '' ? previousInstitute : instituteController.text,
                                    'Email': currentUser.email,
                                    'gender': selectedGender,
                                    'dateOfBirth': userData['dateOfBirth'],
                                  });
                                } catch (error) {
                                  print(error);
                                }
                              },
                              activeColor: Colors.pinkAccent,
                            ),
                            Text('Other'),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20,),
                  Container(
                    height: 40,
                    width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        textStyle: TextStyle(fontSize: 24),
                        minimumSize: Size.fromHeight(50),
                        shape: StadiumBorder(),
                        backgroundColor: Colors.blueAccent
                      ),
                        onPressed: (){
                        submitFile();
                        },
                        child: isUploading
                            ?CircularProgressIndicator(color: Colors.white,strokeWidth: 2,)
                            :Text(
                            'Submit',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Comfortaa'
                            ),
                        )
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            //debug
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}