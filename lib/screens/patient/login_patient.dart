import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ta/screens/patient/phome.dart';
import 'package:ta/screens/patient/pnavbar.dart';
import 'package:ta/screens/patient/registeration_patient.dart';
import 'package:ta/screens/welcome.dart';
import 'package:ta/widgets/my_bottun.dart';

class LoginPatient extends StatefulWidget {
  static const String sr = 'login_patient';

  const LoginPatient({Key? key}) : super(key: key);

  @override
  State<LoginPatient> createState() => _LoginPatientState();
}

class _LoginPatientState extends State<LoginPatient> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  void _login(BuildContext context) async {
    try {
      // Sign in with email and password using Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text
            .trim(), // Trim email to remove leading/trailing spaces
        password: _passwordController.text,
      );

      // Get the logged-in user
      User? user = userCredential.user;

      // Check if the user exists in the patient collection
      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await FirebaseFirestore.instance
                .collection('patient')
                .doc(user.uid)
                .get();
        if (snapshot.exists) {
          var userType = (snapshot.data() as Map<String, dynamic>)['userType'];
          // Get the first name from the snapshot
          String? firstName = snapshot.data()?['first name'];

          print("User Type: $userType"); // Print userType for debugging
          if (userType == 'patient') {
            // Navigate to the patient's home screen with the obtained first name
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => PNavBarRoots(
                  firstName: firstName ?? '',
                  clinicName: '',
                  selectedTimeSlot: '',
                  doctorName: '', appointmentId: '',
                ),
              ),
            );
          } else {
            // Display error message for incorrect account type
            setState(() {
              _errorMessage = 'البريد الإلكتروني غير مسجل كحساب مريض';
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
        _errorMessage = 'البريد الإلكتروني أو كلمة المرور غير صحيحة';
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
                hintText: 'أدخل بريدك الإلكتروني',
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
              onPressed: () {
                // Call _login function when login button is pressed
                _login(context);
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegistrationPatient()),
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
