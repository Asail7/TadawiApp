import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta/widgets/text_box.dart';

class RProfilePage extends StatefulWidget {
  const RProfilePage({super.key});

  @override
  State<RProfilePage> createState() => _RProfilePageState();
}

class _RProfilePageState extends State<RProfilePage> {
  //user
  final currentUser = FirebaseAuth.instance.currentUser!;
  final userCollection = FirebaseFirestore.instance.collection('recep');
  String _firstName = '';
  String _lastName = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userData = await FirebaseFirestore.instance
        .collection('recep')
        .doc(currentUser.uid)
        .get();

    if (userData.exists) {
      final data = userData.data() as Map<String, dynamic>;
      setState(() {
        _firstName = data['first name'] ?? '';
        _lastName = data['last name'] ?? '';
        _email = data['email'] ?? '';
      });
    }
  }

  //edit field
  Future<void> editField(String field) async {
    String newValue = '';
    String tempValue = ''; // المتغير المؤقت لتخزين القيمة الجديدة
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          "تعديل  $field",
          style: GoogleFonts.ibmPlexSansArabic(
            fontWeight: FontWeight.w400,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        content: TextField(
          autofocus: true,
          style: GoogleFonts.ibmPlexSansArabic(
            fontWeight: FontWeight.w400,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
          decoration: InputDecoration(
            hintText: "أدخل $field الجديد",
            hintStyle: GoogleFonts.ibmPlexSansArabic(
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
          onChanged: (value) {
            tempValue =
                value; // تحديث المتغير المؤقت عند تغيير القيمة في الحقل النصي
          },
        ),
        actions: [
          //cancel button
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'الغاء',
              style: GoogleFonts.ibmPlexSansArabic(
                fontWeight: FontWeight.w400,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
          //save button
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              if (tempValue.trim().length > 0) {
                // استخدام المتغير المؤقت بدلاً من القيمة المباشرة
                final userDoc = FirebaseFirestore.instance
                    .collection('recep')
                    .doc(currentUser.uid);

                // التحقق من صحة البريد الإلكتروني
                if (field == 'البريد الإلكتروني' && !tempValue.contains('@')) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('خطأ'),
                      content:
                          Text('يجب أن يحتوي البريد الإلكتروني على رمز "@"'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('حسنا'),
                        ),
                      ],
                    ),
                  );
                  return;
                }

                newValue = tempValue; // تحديث القيمة الجديدة من المتغير المؤقت

                // تحديث القيمة في قاعدة البيانات
                await userDoc.update({field: newValue});
                if (field == 'الاسم الأول') {
                  setState(() {
                    _firstName = newValue;
                  });
                } else if (field == 'الاسم الأخير') {
                  setState(() {
                    _lastName = newValue;
                  });
                } else if (field == 'البريد الإلكتروني') {
                  setState(() {
                    _email = newValue;
                  });
                }
              }
            },
            child: Text(
              'حفظ',
              style: GoogleFonts.ibmPlexSansArabic(
                fontWeight: FontWeight.w400,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
        ],
      ),
    );

    //update in firestore

    if (newValue.trim().length > 0) {
      await userCollection.doc(currentUser.uid).update({field: newValue});
    }
  }
  /* Future<String> _getUserFirstName() async {
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
  }*/

  /* Future<String> _getUserLastName() async {
    String lastName = '';
    String uid = FirebaseAuth.instance.currentUser!.uid;

    try {
      DocumentSnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('doctors').doc(uid).get();

      if (userSnapshot.exists) {
        // Explicitly cast data() to Map<String, dynamic>
        Map<String, dynamic>? userData =
            userSnapshot.data() as Map<String, dynamic>?;

        // Check if the field exists before accessing it
        if (userData != null && userData.containsKey('last name')) {
          lastName = userData['last name'] as String;
        } else {
          print('Field "last name" does not exist in the document.');
        }
      } else {
        print('Document does not exist.');
      }
    } catch (e) {
      print('Error retrieving user data: $e');
    }

    return lastName;
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Align(
            alignment: Alignment.centerRight,
            child: Text(
              'حسابي',
              style: GoogleFonts.ibmPlexSansArabic(
                fontSize: 25,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('recep')
              .doc(currentUser.uid)
              .snapshots(),
          builder: (context, snapshot) {
            //get doctor dsta
            if (snapshot.hasData) {
              final userData = snapshot.data!.data() as Map<String, dynamic>;
              return ListView(
                children: [
                  const SizedBox(height: 50),
                  //profile pic
                  Icon(
                    Icons.person,
                    size: 72,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //المعلومات الشخصية
                  Text(
                    ' المعلومات الشخصية',
                    style: GoogleFonts.ibmPlexSansArabic(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 50),
                  //first name
                  MyTextBox(
                    text: _firstName,
                    sectionName: 'الاسم الأول',
                    onPressed: () => editField('الاسم الأول'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //last namw
                  MyTextBox(
                    text: _lastName,
                    sectionName: 'الاسم الاخير',
                    onPressed: () => editField('الاسم الأخير'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  //Email
                  MyTextBox(
                    text: _email,
                    sectionName: 'البريد الإلكتروني',
                    onPressed: () => editField('البريد الإلكتروني'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),

                  //password
                ],
              );
            } else if (snapshot.hasData) {
              return Center(
                child: Text('Error${snapshot.error}'),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }
}
