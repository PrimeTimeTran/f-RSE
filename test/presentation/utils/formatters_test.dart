import 'package:flutter_test/flutter_test.dart';

import 'package:rse/all.dart';

void main() {
  testFormatMoney();
  // testFormatPercent();
  testFormatPercentage();
  testChooseFormat();
  testFormatValueChange();
}

void testFormatMoney() {
  test('formatMoney', () {
    expect(formatMoney(1000), equals('\$1,000.00'));
    expect(formatMoney(5000.5), equals('\$5,000.50'));
    expect(formatMoney('3000'), equals('\$3,000.00'));
    expect(formatMoney('7,500.75'), equals('\$7,500.75'));
  });
}

void testFormatPercent() {
  test('formatPercent', () {
    expect(formatPercent(0.5), equals('50.00%'));
    expect(formatPercent(0.12345), equals('12.35%'));
    expect(formatPercent(-0.75), equals('-75.00%'));
  });
}

void testFormatPercentage() {
  test('formatPercentage', () {
    expect(formatPercentage(0.5), equals('+ 0.50 %'));
    expect(formatPercentage(-0.75), equals('- 0.75 %'));
    expect(formatPercentage(1.234), equals('+ 1.23 %'));
  });
}

void testChooseFormat() {
  test('chooseFormat', () {
    expect(
      chooseFormat('live', '2023-07-07 14:30:00'),
      equals('2:30PM'),
    );
    expect(
      chooseFormat('1d', '2023-07-07 10:00:00'),
      equals('10:00AM'),
    );
    expect(
      chooseFormat('1w', '2023-07-01 18:45:00'),
      equals('06:45PM, Jul 1'),
    );
    expect(
      chooseFormat('1m', '2023-06-15 09:30:00'),
      equals('09:30AM, Jun 15'),
    );
    expect(
      chooseFormat('3m', '2023-04-01 12:00:00'),
      equals('Apr 1, 2023'),
    );
    expect(
      chooseFormat('1y', '2022-07-07 00:00:00'),
      equals('Jul 7, 2022'),
    );
    expect(
      chooseFormat('ytd', '2023-01-01 00:00:00'),
      equals('Jan 1, 2023'),
    );
    expect(
      chooseFormat('invalid', '2023-07-07 12:00:00'),
      equals('7/7/2023'),
    );
  });
}

void testFormatValueChange() {
  test('formatValueChange', () {
    expect(formatValueChange(100.5, 50.2), equals('+ \$50.30'));
    expect(formatValueChange(75, 100), equals('- \$25.00'));
    expect(formatValueChange(500, 500), equals('+ \$0.00'));
  });
}
