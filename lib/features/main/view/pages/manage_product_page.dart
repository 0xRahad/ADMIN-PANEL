import 'package:admin_panel/core/exception/status.dart';
import 'package:admin_panel/core/themes/colors.dart';
import 'package:admin_panel/features/widgets/custom_button.dart';
import 'package:admin_panel/features/widgets/custom_text_field.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../model/products_model.dart';
import 'package:admin_panel/features/main/viewmodel/product_view_model.dart';

class ManageProductPage extends StatelessWidget {
  const ManageProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final productVM = Get.put(ProductViewModel());
    return Scaffold(
      backgroundColor: lightGrey,
      body: Obx(() {
        return productVM.productState.value.when(loading: () {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.black,
            strokeWidth: 2,
          ));
        }, success: (data) {
          return data == null || data.isEmpty
              ? Center(child: Text("No Product Found."))
              : SafeArea(child: buildDataTable(data));
        }, error: (message) {
          return Center(
            child: Text(message.toString(), style: TextStyle(fontSize: 16)),
          );
        });
      }),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MaterialButton(
            shape: CircleBorder(),
            color: Colors.blueAccent,
            height: 70,
            child: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              showAddProductDialog();
            },
          ),
          Gap(10),
          MaterialButton(
            shape: CircleBorder(),
            color: Colors.blueAccent,
            height: 70,
            child: Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              productVM.getProducts();
            },
          ),
        ],
      ),
    );
  }

  Widget buildDataTable(List<Product> products) {
    final productVM = Get.find<ProductViewModel>();
    return Padding(
      padding: const EdgeInsets.all(16),
      child: DataTable2(
          columnSpacing: 12,
          horizontalMargin: 12,
          minWidth: 600,
          dataRowHeight: 80,
          dividerThickness: 0.5,
          headingRowDecoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              )),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          columns: [
            DataColumn2(size: ColumnSize.S, label: Text("Image")),
            DataColumn2(size: ColumnSize.L, label: Text("Product Name")),
            DataColumn2(label: Text("Category")),
            DataColumn2(label: Text("Price")),
            DataColumn2(label: Text("Stock")),
            DataColumn2(label: Text("Action")),
          ],
          rows: List<DataRow>.generate(
              products.length,
              (index) => DataRow(cells: [
                    DataCell(
                      CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: ClipOval(
                          child: Image.network(
                            products[index].image ?? "",
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.error,
                                  color: Colors.red); // Error icon
                            },
                          ),
                        ),
                      ),
                    ),
                    DataCell(Text(products[index].name ?? "N/A")),
                    DataCell(Text(products[index].category ?? "N/A")),
                    DataCell(Text("\$${products[index].price ?? "0"}")),
                    DataCell(Text(products[index].inventory.toString())),
                    DataCell(Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {
                              showUpdateProductDialog(products[index]);
                            },
                            icon: Icon(Icons.edit_outlined, color: deepBlue)),
                        IconButton(
                            onPressed: () {
                              productVM.deleteProduct(
                                  productId: products[index].id.toString());
                            },
                            icon:
                                Icon(Icons.delete_outline, color: Colors.red)),
                      ],
                    )),
                  ]))),
    );
  }

  void showAddProductDialog() {
    final productVM = Get.find<ProductViewModel>();

    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: const Text(
          "Add Product",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: 400, // Set your preferred width
          child: Form(
            key: productVM.productFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  controller: productVM.productImageController,
                  hintText: "Product Image",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field is required";
                    }
                    return null;
                  },
                ),
                Gap(10),
                CustomTextField(
                  controller: productVM.nameController,
                  hintText: "Product Name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field is required";
                    }
                    return null;
                  },
                ),
                Gap(10),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: productVM.priceController,
                        hintText: "Price",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        },
                      ),
                    ),
                    Gap(10),
                    Expanded(
                      child: CustomTextField(
                        controller: productVM.stockController,
                        hintText: "Stock",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Obx(() => CustomButton(
                      height: 50,
                      isLoading: productVM.addProductState.value.status ==
                          Status.loading,
                      onPressed: () {
                        if (productVM.productFormKey.currentState?.validate() ??
                            false) {
                          productVM.addProduct();
                        }
                      },
                      buttonText: "Add Product",
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showUpdateProductDialog(Product product) {
    final productVM = Get.find<ProductViewModel>();

    productVM.upProductImageController.value =
        TextEditingValue(text: product.image ?? "");
    productVM.upNameController.value =
        TextEditingValue(text: product.name ?? "");
    productVM.upPriceController.value =
        TextEditingValue(text: product.price.toString());
    productVM.upStockController.value =
        TextEditingValue(text: product.inventory.toString());

    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: const Text(
          "Update Product",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: SizedBox(
          width: 400, // Set your preferred width
          child: Form(
            key: productVM.updateFormKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  controller: productVM.upProductImageController,
                  hintText: "Product Image",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field is required";
                    }
                    return null;
                  },
                ),
                Gap(10),
                CustomTextField(
                  controller: productVM.upNameController,
                  hintText: "Product Name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "This field is required";
                    }
                    return null;
                  },
                ),
                Gap(10),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        controller: productVM.upPriceController,
                        hintText: "Price",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        },
                      ),
                    ),
                    Gap(10),
                    Expanded(
                      child: CustomTextField(
                        controller: productVM.upStockController,
                        hintText: "Stock",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Obx(() => CustomButton(
                      height: 50,
                      isLoading: productVM.addProductState.value.status ==
                          Status.loading,
                      onPressed: () {
                        if (productVM.updateFormKey.currentState?.validate() ??
                            false) {
                          productVM.updateProduct(
                              productId: product.id.toString());
                        }
                      },
                      buttonText: "Update Product",
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
