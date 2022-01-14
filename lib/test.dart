void main() {
  final dynamic a = '';
  try {
    final b = a as List;
  } catch (e) {
    print(e is TypeError);
  }
}
