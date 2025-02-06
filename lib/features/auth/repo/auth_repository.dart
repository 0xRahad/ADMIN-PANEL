import 'package:admin_panel/config/network/network_service.dart';
import 'package:admin_panel/core/endpoints/api_endpoints.dart';
import 'package:admin_panel/features/auth/model/login_model.dart';

class AuthRepository {
  final NetworkService service = NetworkService();

  Future<LoginModel> loginUser(
      {required String email, required String password}) async {
    final requestBody = {"email": email, "password": password};
    final response = await service.callPostApi(ApiEndpoints.login, requestBody);
    return LoginModel.fromJson(response);
  }
}
