import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_app_bar.dart';
import 'package:graduation_project_nti/core/shared_widgets/custom_text.dart';
import 'package:graduation_project_nti/features/products/data/repo/product_repo.dart';
import 'package:graduation_project_nti/features/products/presentation/cubit/add_product_cubit.dart';
import 'package:graduation_project_nti/features/products/presentation/cubit/add_product_state.dart';

class AddNewProduct extends StatefulWidget {
  const AddNewProduct({super.key});

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController sellerIdController = TextEditingController();

  bool inStock = true;

  @override
  void dispose() {
    productNameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    categoryController.dispose();
    sellerIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => AddProductCubit(productRepo: ProductRepo()),
      child: BlocConsumer<AddProductCubit, AddProductState>(
        listener: (context, state) {
          if (state is AddProductSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Product added successfully"),
                backgroundColor: Colors.green,
              ),
            );
            Navigator.pop(context);
          } else if (state is AddProductError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: theme.colorScheme.error,
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AddProductLoading;

          return Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: CustomAppBar(title: "Add New Product"),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle("General Information"),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: "Product Name",
                      controller: productNameController,
                      prefixIcon: CupertinoIcons.tag,
                      validator: (value) => value == null || value.isEmpty
                          ? "Name is required"
                          : null,
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: "Description",
                      controller: descriptionController,
                      prefixIcon: CupertinoIcons.doc_text,
                      maxLines: 4,
                      validator: (value) => value == null || value.isEmpty
                          ? "Description is required"
                          : null,
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle("Pricing & Categorization"),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextField(
                            label: 'Price',
                            hint: '0.00',
                            controller: priceController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            prefixIcon: CupertinoIcons.money_dollar,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Required";
                              }
                              if (double.tryParse(value) == null) {
                                return "Invalid";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildTextField(
                            label: "Category",
                            controller: categoryController,
                            prefixIcon: CupertinoIcons.square_grid_2x2,
                            validator: (value) => value == null || value.isEmpty
                                ? "Required"
                                : null,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _buildTextField(
                      label: "Seller ID (GUID)",
                      hint: "8-4-4-4-12 hex string",
                      controller: sellerIdController,
                      prefixIcon: CupertinoIcons.person_alt_circle,
                      validator: (value) {
                        if (value == null || value.isEmpty)
                          return "Seller ID is required";
                        if (!isValidGuid(value)) return "Invalid GUID format";
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    _buildSectionTitle("Availability"),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: theme.cardColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: theme.dividerColor.withAlpha(50),
                        ),
                      ),
                      child: SwitchListTile(
                        title: const CustomText(
                          text: "Product in stock",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        subtitle: Text(
                          "Mark this if the product is available today",
                          style: theme.textTheme.bodySmall,
                        ),
                        secondary: Icon(
                          inStock
                              ? CupertinoIcons.check_mark_circled
                              : CupertinoIcons.xmark_circle,
                          color: inStock ? Colors.green : Colors.red,
                        ),
                        value: inStock,
                        onChanged: (val) => setState(() => inStock = val),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : () => _submit(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: theme.colorScheme.primary,
                          foregroundColor: theme.colorScheme.onPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: isLoading
                            ? const CupertinoActivityIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Save Product",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return CustomText(
      text: title,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Theme.of(context).colorScheme.primary,
    );
  }

  Widget _buildTextField({
    required String label,
    String? hint,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    IconData? prefixIcon,
    String? Function(String?)? validator,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          validator: validator,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon, size: 20) : null,
            filled: true,
            fillColor: theme.cardColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: theme.dividerColor.withAlpha(50)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: theme.dividerColor.withAlpha(50)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: theme.colorScheme.primary,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: theme.colorScheme.error),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
    );
  }

  void _submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<AddProductCubit>().addProduct(
        name: productNameController.text,
        description: descriptionController.text,
        price: double.parse(priceController.text),
        category: categoryController.text,
        sellerId: sellerIdController.text,
        inStock: inStock,
      );
    }
  }

  bool isValidGuid(String value) {
    final regex = RegExp(
      r'^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-'
      r'[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-'
      r'[0-9a-fA-F]{12}$',
    );
    return regex.hasMatch(value);
  }
}
