// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class AuthenticateProvider with ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   String _verificationId = "";
//   bool _isLoading = false;
//
//   bool get isLoading => _isLoading;
//
//   void _setLoading(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }
//
//   // Send OTP
//   Future<void> sendOTP({
//     required String phoneNumber,
//     required BuildContext context,
//     void Function()? onCodeSent,
//   }) async {
//     _setLoading(true);
//
//     // Ensure E.164 format
//     final formattedPhone = "+${phoneNumber.replaceAll(RegExp(r'\D'), '')}";
//     print("Sending OTP to $formattedPhone");
//
//     try {
//       await _auth.verifyPhoneNumber(
//         phoneNumber: formattedPhone,
//         timeout: const Duration(seconds: 60),
//         verificationCompleted: (PhoneAuthCredential credential) async {
//           await _auth.signInWithCredential(credential);
//           print("Phone number automatically verified ✅");
//         },
//         verificationFailed: (FirebaseAuthException e) {
//           print("Verification failed: ${e.message}");
//           if (context.mounted) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text("Verification failed: ${e.message}")),
//             );
//           }
//         },
//         codeSent: (String verId, int? resendToken) {
//           _verificationId = verId;
//           print("OTP sent successfully ✅");
//           if (onCodeSent != null) onCodeSent();
//         },
//         codeAutoRetrievalTimeout: (String verId) {
//           _verificationId = verId;
//         },
//       );
//     } catch (e) {
//       print("Error sending OTP: $e");
//       if (context.mounted) {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text("Error sending OTP: $e")));
//       }
//     } finally {
//       _setLoading(false);
//     }
//   }
//
//   // Verify OTP
//   Future<bool> verifyOTP({
//     required String otp,
//     required BuildContext context,
//   }) async {
//     _setLoading(true);
//     try {
//       PhoneAuthCredential credential = PhoneAuthProvider.credential(
//         verificationId: _verificationId,
//         smsCode: otp,
//       );
//
//       await _auth.signInWithCredential(credential);
//       print("OTP verified successfully ✅");
//       return true;
//     } on FirebaseAuthException catch (e) {
//       print("OTP verification failed: ${e.message}");
//       if (context.mounted) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Invalid OTP")),
//         );
//       }
//       return false;
//     } finally {
//       _setLoading(false);
//     }
//   }
//
//   Future<void> signOut() async {
//     await _auth.signOut();
//     print("User signed out ✅");
//   }
//
//   User? get currentUser => _auth.currentUser;
// }