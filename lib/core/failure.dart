// used to give error message

class Failure implements Exception {
  final String message;

  Failure({required this.message});

  @override
  String toString() => message;
}
