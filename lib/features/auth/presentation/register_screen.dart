import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../core/shared/custom_field.dart';
import 'otp_screen.dart';

class PhoneLoginScreen extends StatelessWidget {
   PhoneLoginScreen({super.key});
  String phone = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF000000), Color(0xFF444444)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),

                // App Icon
                const Icon(Icons.local_taxi, size: 80, color: Colors.yellow),

                const SizedBox(height: 16),
                const Text(
                  'Welcome to YallaGo',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Sign in with your phone number',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 32),

                // Phone number form
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      CustomField(
                        onChanged: (value){
                          phone = value;
                        } ,
                        label: 'Phone Number',
                        hint: '+963 9XXXXXXXX',
                        textInputType: TextInputType.phone,
                      ),
                      const SizedBox(height: 24),

                      // Continue button
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow[700],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: () async{
                            FirebaseAuth auth = FirebaseAuth.instance;

                            await auth.verifyPhoneNumber(
                              phoneNumber: phone, // test number
                              verificationCompleted: (PhoneAuthCredential credential) async {
                                // Auto-sign in for emulator
                                await auth.signInWithCredential(credential);
                                print("✅ User signed in automatically");
                              },
                              verificationFailed: (FirebaseAuthException e) {
                                print("❌ Verification failed: ${e.message}");
                              },
                              codeSent: (String verificationId, int? resendToken) async {
                                print("📩 Code sent. Enter the OTP manually.");
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => OtpScreen(verificationId: verificationId),
                                  ),
                                );
                              },
                              codeAutoRetrievalTimeout: (String verificationId) {
                                print("⌛ Timeout: $verificationId");
                              },
                            );
                          },
                          child: const Text(
                            'Continue',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'You’ll receive a 6-digit code via SMS.',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
