import 'package:flutter/material.dart';
import 'package:grocceries_app_flutter_firebase/core/constants/app_constants.dart';
import 'package:grocceries_app_flutter_firebase/core/theme/app_colors.dart';
import 'package:grocceries_app_flutter_firebase/features/products/presentation/widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static final List<Map<String, dynamic>> _exclusiveProducts = [
    {'name': 'Organic Bananas', 'unit': '7pcs', 'price': 4.99, 'image': AppConstants.assetIcBanana},
    {'name': 'Red Apple', 'unit': '1kg', 'price': 4.99, 'image': AppConstants.assetIcApple},
    {'name': 'Red Bell Peppers', 'unit': '1kg', 'price': 4.99, 'image': AppConstants.assetIcPaprica},
    {'name': 'Ginger', 'unit': '250gm', 'price': 4.99, 'image': AppConstants.assetIcGinger},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Image.asset(
                        AppConstants.assetIcSplash,
                        height: 32,
                        width: 32,
                        errorBuilder: (_, __, ___) => const Icon(Icons.restaurant, color: AppColors.primary),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, color: AppColors.primary, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          AppConstants.defaultLocation,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: AppColors.textHint, size: 22),
                          const SizedBox(width: 12),
                          Text(
                            'Search Store',
                            style: TextStyle(color: AppColors.textHint, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Container(
                        height: 120,
                        width: double.infinity,
                        color: AppColors.primary.withValues(alpha: 0.2),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Fresh Vegetables',
                                    style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Get Up To 40% OFF',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 0, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Exclusive Offer',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('See all', style: TextStyle(color: AppColors.primary)),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: _exclusiveProducts.length,
                  itemBuilder: (context, index) {
                    final p = _exclusiveProducts[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: ProductCard(
                        id: 'ex-$index',
                        name: p['name'] as String,
                        unit: p['unit'] as String,
                        price: (p['price'] as num).toDouble(),
                        imageAsset: p['image'] as String,
                        onAdd: () {},
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 0, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Best Selling',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('See all', style: TextStyle(color: AppColors.primary)),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: _exclusiveProducts.length,
                  itemBuilder: (context, index) {
                    final p = _exclusiveProducts[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: ProductCard(
                        id: 'best-$index',
                        name: p['name'] as String,
                        unit: p['unit'] as String,
                        price: (p['price'] as num).toDouble(),
                        imageAsset: p['image'] as String,
                        onAdd: () {},
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 24, 0, 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Groceries',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('See all', style: TextStyle(color: AppColors.primary)),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  itemCount: _exclusiveProducts.length,
                  itemBuilder: (context, index) {
                    final p = _exclusiveProducts[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: ProductCard(
                        id: 'grocery-$index',
                        name: p['name'] as String,
                        unit: p['unit'] as String,
                        price: (p['price'] as num).toDouble(),
                        imageAsset: p['image'] as String,
                        onAdd: () {},
                      ),
                    );
                  },
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 100)),
          ],
        ),
      ),
    );
  }
}
