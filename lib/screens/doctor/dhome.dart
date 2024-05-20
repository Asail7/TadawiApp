import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ta/screens/doctor/dprofile.dart';
import 'package:ta/screens/doctor/drawer.dart';
import 'package:ta/screens/doctor/teethclinic1.dart';
import 'package:ta/screens/doctor/teethclinic2.dart';
import 'package:ta/widgets/image_list.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class dhome extends StatelessWidget {
  static const String sr = 'dhome';
  dhome({Key? key}) : super(key: key);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> _getUserFirstName() async {
    String firstName = '';
    String uid = FirebaseAuth.instance.currentUser!.uid;

    try {
      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('doctors').doc(uid).get();

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

  List<String> clinics = [
    "عيادة الأسنان 1",
    "2 عيادة الأسنان",
  ];
  List<String> imgs = [
    // "teathclinic1.jpg",
    // "teathclinic2.jpg",
    "teeth.png",
    "teeth.png",
  ];

  List<double> ratings = [
    4.9,
    4.7,
  ];

  List<String> imageList = [
    'images/carousel_images/5.jpg',
    'images/carousel_images/6.jpg',
  ];
  Widget ImageCarousel() {
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
        ));
  }

  //sign user out
  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  //navigate to profile
  /*void goToProfilePage() {
    //pop menu drawer
          Navigator.pop(context);
          //go to profile page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DProfilePage(),
            ),
          );
  }*/

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
              builder: (context) => const DProfilePage(),
            ),
          );
        },
        onSignOut: signOut,
      ),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
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
                    backgroundImage: AssetImage("images/doctor3.jpg"),
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
                              "اهلا بك د. ${snapshot.data}",
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
            ImageCarousel(),
            SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "عياداتي",
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemCount: clinics.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      // Navigate to the appropriate AppointmentScreen based on the index
                      switch (index) {
                        case 0:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TClinic1(),
                            ),
                          );
                          break;
                        case 1:
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TClinic2(),
                            ),
                          );
                          break;
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(8), // Adjusted margin value
                      padding: EdgeInsets.symmetric(
                          vertical: 10), // Adjusted padding value
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(251, 252, 252, 1),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(149, 152, 152, 1),
                            blurRadius: 4,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Image.asset(
                              "images/${imgs[index]}",
                              fit: BoxFit.fill,
                              height: 70, // Adjusted height value
                            ),
                          ),
                          Text(
                            clinics[index],
                            style: GoogleFonts.ibmPlexSansArabic(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(136, 0, 0, 0),
                            ),
                            textAlign: TextAlign.right,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              Text(
                                ratings[index].toString(),
                                style: GoogleFonts.ibmPlexSansArabic(
                                    color: Color.fromRGBO(72, 181, 132, 1),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
