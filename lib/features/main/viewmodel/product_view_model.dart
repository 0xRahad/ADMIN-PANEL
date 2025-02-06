import 'package:admin_panel/core/exception/api_response.dart';
import 'package:admin_panel/core/utils/my_snack_bar.dart';
import 'package:admin_panel/features/main/model/add_product_model.dart';
import 'package:admin_panel/features/main/model/products_model.dart';
import 'package:admin_panel/features/main/repo/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductViewModel extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController productImageController = TextEditingController();

  final TextEditingController upNameController = TextEditingController();
  final TextEditingController upPriceController = TextEditingController();
  final TextEditingController upStockController = TextEditingController();
  final TextEditingController upProductImageController =
      TextEditingController();

  final productFormKey = GlobalKey<FormState>();
  final updateFormKey = GlobalKey<FormState>();
  final repo = ProductRepository();

  final Rx<ApiResponse<List<Product>?>> productState =
      ApiResponse<List<Product>?>.success(null).obs;

  final Rx<ApiResponse<AddProductModel?>> addProductState =
      ApiResponse<AddProductModel?>.success(null).obs;

  @override
  void onInit() {
    super.onInit();
    getProducts();
  }

  void getProducts() async {
    try {
      productState.value = ApiResponse.loading();
      final response = await repo.getProducts();
      productState.value = ApiResponse.success(response.products);
    } catch (error) {
      productState.value = ApiResponse.error(error.toString());
      mySnackBar(title: "Error", body: error.toString());
    }
  }

  void deleteProduct({required String productId}) async {
    try {
      final response = await repo.deleteProduct(productId: productId);
      final updatedList = List<Product>.from(productState.value.data ?? []);
      updatedList.removeWhere((product) => product.id == productId);
      productState.value = ApiResponse.success(updatedList);
      mySnackBar(title: "Message!", body: response.message.toString());
    } catch (error) {
      mySnackBar(title: "Error", body: error.toString());
    }
  }

  void addProduct() async {
    try {
      addProductState.value = ApiResponse.loading();
      final response = await repo.addProduct(
        name: nameController.text,
        price: priceController.text,
        image: productImageController.text,
        stock: stockController.text,
      );

      if (response.product != null) {
        Get.back();
        clearControllers();
        addProductState.value = ApiResponse.success(response);

        // Convert AddedProduct to Product
        final newProduct = Product(
          id: response.product!.id,
          name: response.product!.name,
          price: response.product!.price,
          image: response.product!.image,
          inventory: response.product!.inventory,
          category: response.product!.category,
        );

        final updatedList = List<Product>.from(productState.value.data ?? []);
        updatedList.add(newProduct);
        productState.value = ApiResponse.success(updatedList);
      } else {
        addProductState.value = ApiResponse.error(response.message.toString());
        mySnackBar(
            title: "Error", body: response.message.toString(), isError: true);
      }
    } catch (error) {
      addProductState.value = ApiResponse.error(error.toString());
    }
  }

  void updateProduct({required String productId}) async {
    try {
      addProductState.value = ApiResponse.loading();
      final response = await repo.updateProduct(
        name: upNameController.text,
        price: upPriceController.text,
        image: upProductImageController.text,
        stock: upStockController.text,
        productId: productId,
      );

      if (response.product != null) {
        Get.back();
        clearUpdateControllers();
        addProductState.value = ApiResponse.success(response);

        final updatedProduct = Product(
          id: response.product!.id,
          name: response.product!.name,
          price: response.product!.price,
          image: response.product!.image,
          inventory: response.product!.inventory,
          category: response.product!.category,
        );

        final updatedList = List<Product>.from(productState.value.data ?? []);

        final productIndex =
            updatedList.indexWhere((product) => product.id == productId);
        if (productIndex != -1) {
          updatedList[productIndex] = updatedProduct;
          productState.value = ApiResponse.success(updatedList);
        }
      } else {
        addProductState.value = ApiResponse.error(response.message.toString());
        mySnackBar(
            title: "Error", body: response.message.toString(), isError: true);
      }
    } catch (error) {
      addProductState.value = ApiResponse.error(error.toString());
    }
  }

  void clearControllers() {
    nameController.clear();
    priceController.clear();
    stockController.clear();
    productImageController.clear();
    productFormKey.currentState!.reset();
  }

  void clearUpdateControllers() {
    upNameController.clear();
    upPriceController.clear();
    upStockController.clear();
    upProductImageController.clear();
    updateFormKey.currentState!.reset();
  }
}
