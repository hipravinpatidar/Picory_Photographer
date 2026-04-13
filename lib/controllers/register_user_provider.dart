import 'package:flutter/cupertino.dart';
import 'package:picory_app/service/https_service.dart';
import 'package:picory_app/utils/api_constants.dart';
import '../model/login_user_model.dart';
import '../model/register_user_model.dart';

class RegisterUserProvider with ChangeNotifier{
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  RegisterUserModel? _registerUserModel;
  RegisterUserModel? get registerUserModel => _registerUserModel;

  Future<void> registerUser(String phone, String email, String name, String businessName) async {
    setLoading(true);

    print("Register Method Open");

    Map<String,dynamic> body = {
      "name": name,
      "business_name": businessName,
      "email": email,
      "phone": phone
    };

    print("Body Request: $body");

    try{
      final res = await HttpService().post(ApiConstants.register, body: body);
      if(res != null ){
        _registerUserModel = RegisterUserModel.fromJson(res);
        setLoading(false);
      }
    } catch(e){
      print("Error in Login API $e");
      setLoading(false);
    }
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

}

