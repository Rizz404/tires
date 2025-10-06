import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:tires/core/extensions/theme_extensions.dart';
import 'package:tires/core/extensions/localization_extensions.dart';
import 'package:tires/core/services/app_logger.dart';
import 'package:tires/shared/presentation/widgets/app_searchable_dropdown.dart';

class ExampleSearchableDropdownScreen extends StatefulWidget {
  const ExampleSearchableDropdownScreen({super.key});

  @override
  State<ExampleSearchableDropdownScreen> createState() =>
      _ExampleSearchableDropdownScreenState();
}

class _ExampleSearchableDropdownScreenState
    extends State<ExampleSearchableDropdownScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  String? _selectedCountry;
  String? _selectedCity;

  // Sample data for countries
  static const List<AppSearchableDropdownItem<String>> _countries = [
    AppSearchableDropdownItem(
      value: 'us',
      label: 'United States',
      searchKey: 'usa america',
    ),
    AppSearchableDropdownItem(
      value: 'id',
      label: 'Indonesia',
      searchKey: 'indonesia id',
    ),
    AppSearchableDropdownItem(
      value: 'jp',
      label: 'Japan',
      searchKey: 'japan jp',
    ),
    AppSearchableDropdownItem(
      value: 'kr',
      label: 'South Korea',
      searchKey: 'korea south korea',
    ),
    AppSearchableDropdownItem(
      value: 'cn',
      label: 'China',
      searchKey: 'china cn',
    ),
    AppSearchableDropdownItem(
      value: 'in',
      label: 'India',
      searchKey: 'india in',
    ),
    AppSearchableDropdownItem(
      value: 'br',
      label: 'Brazil',
      searchKey: 'brazil br',
    ),
    AppSearchableDropdownItem(
      value: 'uk',
      label: 'United Kingdom',
      searchKey: 'uk britain united kingdom',
    ),
    AppSearchableDropdownItem(
      value: 'fr',
      label: 'France',
      searchKey: 'france fr',
    ),
    AppSearchableDropdownItem(
      value: 'de',
      label: 'Germany',
      searchKey: 'germany de',
    ),
  ];

  // Sample data for cities (will be loaded dynamically)
  static const List<AppSearchableDropdownItem<String>> _allCities = [
    AppSearchableDropdownItem(
      value: 'jakarta',
      label: 'Jakarta',
      searchKey: 'jakarta dki',
    ),
    AppSearchableDropdownItem(
      value: 'surabaya',
      label: 'Surabaya',
      searchKey: 'surabaya jawa timur',
    ),
    AppSearchableDropdownItem(
      value: 'bandung',
      label: 'Bandung',
      searchKey: 'bandung jawa barat',
    ),
    AppSearchableDropdownItem(
      value: 'medan',
      label: 'Medan',
      searchKey: 'medan sumatera utara',
    ),
    AppSearchableDropdownItem(
      value: 'semarang',
      label: 'Semarang',
      searchKey: 'semarang jawa tengah',
    ),
    AppSearchableDropdownItem(
      value: 'makassar',
      label: 'Makassar',
      searchKey: 'makassar sulawesi selatan',
    ),
    AppSearchableDropdownItem(
      value: 'palembang',
      label: 'Palembang',
      searchKey: 'palembang sumatera selatan',
    ),
    AppSearchableDropdownItem(
      value: 'tangerang',
      label: 'Tangerang',
      searchKey: 'tangerang banten',
    ),
    AppSearchableDropdownItem(
      value: 'depok',
      label: 'Depok',
      searchKey: 'depok jawa barat',
    ),
    AppSearchableDropdownItem(
      value: 'bekasi',
      label: 'Bekasi',
      searchKey: 'bekasi jawa barat',
    ),
    AppSearchableDropdownItem(
      value: 'bogor',
      label: 'Bogor',
      searchKey: 'bogor jawa barat',
    ),
    AppSearchableDropdownItem(
      value: 'batam',
      label: 'Batam',
      searchKey: 'batam kepulauan riau',
    ),
    AppSearchableDropdownItem(
      value: 'padang',
      label: 'Padang',
      searchKey: 'padang sumatera barat',
    ),
    AppSearchableDropdownItem(
      value: 'bandar_lampung',
      label: 'Bandar Lampung',
      searchKey: 'bandar lampung lampung',
    ),
    AppSearchableDropdownItem(
      value: 'malang',
      label: 'Malang',
      searchKey: 'malang jawa timur',
    ),
    AppSearchableDropdownItem(
      value: 'yogyakarta',
      label: 'Yogyakarta',
      searchKey: 'yogyakarta diy',
    ),
    AppSearchableDropdownItem(
      value: 'solo',
      label: 'Surakarta',
      searchKey: 'solo surakarta jawa tengah',
    ),
    AppSearchableDropdownItem(
      value: 'pontianak',
      label: 'Pontianak',
      searchKey: 'pontianak kalimantan barat',
    ),
    AppSearchableDropdownItem(
      value: 'manado',
      label: 'Manado',
      searchKey: 'manado sulawesi utara',
    ),
    AppSearchableDropdownItem(
      value: 'mataram',
      label: 'Mataram',
      searchKey: 'mataram ntb',
    ),
  ];

  List<AppSearchableDropdownItem<String>> _cities = _allCities
      .take(10)
      .toList();
  int _currentCityPage = 1;

  // Simulate API search for countries
  Future<List<AppSearchableDropdownItem<String>>> _searchCountries(
    String query,
  ) async {
    AppLogger.networkInfo('Searching countries with query: $query');

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    if (query.isEmpty) return _countries;

    final lowerQuery = query.toLowerCase();
    final results = _countries.where((country) {
      final searchKey =
          country.searchKey?.toLowerCase() ?? country.label.toLowerCase();
      return searchKey.contains(lowerQuery);
    }).toList();

    AppLogger.networkInfo('Found ${results.length} countries matching: $query');
    return results;
  }

  // Simulate API load more for cities
  Future<List<AppSearchableDropdownItem<String>>> _loadMoreCities() async {
    AppLogger.networkInfo('Loading more cities, page: ${_currentCityPage + 1}');

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));

    final startIndex = _currentCityPage * 10;
    final endIndex = (startIndex + 10).clamp(0, _allCities.length);

    if (startIndex >= _allCities.length) return [];

    final newCities = _allCities.sublist(startIndex, endIndex);
    _currentCityPage++;

    AppLogger.networkInfo('Loaded ${newCities.length} more cities');
    return newCities;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Searchable Dropdown Examples'),
        backgroundColor: context.colorScheme.primary,
        foregroundColor: context.colorScheme.onPrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              Text(
                'Basic Searchable Dropdown',
                style: context.textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              AppSearchableDropdown<String>(
                name: 'country',
                label: 'Select Country',
                hintText: 'Choose a country',
                searchHintText: 'Search countries...',
                initialValue: _selectedCountry,
                items: _countries,
                onSearch: _searchCountries,
                onChanged: (value) {
                  setState(() {
                    _selectedCountry = value;
                  });
                  AppLogger.uiInfo('Country selected: $value');
                },
                emptySearchResult: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('No countries found'),
                ),
              ),
              const SizedBox(height: 32),
              Text(
                'Infinite Scroll Dropdown',
                style: context.textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              AppSearchableDropdown<String>(
                name: 'city',
                label: 'Select City',
                hintText: 'Choose a city',
                searchHintText: 'Search cities...',
                initialValue: _selectedCity,
                items: _cities,
                enableInfiniteScroll: true,
                onLoadMore: _loadMoreCities,
                maxHeight: 250,
                onChanged: (value) {
                  setState(() {
                    _selectedCity = value;
                  });
                  AppLogger.uiInfo('City selected: $value');
                },
                emptySearchResult: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('No cities found'),
                ),
                loadingIndicator: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                      SizedBox(width: 8),
                      Text('Loading...'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Text('Selected Values', style: context.textTheme.headlineSmall),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: context.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Country: ${_selectedCountry ?? 'None selected'}'),
                    const SizedBox(height: 4),
                    Text('City: ${_selectedCity ?? 'None selected'}'),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.saveAndValidate() ?? false) {
                    AppLogger.uiInfo('Form validated successfully');
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Form submitted successfully!'),
                      ),
                    );
                  }
                },
                child: const Text('Submit Form'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
