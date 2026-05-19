import 'package:flutter_test/flutter_test.dart';

import 'package:otogaleri_mobile/main.dart';

void main() {
  testWidgets('Araç listesi ekranı açılır', (WidgetTester tester) async {
    await tester.pumpWidget(const OtogaleriApp());
    await tester.pumpAndSettle();

    expect(find.text('Araçlar'), findsOneWidget);
  });
}
