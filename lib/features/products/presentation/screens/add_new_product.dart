import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class AddNewProduct extends StatefulWidget {
  const AddNewProduct({super.key});

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController sellerIdController = TextEditingController();

  bool inStock = true;
  bool isFeatured = false;
  bool isLoading = false;

  final Dio dio = Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add New Product"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Product Name
            _buildTextField(
              label: "Product Name",
              controller: productNameController,
            ),

            const SizedBox(height: 16),

            /// Price
            _buildTextField(
              label: "Price",
              controller: priceController,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 16),

            /// Category
            _buildTextField(label: "Category", controller: categoryController),

            const SizedBox(height: 16),

            /// Seller ID (GUID)
            _buildTextField(
              label: "Seller ID",
              hint: "e.g. c56a4180-65aa-42ec-a945-5fd21dec0538",
              controller: sellerIdController,
            ),

            const SizedBox(height: 16),

            /// Description
            _buildTextField(
              label: "Description",
              controller: descriptionController,
              maxLines: 3,
            ),

            const SizedBox(height: 24),

            /// In Stock Switch
            _buildSwitch(
              title: "In Stock",
              value: inStock,
              onChanged: (val) {
                setState(() {
                  inStock = val;
                });
              },
            ),

            /// Featured Switch
            _buildSwitch(
              title: "Featured Product",
              value: isFeatured,
              onChanged: (val) {
                setState(() {
                  isFeatured = val;
                });
              },
            ),

            const SizedBox(height: 40),

            /// Add Product Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : addProduct,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Add Product"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// TextField Widget
  Widget _buildTextField({
    required String label,
    String? hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }

  /// Switch Widget
  Widget _buildSwitch({
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }

  /// Add Product API Call
  Future<void> addProduct() async {
    if (productNameController.text.isEmpty ||
        descriptionController.text.isEmpty ||
        priceController.text.isEmpty ||
        categoryController.text.isEmpty ||
        sellerIdController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all the information.")),
      );
      return;
    }

    if (!isValidGuid(sellerIdController.text)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Incorrect Seller ID")));
      return;
    }

    setState(() => isLoading = true);

    try {
      await dio.post(
        "https://accessories-eshop.runasp.net/api/products",
        data: {
          "name": productNameController.text,
          "description": descriptionController.text,
          "price": double.parse(priceController.text),
          "categories": [categoryController.text],
          "productPictures": ["https://dummyimage.com/300x300"],
          "nameArabic": "",
          "descriptionArabic": "",
          "coverPictureUrl": "",
          "sellerId": sellerIdController.text,
          "color": "",
        },
      );

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Added Successfully")));

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      setState(() => isLoading = false);
    }
  }

  /// GUID Validation
  bool isValidGuid(String value) {
    final regex = RegExp(
      r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-'
      r'[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-'
      r'[0-9a-fA-F]{12}$',
    );
    return regex.hasMatch(value);
  }
}
