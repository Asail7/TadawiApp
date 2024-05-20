import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ta/screens/clinics/earclinic.dart';
import 'package:ta/screens/clinics/eyeclinic.dart';
import 'package:ta/screens/clinics/heartclinic1.dart';
import 'package:ta/screens/clinics/teethclinic1.dart';
import 'package:ta/screens/doctor/drawer.dart';
import 'package:ta/screens/patient/phome.dart';
import 'package:ta/screens/recep/rprofile.dart';
import 'package:ta/screens/welcome.dart';

class RHomeScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<String> imageList = [
    'images/carousel_images/5.jpg',
    'images/carousel_images/6.jpg',
    'images/carousel_images/7.jpg',
  ];

  String _clinicName = '';
  String _doctorName = '';
  String _context = '';

  Widget imageCarousel() {
    return CarouselSlider(
      items: imageList.map((imgPath) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(imgPath),
                  fit: BoxFit.fitWidth,
                ),
              ),
            );
          },
        );
      }).toList(),
      options: CarouselOptions(
        height: 180.0,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: Duration(milliseconds: 800),
      ),
    );
  }

  // Method to add a new clinic
  Future<void> addClinic(BuildContext context) async {
    try {
      // Add clinic data to Firestore
      await _firestore.collection('recepclinic').add({
        'clinicName': _clinicName,
        'doctorName': _doctorName,
        'context': _context,
      });

      // After adding clinic, navigate to the patient home screen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PHomeScreen()), // Replace with the actual patient home screen
      );
    } catch (e) {
      print('Error adding clinic: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerRight,
          child: Text(
            'تداوي | الصفحة الرئيسية',
            style: GoogleFonts.ibmPlexSansArabic(
              fontSize: 25,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ),
      drawer: MyDrawer(
        onProfileTap: () {
          //pop menu drawer
          Navigator.pop(context);
          //go to profile page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RProfilePage(),
            ),
          );
        },
        onSignOut: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => welcome()),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.grey,
                    child: Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FutureBuilder<String>(
                        future: _getUserFirstName(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            return Text(
                              "اهلا بك  ${snapshot.data}",
                              style: GoogleFonts.ibmPlexSansArabic(
                                fontSize: 28,
                                fontWeight: FontWeight.w700,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextField(
                textAlign: TextAlign.right,
                onChanged: (value) {},
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'بحث',
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "عروضنا",
                style: GoogleFonts.ibmPlexSansArabic(
                  fontSize: 25,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.right,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Divider(
                height: 16,
                color: Colors.grey,
              ),
            ),

            imageCarousel(),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'اسم العيادة'),
                    onChanged: (value) {
                      // Store the clinic name
                      _clinicName = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'اسم الطبيب'),
                    onChanged: (value) {
                      // Store the doctor name
                      _doctorName = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'السياقة'),
                    onChanged: (value) {
                      // Store the context about the clinic
                      _context = value;
                    },
                  ),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      // Add the clinic when the button is pressed
                      addClinic(context);
                    },
                    child: Text('إضافة العيادة'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _getUserFirstName() async {
    String firstName = '';
    String uid = FirebaseAuth.instance.currentUser!.uid;

    try {
      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('recep').doc(uid).get();

      if (userSnapshot.exists) {
        // Explicitly cast data() to Map<String, dynamic>
        Map<String, dynamic>? userData =
            userSnapshot.data() as Map<String, dynamic>?;

        // Check if the field exists before accessing it
        if (userData != null && userData.containsKey('first name')) {
          firstName = userData['first name'] as String;
        } else {
          print('Field "first name" does not exist in the document.');
        }
      } else {
        print('Document does not exist.');
      }
    } catch (e) {
      print('Error retrieving user data: $e');
    }

    return firstName;
  }
}
