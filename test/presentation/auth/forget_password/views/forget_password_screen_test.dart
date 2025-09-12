import 'package:flowery_app/presentation/auth/forget_password/views/forget_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets("Verify Structure", (WidgetTester tester) async {

    await tester.pumpWidget(const MaterialApp(home: ForgetPasswordScreen(),));
    expect(find.byType(AppBar), findsNWidgets(1));
    expect(find.byType(Text), findsNWidgets(5));
    expect(find.byType(TextFormField), findsNWidgets(1));
    expect(find.bySemanticsLabel("Email"), findsNWidgets(1));
     expect(find.text("password"), findsNWidgets(1));
    expect(find.text("Please enter your email associated to your account"), findsNWidgets(1));


  });
  testWidgets('Test forget password behaviour with empty fields', (WidgetTester tester)async{

    await tester.pumpWidget(const MaterialApp(home: ForgetPasswordScreen(),));
    await tester.tap(find.byKey(const Key('')));
    await tester.pump();
    expect(find.byType(Text),findsNWidgets(6));
    expect(find.text('Please enter your password'), findsNWidgets(1));

  });
}
