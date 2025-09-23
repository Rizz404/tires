import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tires/shared/presentation/widgets/app_text_field.dart';

void main() {
  group('AppTextField Widget Tests', () {
    testWidgets('should display basic text field correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FormBuilder(
              key: GlobalKey<FormBuilderState>(),
              child: AppTextField(
                name: 'test',
                label: 'Test Label',
                placeHolder: 'Test Placeholder',
              ),
            ),
          ),
        ),
      );

      expect(find.text('Test Label'), findsOneWidget);
      expect(find.text('Test Placeholder'), findsOneWidget);
    });

    testWidgets('should display price JP field with yen prefix', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FormBuilder(
              key: GlobalKey<FormBuilderState>(),
              child: AppTextField(
                name: 'price',
                label: 'Price',
                type: AppTextFieldType.priceJP,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Price'), findsOneWidget);
      expect(find.text('¥'), findsOneWidget);
    });

    testWidgets('should display price US field with dollar prefix', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FormBuilder(
              key: GlobalKey<FormBuilderState>(),
              child: AppTextField(
                name: 'price',
                label: 'Price',
                type: AppTextFieldType.priceUS,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Price'), findsOneWidget);
      expect(find.text('\$'), findsOneWidget);
    });

    testWidgets('should display password field with visibility toggle', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FormBuilder(
              key: GlobalKey<FormBuilderState>(),
              child: AppTextField(
                name: 'password',
                label: 'Password',
                type: AppTextFieldType.password,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Password'), findsOneWidget);
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    });

    testWidgets('should display email field correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FormBuilder(
              key: GlobalKey<FormBuilderState>(),
              child: AppTextField(
                name: 'email',
                label: 'Email',
                type: AppTextFieldType.email,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Email'), findsOneWidget);
      expect(find.byType(FormBuilderTextField), findsOneWidget);
    });

    testWidgets('should display multiline field correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FormBuilder(
              key: GlobalKey<FormBuilderState>(),
              child: AppTextField(
                name: 'description',
                label: 'Description',
                type: AppTextFieldType.multiline,
                maxLines: 5,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Description'), findsOneWidget);
      expect(find.byType(FormBuilderTextField), findsOneWidget);
    });

    testWidgets('should display number field correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FormBuilder(
              key: GlobalKey<FormBuilderState>(),
              child: AppTextField(
                name: 'number',
                label: 'Number',
                type: AppTextFieldType.number,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Number'), findsOneWidget);
      expect(find.byType(FormBuilderTextField), findsOneWidget);
    });

    testWidgets('should display phone field correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FormBuilder(
              key: GlobalKey<FormBuilderState>(),
              child: AppTextField(
                name: 'phone',
                label: 'Phone',
                type: AppTextFieldType.phone,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Phone'), findsOneWidget);
      expect(find.byType(FormBuilderTextField), findsOneWidget);
    });

    testWidgets('should display URL field correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FormBuilder(
              key: GlobalKey<FormBuilderState>(),
              child: AppTextField(
                name: 'url',
                label: 'Website',
                type: AppTextFieldType.url,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Website'), findsOneWidget);
      expect(find.byType(FormBuilderTextField), findsOneWidget);
    });

    testWidgets('should handle different field types', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FormBuilder(
              key: GlobalKey<FormBuilderState>(),
              child: Column(
                children: [
                  AppTextField(
                    name: 'email',
                    label: 'Email',
                    type: AppTextFieldType.email,
                  ),
                  AppTextField(
                    name: 'password',
                    label: 'Password',
                    type: AppTextFieldType.password,
                  ),
                  AppTextField(
                    name: 'number',
                    label: 'Number',
                    type: AppTextFieldType.number,
                    suffixText: 'min',
                  ),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('Number'), findsOneWidget);
      expect(find.text('min'), findsOneWidget);
      expect(find.byType(FormBuilderTextField), findsNWidgets(3));
    });
  });
}
