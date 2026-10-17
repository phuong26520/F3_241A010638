import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:f3_form/main.dart';

void main() {
  Future<void> moForm(WidgetTester tester) async {
    await tester.binding.setSurfaceSize(const Size(800, 2400));
    await tester.pumpWidget(const MaterialApp(home: RegisterPage()));
    await tester.pumpAndSettle();
  }

  testWidgets('Form trong bao loi dung chuan', (WidgetTester tester) async {
    await moForm(tester);

    await tester.tap(find.widgetWithText(FilledButton, 'ĐĂNG KÝ'));
    await tester.pumpAndSettle();

    expect(find.text('Vui lòng nhập họ tên'), findsOneWidget);
    expect(find.text('Vui lòng nhập MSSV'), findsOneWidget);
    expect(find.text('Vui lòng nhập email'), findsOneWidget);
    expect(find.text('Hãy chọn một học phần'), findsOneWidget);
    expect(find.text('Hãy chọn ít nhất một buổi học'), findsOneWidget);
  });

  testWidgets('Mssv sai dinh dang thi bao loi', (WidgetTester tester) async {
    await moForm(tester);

    await tester.enterText(find.widgetWithText(TextFormField, 'Mã số sinh viên *'), '123');
    await tester.pumpAndSettle();
    expect(find.text('MSSV phải gồm đúng 10 chữ số'), findsOneWidget);
  });

  testWidgets('Nhap dung thi hien hop thoai tom tat', (WidgetTester tester) async {
    await moForm(tester);

    await tester.enterText(find.widgetWithText(TextFormField, 'Họ và tên *'), 'Nguyen Hoai Phuong');
    await tester.enterText(find.widgetWithText(TextFormField, 'Mã số sinh viên *'), '2410106387');
    await tester.enterText(find.widgetWithText(TextFormField, 'Email *'), 'phuong@example.com');
    await tester.pumpAndSettle();

    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Cơ sở dữ liệu').last);
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(CheckboxListTile, 'Sáng'));
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(FilledButton, 'ĐĂNG KÝ'));
    await tester.pumpAndSettle();

    expect(find.text('Xác nhận đăng ký'), findsOneWidget);
    expect(find.textContaining('MSSV: 2410106387'), findsOneWidget);
    expect(find.textContaining('Học phần: Cơ sở dữ liệu'), findsOneWidget);
    expect(find.textContaining('Buổi học: Sáng'), findsOneWidget);
    expect(find.textContaining('Số tín chỉ: 15'), findsOneWidget);
  });

  testWidgets('Lam lai dua form ve mac dinh', (WidgetTester tester) async {
    await moForm(tester);

    await tester.enterText(find.widgetWithText(TextFormField, 'Họ và tên *'), 'Nguyen Van B');
    await tester.tap(find.widgetWithText(CheckboxListTile, 'Tối'));
    await tester.drag(find.byType(Slider), const Offset(300, 0));
    await tester.pumpAndSettle();
    expect(find.text('Số tín chỉ đăng ký: 15'), findsNothing);

    await tester.tap(find.widgetWithText(OutlinedButton, 'Làm lại'));
    await tester.pumpAndSettle();

    expect(find.text('Nguyen Van B'), findsNothing);
    expect(find.text('Số tín chỉ đăng ký: 15'), findsOneWidget);
    final checkbox = tester.widget<CheckboxListTile>(find.widgetWithText(CheckboxListTile, 'Tối'));
    expect(checkbox.value, isFalse);
  });
}
