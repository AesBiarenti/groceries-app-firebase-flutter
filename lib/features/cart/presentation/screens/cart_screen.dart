import 'package:flutter/material.dart';
import 'package:grocceries_app_flutter_firebase/core/constants/app_constants.dart';
import 'package:grocceries_app_flutter_firebase/core/theme/app_colors.dart';

class CartItem {
  final String id;
  final String name;
  final String unit;
  final double price;
  final String imageAsset;

  CartItem({
    required this.id,
    required this.name,
    required this.unit,
    required this.price,
    required this.imageAsset,
  });
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late List<CartItem> _items;

  late Map<String, int> _quantities;

  @override
  void initState() {
    super.initState();
    _items = [
      CartItem(
        id: '1',
        name: 'Bell Pepper Red',
        unit: '1kg',
        price: 4.99,
        imageAsset: AppConstants.assetIcPaprica,
      ),
      CartItem(
        id: '2',
        name: 'Egg Chicken Red',
        unit: '4pcs',
        price: 1.99,
        imageAsset: AppConstants.assetIcApple,
      ),
      CartItem(
        id: '3',
        name: 'Organic Bananas',
        unit: '12kg',
        price: 3.00,
        imageAsset: AppConstants.assetIcBanana,
      ),
      CartItem(
        id: '4',
        name: 'Ginger',
        unit: '250gm',
        price: 2.99,
        imageAsset: AppConstants.assetIcGinger,
      ),
    ];
    _quantities = {for (var e in _items) e.id: 1};
  }

  double get _total => _items.fold<double>(
    0,
    (sum, item) => sum + item.price * (_quantities[item.id] ?? 1),
  );

  void _updateQuantity(String id, int delta) {
    setState(() {
      final q = (_quantities[id] ?? 1) + delta;
      if (q < 1) return;
      _quantities[id] = q;
    });
  }

  void _remove(String id) {
    setState(() {
      _items.removeWhere((e) => e.id == id);
      _quantities.remove(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Cart'), centerTitle: true),
      body: _items.isEmpty
          ? const Center(
              child: Text(
                'Sepetiniz boş',
                style: TextStyle(fontSize: 18, color: AppColors.textSecondary),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    itemCount: _items.length,
                    separatorBuilder: (_, __) => const Divider(height: 24),
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      final q = _quantities[item.id] ?? 1;
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              item.imageAsset,
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => const Icon(
                                Icons.image_not_supported,
                                size: 48,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                Text(
                                  '${item.unit}, ${AppConstants.currencySymbol}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    _QtyButton(
                                      icon: Icons.remove,
                                      onPressed: q > 1
                                          ? () => _updateQuantity(item.id, -1)
                                          : null,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: Text(
                                        '$q',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    _QtyButton(
                                      icon: Icons.add,
                                      onPressed: () =>
                                          _updateQuantity(item.id, 1),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                '${AppConstants.currencySymbol}${(item.price * q).toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  size: 20,
                                  color: AppColors.textSecondary,
                                ),
                                onPressed: () => _remove(item.id),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 20,
                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: SizedBox(
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(
                          context,
                        ).pushNamed(AppConstants.routeCheckout),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Go to Checkout'),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryDark,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '${AppConstants.currencySymbol}${_total.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;

  const _QtyButton({required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: onPressed != null ? AppColors.primary : AppColors.divider,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Icon(icon, size: 18, color: Colors.white),
        ),
      ),
    );
  }
}
