int castToInt(dynamic x) {
  if (x is int) return x;
  if (x is String) return int.parse(x);
  return -1;
}
