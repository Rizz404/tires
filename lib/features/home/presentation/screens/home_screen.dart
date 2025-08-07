import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
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
  // --- Data Statis Pengganti Provider ---
  final List<Menu> _staticMenus = [
    const Menu(
      id: 1,
      name: 'Service Spooring & Balancing',
      description:
          'Meluruskan posisi empat roda mobil sesuai spesifikasi pabrikan dan menyeimbangkan putarannya.',
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
      name: 'Ganti Oli Mesin',
      description: 'Penggantian oli mesin menggunakan produk berkualitas.',
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
      name: 'Paket Servis Berkala 20.000 KM',
      description:
          'Pemeriksaan dan perawatan lengkap sesuai standar servis 20.000 KM.',
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
      name: 'Pengecekan Rem',
      description: 'Pemeriksaan kampas rem, minyak rem, dan komponen lainnya.',
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
        child: AppText('No menus available', style: AppTextStyle.body),
      );
    }

    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: HomeCarousel()),
        const SliverToBoxAdapter(
          child: AppText('Layanan Kami', style: AppTextStyle.headline),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final menu = _staticMenus[index];
            return MenuTile(
              menu: menu,
              onBookPressed: () {
                _handleBookPressed(menu);
              },
            );
          }, childCount: _staticMenus.length),
        ),
      ],
    );
  }

  void _handleBookPressed(Menu menu) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: AppText('Booking ${menu.name}...'),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
