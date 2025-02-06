abstract class BaseApiService {
  Future<dynamic> callGetApi(String endpoint);
  Future<dynamic> callPostApi(String endpoint, var requestBody);
  Future<dynamic> callDeleteApi(String endpoint);
  Future<dynamic> callPatchApi(String endpoint, var requestBody);
}