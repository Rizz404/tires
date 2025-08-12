import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:tires/core/routes/app_router.dart';
import 'package:tires/features/home/presentation/widgets/home_carousel.dart';
import 'package:tires/features/home/presentation/widgets/menu_tile.dart';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';
import 'package:tires/shared/presentation/widgets/screen_wrapper.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // --- Static Data as Provider Replacement ---
  final List<Menu> _staticMenus = [
    const Menu(
      id: 1,
      name: 'Spooring & Balancing Service',
      description:
          'Aligning the position of the four car wheels according to manufacturer specifications and balancing their rotation.',
      requiredTime: 60,
      price: Price(amount: '250000', formatted: 'Rp 250.000', currency: 'IDR'),
      displayOrder: 1,
      isActive: true,
      color: ColorInfo(
        hex: '#004080',
        rgbaLight: 'rgba(0, 64, 128, 0.1)',
        textColor: '#FFFFFF',
      ),
    ),
    const Menu(
      id: 2,
      name: 'Engine Oil Change',
      description: 'Replacing engine oil using quality products.',
      requiredTime: 30,
      price: Price(amount: '450000', formatted: 'Rp 450.000', currency: 'IDR'),
      displayOrder: 2,
      isActive: true,
      color: ColorInfo(
        hex: '#FF9900',
        rgbaLight: 'rgba(255, 153, 0, 0.1)',
        textColor: '#FFFFFF',
      ),
    ),
    const Menu(
      id: 3,
      name: '20,000 KM Periodic Service Package',
      description:
          'Complete inspection and maintenance according to the 20,000 KM service standard.',
      requiredTime: 120,
      price: Price(amount: '850000', formatted: 'Rp 850.000', currency: 'IDR'),
      displayOrder: 3,
      isActive: true,
      color: ColorInfo(
        hex: '#004080',
        rgbaLight: 'rgba(0, 64, 128, 0.1)',
        textColor: '#FFFFFF',
      ),
    ),
    const Menu(
      id: 4,
      name: 'Brake Inspection',
      description:
          'Inspection of brake pads, brake fluid, and other components.',
      requiredTime: 45,
      price: Price(amount: '150000', formatted: 'Rp 150.000', currency: 'IDR'),
      displayOrder: 4,
      isActive: false,
      color: ColorInfo(
        hex: '#333333',
        rgbaLight: 'rgba(51, 51, 51, 0.1)',
        textColor: '#FFFFFF',
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ScreenWrapper(child: _buildBody()));
  }

  Widget _buildBody() {
    if (_staticMenus.isEmpty) {
      return const Center(
        child: AppText('No menus available', style: AppTextStyle.bodyMedium),
      );
    }

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Carousel
          const HomeCarousel(),
          const SizedBox(height: 24),

          // Services Title
          const AppText('Our Services', style: AppTextStyle.headlineSmall),
          const SizedBox(height: 16),

          // Menu List
          ...List.generate(_staticMenus.length, (index) {
            final menu = _staticMenus[index];
            return MenuTile(
              menu: menu,
              onBookPressed: () {
                context.router.push(const CreateReservationRoute());
              },
            );
          }),

          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
