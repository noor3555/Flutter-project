import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'manager_home_page.dart';
import 'teacher_home_page.dart';
import 'student_home_page.dart';
import 'role_selection_screen.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data != null) {
            final userEmail = snapshot.data!.email ?? '';

            // تحديد نوع المستخدم بناءً على البريد الإلكتروني (مثال فقط)
            if (userEmail == 'noor@gmail.com') {
              // المدير
              return ManagerHomePage();
            } else if (userEmail.endsWith('@teacher.com')) {
              // المعلم (مثال: إيميلات المعلمين تنتهي بـ @teacher.com)
              return TeacherHomePage();
            } else {
              // الطالب (كل الباقي)
              return StudentHomePage();
            }
          } else {
            return RoleSelectionScreen();
          }
        },
      ),
    );
  }
}
