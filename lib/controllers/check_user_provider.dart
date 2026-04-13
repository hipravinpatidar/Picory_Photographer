import 'package:flutter/cupertino.dart';
import '../model/check_user_model.dart';
import '../service/https_service.dart';
import '../utils/api_constants.dart';

class CheckUserProvider with ChangeNotifier {
  CheckUserModel? _checkUserModel;
  CheckUserModel? get checkUserModel => _checkUserModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> checkUser(String phone) async {
    setLoading(true);

    print("Phone Number Is $phone");
    try {
      final res = await HttpService().post(ApiConstants.checkUser, body: {"phone": phone});
      if(res != null){
        _checkUserModel = CheckUserModel.fromJson(res);
        setLoading(false);
      }
    } catch (e) {
      print("Error In Check User $e");
      setLoading(false);
    }
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
