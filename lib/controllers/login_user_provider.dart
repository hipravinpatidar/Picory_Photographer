import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:picory_app/service/https_service.dart';
import 'package:picory_app/utils/api_constants.dart';
import '../model/login_user_model.dart';

class LoginController with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  LoginUserModel? _loginUserModel;
  LoginUserModel? get loginUserModel => _loginUserModel;

  String? _verificationId;
  String? _phoneNumber;
  String? _userToken;
  bool _isLoading = false;
  bool _isLoggedIn = false;

  bool get isLoading => _isLoading;
  bool get isLoggedIn => _isLoggedIn;
  String? get userToken => _userToken;
  String? get phoneNumber => _phoneNumber;

  LoginController() {
    _checkPersistentLogin();
  }

  /// ==========================
  /// Check persistent login
  /// ==========================
  Future<void> _checkPersistentLogin() async {
    try {
      String? token = await _storage.read(key: 'user_token');
      String? phone = await _storage.read(key: 'user_phone');

      if (token != null && phone != null) {
        _userToken = token;
        _phoneNumber = phone;
        _isLoggedIn = true;

        // Rebuild loginUserModel with minimal info (optional)
        _loginUserModel = LoginUserModel(
          success: true,
          message: 'User logged in',
          data: Data(
            token: _userToken,
            vendor: null,
          ),
        );
        print('Persistent login found: $phone');
      } else {
        _isLoggedIn = false;
        print('No persistent login found');
      }
      notifyListeners();
    } catch (e) {
      print('Error checking persistent login: $e');
      _isLoggedIn = false;
    }
  }

  /// ==========================
  /// Save login data securely
  /// ==========================
  Future<void> _saveLoginData(LoginUserModel model) async {
    try {
      _loginUserModel = model;
      _userToken = model.data?.token;
      _phoneNumber = model.data?.vendor?.phone;
      _isLoggedIn = true;

      await _storage.write(key: 'user_token', value: _userToken);
      await _storage.write(key: 'user_phone', value: _phoneNumber);

      print('Login data saved: $_phoneNumber, token: $_userToken');
      notifyListeners();
    } catch (e) {
      print('Error saving login data: $e');
    }
  }

  /// ==========================
  /// Login via API
  /// ==========================
  Future<Map<String, dynamic>> checkUserAndSendOTP(String phone) async {
    _setLoading(true);

    print("Phone $phone");

    try {
      ///  STEP 1: API CALL (check user exists)
      final res = await HttpService().post(
        ApiConstants.login, // ya check-user API
        body: {
          "phone": phone,
        },
      );

      if (res != null) {
        final model = LoginUserModel.fromJson(res);

        print("Login Check Response:${model.success}");

        ///  USER EXISTS
        if (model.success == true) {
          print("User exists, sending OTP...");

          ///  STEP 2: Send OTP
          final otpResult = await sendOTP(phone);

          return {
            'success': otpResult['success'],
            'message': otpResult['message'],
            'registered': true,
          };
        } else {
          ///  USER NOT FOUND
          return {
            'success': false,
            'message': model.message ?? "User not registered",
            'registered': false,
          };
        }
      } else {
        return {
          'success': false,
          'message': "Server error",
          'registered': false,
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': "Error: $e",
        'registered': false,
      };
    } finally {
      _setLoading(false);
    }
  }

  /// ==========================
  /// Send OTP (Firebase)
  /// ==========================
  Future<Map<String, dynamic>> sendOTP(String phone) async {
    _setLoading(true);
    Completer<Map<String, dynamic>> completer = Completer();

    final formattedPhone = phone.startsWith('+') ? phone : '+91$phone';
    _phoneNumber = phone;

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: formattedPhone,
        timeout: const Duration(seconds: 120),
        verificationCompleted: (PhoneAuthCredential credential) async {
          await _auth.signInWithCredential(credential);
          print("Phone number automatically verified ✅");
          if (!completer.isCompleted) {
            completer.complete({'success': true, 'message': 'Auto verified'});
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          print("Verification failed: ${e.message}");
          if (!completer.isCompleted) {
            completer.complete({'success': false, 'message': e.message ?? 'Verification failed'});
          }
        },
        codeSent: (String verId, int? resendToken) {
          _verificationId = verId;
          print("OTP sent successfully ✅");
          if (!completer.isCompleted) {
            completer.complete({'success': true, 'message': 'OTP sent'});
          }
        },
        codeAutoRetrievalTimeout: (String verId) {
          _verificationId = verId;
        },
      );
    } catch (e) {
      if (!completer.isCompleted) {
        completer.complete({'success': false, 'message': 'Error sending OTP: $e'});
      }
    } finally {
      _setLoading(false);
    }

    return await completer.future;
  }

  /// ==========================
  /// Verify OTP (Firebase)
  /// ==========================
  Future<bool> verifyOTP(String otp) async {
    if (_verificationId == null) return false;

    _setLoading(true);
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otp,
      );

      await _auth.signInWithCredential(credential);
      print("OTP verified successfully ✅");

      /// 🔥 IMPORTANT: API LOGIN CALL
      final res = await HttpService().post(
        ApiConstants.login,
        body: {
          "phone": _phoneNumber,
          "otp": otp,
        },
      );

      if (res != null) {
        _loginUserModel = LoginUserModel.fromJson(res);

        if (_loginUserModel?.success == true) {
          await _saveLoginData(_loginUserModel!); // ✅ SAVE HERE
          _isLoggedIn = true;
          notifyListeners();
          return true;
        }
      }

      return false;

    } catch (e) {
      print("OTP verification failed: $e");
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// ==========================
  /// Logout
  /// ==========================
  Future<void> logout() async {
    try {
      await _auth.signOut();
      await _storage.delete(key: 'user_token');
      await _storage.delete(key: 'user_phone');

      _loginUserModel = null;
      _userToken = null;
      _phoneNumber = null;
      _isLoggedIn = false;

      notifyListeners();
      print("User logged out successfully");
    } catch (e) {
      print("Error during logout: $e");
    }
  }

  /// ==========================
  /// Helper to set loading
  /// ==========================
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}