import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ta/screens/clinics/heartclinic1.dart';
import 'package:ta/screens/doctor/dhome.dart';
import 'package:ta/screens/doctor/dnavbar.dart';
import 'package:ta/screens/doctor/login_doctor.dart';
import 'package:ta/screens/doctor/registeration_doctor.dart';
import 'package:ta/screens/onboarding.dart/oscreen.dart';
import 'package:ta/screens/patient/login_patient.dart';
import 'package:ta/screens/patient/pcommunication.dart';
import 'package:ta/screens/patient/pnavbar.dart';
import 'package:ta/screens/patient/pprofile.dart';
import 'package:ta/screens/patient/registeration_patient.dart';
import 'package:ta/screens/patient/schedule_screen.dart';
import 'package:ta/screens/patient/settings_screen.dart';
import 'package:ta/screens/recep/login_recep.dart';
import 'package:ta/screens/recep/registeration_recep.dart';
import 'package:ta/screens/welcome.dart';
import 'package:ta/screens/patient/phome.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
      apiKey: "AIzaSyCLd0ToRML6-hAYemc5GR3ZeZ2XTIY7fgw",
      appId: "1:219560811919:web:df6914303c25ec569abffa",
      messagingSenderId: "219560811919",
      projectId: "tadawii-fb3ce",
    ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tadawi App',
        /*home: PNavBarRoots(
        firstName: '',
        clinicName: '',
        doctorName: '',
        selectedTimeSlot: '',
      ),*/
        initialRoute: OnboardingScreen.sr,
        routes: {
          OnboardingScreen.sr: (context) => OnboardingScreen(),
          welcome.sr: (context) => welcome(),
          LoginPatient.sr: (context) => LoginPatient(),
          RegistrationPatient.sr: (context) => RegistrationPatient(),
          PNavBarRoots.sr: (context) => PNavBarRoots(
                firstName: 'firstName',
                clinicName: 'clinicName',
                doctorName: 'doctorName',
                selectedTimeSlot: 'selectedTimeSlot',
                appointmentId: 'appointmentId',
              ),
          PHomeScreen.sr: (context) => PHomeScreen(),
          heartclinic1.sr: (context) => heartclinic1(),
          LoginDoctor.sr: (context) => LoginDoctor(),
          RegistrationDoctor.sr: (context) => RegistrationDoctor(),
          DNavBarRoots.sr: (context) => DNavBarRoots(firstName: 'firstName'),
          dhome.sr: (context) => dhome(),
          LoginRecep.sr: (context) => LoginRecep(),
          RegistrationRecep.sr: (context) => RegistrationRecep(),
        }
        /*initialRoute: OnboardingScreen.sr,
      routes: {
        OnboardingScreen.sr: (context) => OnboardingScreen(),
        welcome.sr: (context) => welcome(),
        LoginPatient.sr: (context) => LoginPatient(),
        RegistrationPatient.sr: (context) => RegistrationPatient(),
        LoginDoctor.sr: (context) => LoginDoctor(),
        RegistrationDoctor.sr: (context) => RegistrationDoctor(),
        dhome.sr: (context) => dhome(),
        LoginRecep.sr: (context) => LoginRecep(),
        RegistrationRecep.sr: (context) => RegistrationRecep(),
        PNavBarRoots.sr: (context) => PNavBarRoots(
            firstName: 'firstName',
            clinicName: 'clinicName',
            doctorName: 'doctorName',
            selectedTimeSlot: 'selectedTimeSlot'),
        PHomeScreen.sr: (context) => PHomeScreen(),
        CommuPat.sr: (context) => CommuPat(),
        PProfilePage.sr: (context) => PProfilePage(),
        PScheduleScreen.sr: (context) => PScheduleScreen(
              clinicName: '',
              doctorName: '',
              selectedTimeSlot: '',
            ),
        PSettingScreen.sr: (context) => PSettingScreen(
              userId: '',
            ),
      },*/
        );
  }
}
