import 'package:admin_panel/config/network/network_service.dart';
import 'package:admin_panel/core/endpoints/api_endpoints.dart';
import 'package:admin_panel/features/main/model/add_product_model.dart';
import 'package:admin_panel/features/main/model/product_delete_model.dart';
import 'package:admin_panel/features/main/model/products_model.dart';

class ProductRepository {
  final NetworkService service = NetworkService();

  Future<ProductsModel> getProducts() async {
    final response = await service.callGetApi(ApiEndpoints.products);
    return ProductsModel.fromJson(response);
  }

  Future<AddProductModel> addProduct({
    required String name,
    required String price,
    required String image,
    required String stock,
  }) async {
    final reqBody = {
      "name": name,
      "price": price,
      "image": image,
      "company": "marcos",
      "description": "Dummy Description of the product",
      "category": "office",
      "inventory": stock
    };
    final response = await service.callPostApi(ApiEndpoints.products, reqBody);
    return AddProductModel.fromJson(response);
  }

  Future<AddProductModel> updateProduct(
      {required String name,
      required String price,
      required String image,
      required String stock,
      required String productId}) async {
    final reqBody = {
      "name": name,
      "price": price,
      "image": image,
      "company": "marcos",
      "description": "Dummy Description of the product",
      "category": "office",
      "inventory": stock
    };
    final response = await service.callPatchApi(
        "${ApiEndpoints.products}/$productId", reqBody);
    return AddProductModel.fromJson(response);
  }

  Future<ProductDeleteModel> deleteProduct({required String productId}) async {
    final response =
        await service.callDeleteApi("${ApiEndpoints.products}/$productId");
    return ProductDeleteModel.fromJson(response);
  }
}
