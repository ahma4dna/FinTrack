String formatNumber(double value) {
  return value % 1 == 0 ? value.toInt().toString() : value.toString();
}
