import 'package:flutter/material.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_app_bar.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_elevated_button.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';
import 'package:graduation_project_nti/features/auth/presentation/widgets/custom_text_form_field.dart';

class AddNewProduct extends StatefulWidget {
  const AddNewProduct({super.key});

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  final TextEditingController productName = TextEditingController();
  final TextEditingController description = TextEditingController();
  bool inStock = true;
  bool isFeatured = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: CustomAppBar(
          title: 'Add New Product',
          centerTitle: true,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.arrow_back),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Product Images",
                fontSize: 14,
                color: Colors.black,
              ),
              SizedBox(height: 100),
              CustomText(
                text: "Add up to 5 images. First image is the cover.",
                fontSize: 12,
                color: Colors.grey,
              ),
              SizedBox(height: 20),
              CustomTextField(
                labelText: 'Product Name',
                hintText: 'e.g. Gold Plated Necklace',
                controller: productName,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      labelText: 'Product Price',
                      hintText: 'e.g. 100',
                      controller: TextEditingController(),
                    ),
                  ),
                  SizedBox(width: 30),
                  Expanded(
                    child: CustomTextField(
                      hight: 211,
                      labelText: 'Category',
                      hintText: 'Select Category',
                      controller: TextEditingController(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              CustomTextField(
                labelText: 'Description',
                hintText: "Describe the material, size, and features...",
                controller: description,
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),

                  border: Border.all(color: Colors.grey),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "In Stock",
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                inStock = !inStock;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              width: 46,
                              height: 26,
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: inStock
                                    ? Colors.red
                                    : Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: AnimatedAlign(
                                duration: const Duration(milliseconds: 250),
                                alignment: inStock
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(thickness: 1, height: 20, color: Colors.grey),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "Featured Product",
                            fontSize: 15,
                            color: Colors.black,
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isFeatured = !isFeatured;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 250),
                              width: 46,
                              height: 26,
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: isFeatured
                                    ? Colors.red
                                    : Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: AnimatedAlign(
                                duration: const Duration(milliseconds: 250),
                                alignment: isFeatured
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 200),
              CustomElevatedButton(onPressed: () {}, text: 'Add Product'),
            ],
          ),
        ),
      ),
    );
  }
}
