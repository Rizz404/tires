import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/shared/presentation/widgets/app_text.dart';

class HomeCarousel extends StatefulWidget {
  const HomeCarousel({super.key});

  @override
  State<HomeCarousel> createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<Map<String, String>> _carouselData = [
    {
      'image': 'https://placehold.co/600x400/E6F0FA/004080?text=Promo+Servis',
      'title': 'Diskon Spesial Servis Berkala!',
      'subtitle': 'Jaga kondisi mobil Anda tetap prima.',
    },
    {
      'image': 'https://placehold.co/600x400/FFF0E6/FF9900?text=Ban+Baru',
      'title': 'Ganti Ban, Harga Teman',
      'subtitle': 'Berbagai merek ban berkualitas tersedia.',
    },
    {
      'image': 'https://placehold.co/600x400/E0E0E0/333333?text=Spooring',
      'title': 'Spooring & Balancing Akurat',
      'subtitle': 'Berkendara lebih nyaman dan aman.',
    },
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _carouselData.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 350),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _carouselData.length,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                final item = _carouselData[index];
                return Card(
                  clipBehavior: Clip.antiAlias,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        item['image']!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: context.colorScheme.tertiary,
                          child: Center(
                            child: Icon(
                              Icons.image_not_supported,
                              color: context.colorScheme.primary,
                              size: 40,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.6),
                              Colors.transparent,
                              Colors.black.withOpacity(0.6),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              item['title']!,
                              style: AppTextStyle.headline,
                              color: Colors.white,
                            ),
                            const SizedBox(height: 4),
                            AppText(
                              item['subtitle']!,
                              style: AppTextStyle.body,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_carouselData.length, (index) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 8,
                width: _currentPage == index ? 24 : 8,
                decoration: BoxDecoration(
                  color: _currentPage == index
                      ? context.colorScheme.primary
                      : Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(12),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
