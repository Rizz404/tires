import 'dart:convert';
import 'package:tires/features/menu/domain/entities/menu.dart';
import 'package:tires/shared/presentation/utils/debug_helper.dart';

class MenuModel extends Menu {
  const MenuModel({
    required super.id,
    required super.name,
    super.description,
    required super.requiredTime,
    required PriceModel super.price,
    super.photoPath,
    required super.displayOrder,
    required super.isActive,
    required ColorInfoModel super.color,
    super.translations,
  });

  factory MenuModel.fromMap(Map<String, dynamic> map) {
    DebugHelper.traceModelCreation('MenuModel', map);

    try {
      final id =
          DebugHelper.safeCast<int>(map['id'], 'id', defaultValue: 0) ?? 0;
      final name =
          DebugHelper.safeCast<String>(map['name'], 'name', defaultValue: '') ??
          '';
      final description = DebugHelper.safeCast<String>(
        map['description'],
        'description',
      );
      final requiredTime =
          DebugHelper.safeCast<int>(
            map['required_time'],
            'required_time',
            defaultValue: 0,
          ) ??
          0;
      final photoPath = DebugHelper.safeCast<String>(
        map['photo_path'],
        'photo_path',
      );
      final displayOrder =
          DebugHelper.safeCast<int>(
            map['display_order'],
            'display_order',
            defaultValue: 0,
          ) ??
          0;
      final isActive =
          DebugHelper.safeCast<bool>(
            map['is_active'],
            'is_active',
            defaultValue: true,
          ) ??
          true;

      // Debug price creation
      print(
        '🔍 Creating price from: ${map['price']} (${map['price'].runtimeType})',
      );
      final price = _createPriceFromDynamic(map['price']);
      print('✅ Price created successfully: ${price.amount}');

      // Debug color creation
      print(
        '🔍 Creating color from: ${map['color']} (${map['color'].runtimeType})',
      );
      final color = _createColorFromDynamic(map['color']);
      print('✅ Color created successfully: ${color.hex}');

      // Debug translations creation
      print(
        '🔍 Creating translations from: ${map['translations']} (${map['translations']?.runtimeType})',
      );
      final translations = _createTranslationsFromDynamic(map['translations']);
      print('✅ Translations created successfully');

      // Debug meta creation
      print(
        '🔍 Creating meta from: ${map['meta']} (${map['meta']?.runtimeType})',
      );
      final meta = _createMetaFromDynamic(map['meta']);
      print('✅ Meta created successfully');

      return MenuModel(
        id: id,
        name: name,
        description: description,
        requiredTime: requiredTime,
        price: price,
        photoPath: photoPath,
        displayOrder: displayOrder,
        isActive: isActive,
        color: color,
        translations: translations,
      );
    } catch (e, stackTrace) {
      print('❌ Error in MenuModel.fromMap: $e');
      print('📋 Map contents: $map');
      print('📊 Stack trace: $stackTrace');
      rethrow;
    }
  }

  static PriceModel _createPriceFromDynamic(dynamic priceData) {
    if (priceData == null) {
      DebugHelper.safeCast(
        null,
        'price_null',
        defaultValue: 'using default price',
      );
      return const PriceModel(
        amount: '0.00',
        formatted: r'$0.00',
        currency: 'USD',
      );
    }

    // Handle case where price is a Map (full price object)
    if (priceData is Map<String, dynamic>) {
      return PriceModel.fromMap(priceData);
    }

    // Handle case where price is just a string amount (like in reservation API)
    if (priceData is String) {
      final parsedAmount = double.tryParse(priceData);
      final formattedValue = parsedAmount != null
          ? '\$${parsedAmount.toStringAsFixed(2)}'
          : '\$$priceData';
      return PriceModel(
        amount: priceData,
        formatted: formattedValue,
        currency: 'USD',
      );
    }

    // Handle case where price is a number
    if (priceData is num) {
      final amountStr = priceData.toString();
      return PriceModel(
        amount: amountStr,
        formatted: '\$${priceData.toStringAsFixed(2)}',
        currency: 'USD',
      );
    }

    // Fallback
    DebugHelper.safeCast(
      priceData,
      'price_fallback',
      defaultValue: 'using default price',
    );
    return const PriceModel(
      amount: '0.00',
      formatted: r'$0.00',
      currency: 'USD',
    );
  }

  static ColorInfoModel _createColorFromDynamic(dynamic colorData) {
    try {
      print('🎨 Color data received: $colorData (${colorData.runtimeType})');

      if (colorData == null) {
        DebugHelper.safeCast(
          null,
          'color_null',
          defaultValue: 'using default color',
        );
        print('⚠️ Using default color for null input');
        return const ColorInfoModel(
          hex: '#000000',
          rgbaLight: 'rgba(0, 0, 0, 0.1)',
          textColor: '#ffffff',
        );
      }

      if (colorData is Map<String, dynamic>) {
        print('🗺️ Color is a Map, using ColorInfoModel.fromMap');
        return ColorInfoModel.fromMap(colorData);
      }

      // Handle case where color is just a hex string
      if (colorData is String) {
        print('🏷️ Color is a hex string: $colorData');
        return ColorInfoModel(
          hex: colorData.startsWith('#') ? colorData : '#$colorData',
          rgbaLight: 'rgba(0, 0, 0, 0.1)',
          textColor: '#ffffff',
        );
      }

      // Fallback
      print('⚠️ Unknown color data type, using fallback');
      DebugHelper.safeCast(
        colorData,
        'color_fallback',
        defaultValue: 'using default color',
      );
      return const ColorInfoModel(
        hex: '#000000',
        rgbaLight: 'rgba(0, 0, 0, 0.1)',
        textColor: '#ffffff',
      );
    } catch (e, stackTrace) {
      print('❌ Error creating ColorInfoModel: $e');
      print('📊 Color data: $colorData');
      print('📊 Stack trace: $stackTrace');
      // Return a safe fallback
      return const ColorInfoModel(
        hex: '#000000',
        rgbaLight: 'rgba(0, 0, 0, 0.1)',
        textColor: '#ffffff',
      );
    }
  }

  static MenuTranslationModel? _createTranslationsFromDynamic(
    dynamic translationsData,
  ) {
    try {
      print(
        '🌐 Translations data received: $translationsData (${translationsData.runtimeType})',
      );

      if (translationsData == null) {
        print('⚠️ Translations is null, returning null');
        return null;
      }

      if (translationsData is Map<String, dynamic>) {
        print('🗺️ Translations is a Map, using MenuTranslationModel.fromMap');
        return MenuTranslationModel.fromMap(translationsData);
      }

      // Fallback
      print('⚠️ Unknown translations data type, returning null');
      return null;
    } catch (e, stackTrace) {
      print('❌ Error creating MenuTranslationModel: $e');
      print('📊 Translations data: $translationsData');
      print('📊 Stack trace: $stackTrace');
      // Return null for safety
      return null;
    }
  }

  static MetaModel _createMetaFromDynamic(dynamic metaData) {
    try {
      print('📊 Meta data received: $metaData (${metaData.runtimeType})');

      if (metaData == null) {
        print('⚠️ Meta is null, using default');
        return MetaModel(locale: 'en', fallbackUsed: true);
      }

      if (metaData is Map<String, dynamic>) {
        print('🗺️ Meta is a Map, using MetaModel.fromMap');
        return MetaModel.fromMap(metaData);
      }

      // Fallback
      print('⚠️ Unknown meta data type, using default');
      return MetaModel(locale: 'en', fallbackUsed: true);
    } catch (e, stackTrace) {
      print('❌ Error creating MetaModel: $e');
      print('📊 Meta data: $metaData');
      print('📊 Stack trace: $stackTrace');
      // Return safe fallback
      return MetaModel(locale: 'en', fallbackUsed: true);
    }
  }

  factory MenuModel.fromJson(String source) =>
      MenuModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'required_time': requiredTime,
      'price': (price as PriceModel).toMap(),
      'photo_path': photoPath,
      'display_order': displayOrder,
      'is_active': isActive,
      'color': (color as ColorInfoModel).toMap(),
      'translations': (translations as MenuTranslationModel?)?.toMap(),
    };
  }

  String toJson() => json.encode(toMap());
}

class PriceModel extends Price {
  const PriceModel({
    required super.amount,
    required super.formatted,
    required super.currency,
  });

  factory PriceModel.fromMap(Map<String, dynamic> map) {
    DebugHelper.traceModelCreation('PriceModel', map);

    return PriceModel(
      amount:
          DebugHelper.safeCast<String>(
            map['amount'],
            'amount',
            defaultValue: '0.00',
          ) ??
          '0.00',
      formatted:
          DebugHelper.safeCast<String>(
            map['formatted'],
            'formatted',
            defaultValue: r'$0.00',
          ) ??
          r'$0.00',
      currency:
          DebugHelper.safeCast<String>(
            map['currency'],
            'currency',
            defaultValue: 'USD',
          ) ??
          'USD',
    );
  }

  Map<String, dynamic> toMap() {
    return {'amount': amount, 'formatted': formatted, 'currency': currency};
  }
}

class ColorInfoModel extends ColorInfo {
  const ColorInfoModel({
    required super.hex,
    required super.rgbaLight,
    required super.textColor,
  });

  factory ColorInfoModel.fromMap(Map<String, dynamic> map) {
    try {
      DebugHelper.traceModelCreation('ColorInfoModel', map);

      final hex =
          DebugHelper.safeCast<String>(
            map['hex'],
            'hex',
            defaultValue: '#000000',
          ) ??
          '#000000';

      final rgbaLight =
          DebugHelper.safeCast<String>(
            map['rgba_light'],
            'rgba_light',
            defaultValue: 'rgba(0, 0, 0, 0.1)',
          ) ??
          'rgba(0, 0, 0, 0.1)';

      final textColor =
          DebugHelper.safeCast<String>(
            map['text_color'],
            'text_color',
            defaultValue: '#ffffff',
          ) ??
          '#ffffff';

      print(
        '🎨 ColorInfoModel created: hex=$hex, rgbaLight=$rgbaLight, textColor=$textColor',
      );

      return ColorInfoModel(
        hex: hex,
        rgbaLight: rgbaLight,
        textColor: textColor,
      );
    } catch (e, stackTrace) {
      print('❌ Error in ColorInfoModel.fromMap: $e');
      print('🗺️ Map contents: $map');
      print('📊 Stack trace: $stackTrace');
      // Return safe fallback
      return const ColorInfoModel(
        hex: '#000000',
        rgbaLight: 'rgba(0, 0, 0, 0.1)',
        textColor: '#ffffff',
      );
    }
  }

  Map<String, dynamic> toMap() {
    return {'hex': hex, 'rgba_light': rgbaLight, 'text_color': textColor};
  }
}

class MenuTranslationModel extends MenuTranslation {
  const MenuTranslationModel({
    required MenuContentModel en,
    required MenuContentModel ja,
  }) : super(en: en, ja: ja);

  factory MenuTranslationModel.fromMap(Map<String, dynamic> map) {
    DebugHelper.traceModelCreation('MenuTranslationModel', map);
    return MenuTranslationModel(
      en: map['en'] != null && map['en'] is Map<String, dynamic>
          ? MenuContentModel.fromMap(map['en'])
          : const MenuContentModel(name: '', description: null),
      ja: map['ja'] != null && map['ja'] is Map<String, dynamic>
          ? MenuContentModel.fromMap(map['ja'])
          : const MenuContentModel(name: '', description: null),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'en': (en as MenuContentModel).toMap(),
      'ja': (ja as MenuContentModel).toMap(),
    };
  }
}

class MenuContentModel extends MenuContent {
  const MenuContentModel({required String name, String? description})
    : super(name: name, description: description);

  factory MenuContentModel.fromMap(Map<String, dynamic> map) {
    DebugHelper.traceModelCreation('MenuContentModel', map);
    return MenuContentModel(
      name:
          DebugHelper.safeCast<String>(map['name'], 'name', defaultValue: '') ??
          '',
      description: DebugHelper.safeCast<String>(
        map['description'],
        'description',
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'description': description};
  }
}

class MetaModel extends Meta {
  MetaModel({required super.locale, required super.fallbackUsed});

  factory MetaModel.fromMap(Map<String, dynamic> map) {
    DebugHelper.traceModelCreation('MetaModel', map);
    return MetaModel(
      locale:
          DebugHelper.safeCast<String>(
            map['locale'],
            'locale',
            defaultValue: 'en',
          ) ??
          'en',
      fallbackUsed:
          DebugHelper.safeCast<bool>(
            map['fallback_used'],
            'fallback_used',
            defaultValue: false,
          ) ??
          false,
    );
  }

  Map<String, dynamic> toMap() {
    return {'locale': locale, 'fallback_used': fallbackUsed};
  }
}
