import 'package:dog_bluetooth_user/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  group('RandomUserWidget', () {
    late MockHttpClient mockHttpClient;

    setUp(() {
      mockHttpClient = MockHttpClient();
    });

    testWidgets('Displays user information correctly',
        (WidgetTester tester) async {
      const responseBody = '''
        {
          "results": [
            {
              "name": {
                "first": "John",
                "last": "Doe"
              },
              "location": {
                "city": "New York",
                "country": "USA"
              },
              "email": "johndoe@example.com",
              "dob": {
                "date": "1990-01-01"
              },
              "registered": {
                "date": "2022-06-01"
              },
              "picture": {
                "large": "https://example.com/profile.jpg"
              }
            }
          ]
        }
      ''';

      when(mockHttpClient.get(Uri.parse('https://randomuser.me/api/')))
          .thenAnswer((_) async => http.Response(responseBody, 200));

      await tester.pumpWidget(Profile(httpClient: mockHttpClient));

      expect(find.text('Name: John Doe'), findsOneWidget);
      expect(find.text('Location: New York, USA'), findsOneWidget);
      expect(find.text('Email: johndoe@example.com'), findsOneWidget);
      expect(find.text('Date of Birth: 1990-01-01'), findsOneWidget);
      expect(find.text('Number of days since registered: 23'), findsOneWidget);
      expect(find.byType(CircleAvatar), findsOneWidget);
    });

    testWidgets('Displays placeholder when user information is empty',
        (WidgetTester tester) async {
      const responseBody = '''
        {
          "results": []
        }
      ''';

      when(mockHttpClient.get(Uri.parse('https://randomuser.me/api/')))
          .thenAnswer((_) async => http.Response(responseBody, 200));

      await tester.pumpWidget(Profile(httpClient: mockHttpClient));

      expect(find.text('Name: '), findsOneWidget);
      expect(find.text('Location: '), findsOneWidget);
      expect(find.text('Email: '), findsOneWidget);
      expect(find.text('Date of Birth: '), findsOneWidget);
      expect(find.text('Number of days since registered: 0'), findsOneWidget);
      expect(find.byType(CircleAvatar), findsNothing);
    });

    testWidgets('Displays error message when API request fails',
        (WidgetTester tester) async {
      when(mockHttpClient.get(Uri.parse('https://randomuser.me/api/')))
          .thenAnswer((_) async => http.Response('Error', 500));

      await tester.pumpWidget(Profile(httpClient: mockHttpClient));

      expect(find.text('Failed to load user information'), findsOneWidget);
      expect(find.byType(CircleAvatar), findsNothing);
    });
  });
}
