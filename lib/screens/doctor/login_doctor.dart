import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta/screens/doctor/dnavbar.dart';
import 'package:ta/screens/doctor/registeration_doctor.dart';
import 'package:ta/screens/welcome.dart';
//import 'package:ta/screens/patient/phome.dart';
import 'package:ta/widgets/my_bottun.dart';
import 'package:page_transition/page_transition.dart';

class LoginDoctor extends StatefulWidget {
  static const String sr = 'login_doctor';

  const LoginDoctor({Key? key}) : super(key: key);

  @override
  State<LoginDoctor> createState() => _LoginDoctorState();
}

class _LoginDoctorState extends State<LoginDoctor> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  Future<void> _login() async {
    try {
      // Sign in with email and password using Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Get the logged-in user
      User? user = userCredential.user;
      print("User UID: ${user?.uid}");
      // Check if the logged-in user exists and has the correct user type
      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection('doctors')
                .doc(user.uid)
                .get();
        print("Snapshot Data: ${snapshot.data()}"); // Print snapshot data
        if (snapshot.exists) {
          var userType = (snapshot.data()
              as Map<String, dynamic>)['userType']; // Access userType directly

          String? firstName = snapshot.data()?['first name'];

          print("User Type: $userType"); // Print userType for debugging
          if (userType == 'doctor') {
            // Navigate to the doctor's home screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DNavBarRoots(firstName: firstName ?? ''),
              ),
            );
          } else {
            // Display error message for incorrect account type
            setState(() {
              _errorMessage = 'لا يوجد حساب طبيب بهذا البريد الإلكتروني';
            });
          }
        } else {
          // Handle case where the document doesn't exist
          setState(() {
            _errorMessage = 'Document does not exist for this user';
          });
        }
      }
    } catch (e) {
      // Handle sign-in errors
      print('Sign-in error: $e');
      setState(() {
        // Display error message for invalid email or password
        _errorMessage = 'الايميل او كلمة السر خاطئة حاول مرة اخرى';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            IconButton(
              iconSize: 28,
              alignment: Alignment.topLeft,
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pushNamed(context, welcome.sr);
              },
            ),
            Container(
              height: 200,
              child: Image.asset('images/TaLogin.png'),
            ),
            SizedBox(height: 50),
            TextField(
              controller: _emailController,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email),
                hintText: 'أدخل بريدك الالكتروني',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _passwordController,
              textAlign: TextAlign.right,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                hintText: 'أدخل كلمة المرور',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            if (_errorMessage != null) ...[
              SizedBox(height: 10),
              Text(
                _errorMessage!,
                style: GoogleFonts.ibmPlexSansArabic(color: Colors.red),
              ),
            ],
            SizedBox(height: 10),
            MyBottun(
              color: Colors.black,
              title: 'تسجيل الدخول',
              onPressed: _login,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationDoctor()),
                );
              },
              child: Text(
                ' ما عندك حساب من قبل ؟ أنشىء حساب جديد',
                style: GoogleFonts.ibmPlexSansArabic(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
