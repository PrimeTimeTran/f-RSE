import 'package:intl/intl.dart';

String formatMoney(value) {
  value = value.toString();
  final numberFormat = NumberFormat.currency(symbol: '\$');
  final moneyValue = double.parse(value.replaceAll(',', ''));
  return numberFormat.format(moneyValue);
}

String formatField(data, field) {
  switch (field) {
    case 'name':
      return data.name;
    case 'value' || 'totalValue':
      return formatMoney(data.getValue(field).toString());
    case 'quantity':
      return data.quantity.toString();
    default:
      return "${data.getValue(field)}%";
  }
}

String formatPercent(double value) {
  return '${(value * 100).toStringAsFixed(2)}%';
}

String formatPercentage(double gainLoss) {
  String sign = (gainLoss >= 0) ? '+' : '-';
  double absoluteChange = gainLoss.abs();
  return '$sign ${absoluteChange.toStringAsFixed(2)} %';
}

String chooseFormat(String period, time) {
  final map = {
    'live': 'h:mma',
    '1d': 'h:mma',
    '1w': 'hh:mma, MMM d',
    '1m': 'hh:mma, MMM d',
    '3m': 'MMM d, yyyy',
    '1y': 'MMM d, yyyy',
    'ytd': 'MMM d, yyyy',
  };

  final dateFormat = map[period] ?? 'yMd';
  if (period == '1w' || period == '1m') {
    return DateFormat(dateFormat).format(DateTime.parse(time)).toString();
  }
  return DateFormat(dateFormat).format(DateTime.parse(time)).toString();
}

String formatValueChange(double newValue, double oldValue) {
  double valueChange = newValue - oldValue;
  String sign = (valueChange >= 0) ? '+' : '-';
  double absoluteChange = valueChange.abs();
  return '$sign ${formatMoney(absoluteChange.toStringAsFixed(2))}';
}