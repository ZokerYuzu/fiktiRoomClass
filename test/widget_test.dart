import 'package:flutter_test/flutter_test.dart';
import 'package:fikti_room_class/app.dart';

void main() {
  testWidgets('App initialization test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());
    
    // Verifies that the app compiles and pumps successfully.
    expect(true, isTrue);
  });
}
