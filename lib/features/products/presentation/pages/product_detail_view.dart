import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internship_assignment/core/common/components/product_review/product_review.dart';
import 'package:internship_assignment/core/common/components/product_review/stock.dart';
import 'package:internship_assignment/core/utils/constants/colors.dart';
import 'package:internship_assignment/features/products/domain/entity/product_entity.dart';
import 'package:internship_assignment/features/products/presentation/bloc/cubit/image_cubit.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductEntity product;

  const ProductDetailPage({super.key, required this.product});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return BlocProvider(
      create: (_) => ImageCubit(product.thumbnail),
      child: Scaffold(
        body: ListView(
          children: [
            Stack(
              children: [
                BlocBuilder<ImageCubit, String>(
                  builder: (context, mainImage) {
                    return ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(20)),
                      child: Image.network(
                        mainImage,
                        //  fit: BoxFit.cover,
                        width: double.infinity,
                        height: 300,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(
                          child: Icon(
                            Icons.image,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                if (product.images.isNotEmpty)
                  Positioned(
                    left: 10,
                    top: 30,
                    child: SizedBox(
                      height: 250,
                      width: 70,
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: product.images.length,
                        itemBuilder: (context, index) {
                          final image = product.images[index];
                          return GestureDetector(
                            onTap: () {
                              context.read<ImageCubit>().updateMainImage(image);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  image,
                                  width: 70,
                                  height: 70,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Center(
                                    child: Icon(Icons.image,
                                        size: 50, color: Colors.grey),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                // Discount Badge
                if (product.discountPercentage > 0)
                  Positioned(
                    top: 20,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.red.shade400, Colors.red.shade700],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '${product.discountPercentage.toStringAsFixed(0)}% OFF',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                Positioned(
                    top: 0,
                    left: 15,
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back_ios_new_outlined))),
              ],
            ),

            // Product Info
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.green,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 18, color: Colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        product.rating.toStringAsFixed(1),
                        style: const TextStyle(
                            fontSize: 14, color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Description
                  _buildExpandableText('Description:', product.description),
                  const SizedBox(height: 20),
                  // Category, Brand, SKU, Stock
                  _buildProductDetail('Category: ${product.category}'),
                  _buildProductDetail('Brand: ${product.brand}'),
                  _buildProductDetail('SKU: ${product.sku}'),
                  buildStockStatus(product.stock),
                  const SizedBox(height: 20),
                  _buildExpandableText(
                      'Shipping & Warranty Info:', product.shippingInformation,
                      isShippingWarranty: true),
                  const SizedBox(height: 20),
                  const Divider(thickness: 1),
                  const SizedBox(height: 10),
                  buildReviewsSection(product),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: SizedBox(
          height: 50,
          child: Row(
            children: [
              Expanded(
                  child: Container(
                height: double.infinity,
                alignment: Alignment.center,
                child: const Text(
                  'Add to Cart',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )),
              Expanded(
                  child: Container(
                height: double.infinity,
                color: TColors.darkAccent,
                alignment: Alignment.center,
                child: Text(
                  'Buy Now',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: TColors.lightPrimary),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandableText(String title, String text,
      {bool isShippingWarranty = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          text,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ],
    );
  }

  Widget _buildProductDetail(String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text(
        detail,
        style: const TextStyle(fontSize: 16, color: Colors.black54),
      ),
    );
  }
}
