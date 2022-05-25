/*
import 'package:deliveryapp/Screen/Login/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget testableWidget({ Widget? child}){
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('Login_test', (WidgetTester tester) async {
    LoginPage page = LoginPage();
    await tester.pumpWidget(testableWidget(child:page));
    final emailTextField = find.byKey(ValueKey("login_email"));
    final passwordTextField = find.byKey(ValueKey("password"));
    final submit = find.textContaining("Login");
    var textField = find.byType(TextField);
    expect(textField, findsNWidgets(2));
    expect(emailTextField, findsOneWidget);
    expect(passwordTextField, findsOneWidget);
    await tester.enterText(emailTextField, 'billy@deliveryapp.com');
    await tester.enterText(passwordTextField, 'testtest');
    expect(find.text('billy@deliveryapp.com'),findsOneWidget);
    expect(find.text('testtest'),findsOneWidget);
    var button= find.text("Login");
    expect(button,findsOneWidget);
    await tester.tap(button);
    await tester.pump();
    expect(submit, "successfull");
  }
  );
}*/
