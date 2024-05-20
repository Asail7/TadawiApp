import 'package:cloud_firestore/cloud_firestore.dart'; //database
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'package:google_fonts/google_fonts.dart';
import 'package:ta/screens/doctor/login_doctor.dart';
import 'package:ta/widgets/my_bottun.dart';
import 'package:page_transition/page_transition.dart';

class RegistrationDoctor extends StatefulWidget {
  static const String sr = 'registration_doctor';
  const RegistrationDoctor({Key? key});

  @override
  State<RegistrationDoctor> createState() => _RegistrationDoctorState();
}

class _RegistrationDoctorState extends State<RegistrationDoctor> {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Initialize Firebase Auth

  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  Future<void> _register() async {
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    // Validate email format
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      setState(() {
        _errorMessage = 'الرجاء إدخال بريد إلكتروني صحيح';
      });
      return;
    }

    // Validate password length
    if (password.length < 6) {
      setState(() {
        _errorMessage = 'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل';
      });
      return;
    }

    // Validate password complexity (at least one uppercase, lowercase, digit, and special character)
    if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{8,}$')
        .hasMatch(password)) {
      setState(() {
        _errorMessage =
            'كلمة المرور يجب أن تحتوي على حرف كبير وحرف صغير ورقم وحرف خاص';
      });
      return;
    }

    try {
      // Create user with email and password auth
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

// Retrieve the user's UID
      String userId = userCredential.user!.uid;

      await addUserDetails(
        _firstNameController.text.trim(),
        _lastNameController.text.trim(),
        _emailController.text.trim(),
        'doctor',
        userId,
      );

      // Navigate to LoginScreen after successful registration
      Navigator.pushReplacement(
        context,
        PageTransition(
          child: LoginDoctor(),
          type: PageTransitionType.rightToLeft,
        ),
      );
    } catch (e) {
      // Handle sign-up errors
      print('Sign-up error: $e');
      // Show error message to the user
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'الايميل او كلمة السر خاطئة حاول مرة اخرى ',
          style: GoogleFonts.ibmPlexSansArabic(color: Colors.red),
        ),
      ));
    }
  }

  Future addUserDetails(String firstName, String lastName, String email,
      String userType, String userId) async {
    String collectionName = userType == 'doctor' ? 'doctors' : 'patients';
    // Use the user's UID as the document ID
    await FirebaseFirestore.instance
        .collection(collectionName)
        .doc(userId)
        .set({
      'first name': firstName,
      'last name': lastName,
      'email': email,
      'userType': userType,
    });
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
                Navigator.pushNamed(context, LoginDoctor.sr);
              },
            ),
            Container(
              height: 200,
              child: Image.asset('images/TaSignUp.png'),
            ),
            SizedBox(
              height: 50,
            ),
            TextField(
              controller: _firstNameController,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person),
                hintText: 'الاسم الاول',
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: _lastNameController,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person),
                hintText: 'الاسم الاخير',
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: _emailController,
              textAlign: TextAlign.right,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email),
                hintText: 'البريد الالكتروني',
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: _passwordController,
              textAlign: TextAlign.right,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                hintText: 'كلمة المرور',
              ),
            ),
            if (_errorMessage != null) ...[
              SizedBox(height: 10),
              Text(
                _errorMessage!,
                style: GoogleFonts.ibmPlexSansArabic(color: Colors.red),
              ),
            ],
            SizedBox(
              height: 10,
            ),
            MyBottun(
              color: Colors.black,
              title: 'تسجيل جديد',
              onPressed: _register,
            )
          ],
        ),
      ),
    );
  }
}
