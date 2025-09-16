import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../map/presentation/screens/map_screen.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Enter the 6-digit OTP sent to your phone"),
            TextField(controller: otpController, keyboardType: TextInputType.number),
            ElevatedButton(
              onPressed: () async {
                String smsCode = otpController.text.trim();
                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                  verificationId: widget.verificationId,
                  smsCode: smsCode,
                );

                try {
                  if (FirebaseAuth.instance.currentUser != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const MapScreen()),
                    );
                  }

                  print("✅ Signed in!");
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Invalid OTP, please try again.")),
                  );
                  print("❌ Error: $e");
                }
              },
              child: const Text("Verify"),
            ),
          ],
        ),
      ),
    );
  }
}
