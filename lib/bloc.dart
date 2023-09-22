import 'dart:async';
import 'dart:math';

class Bloc {
  final _resultController = StreamController<String>.broadcast();

  Stream<String> get resultStream => _resultController.stream;

  void solveQuadraticEquation(double a, double b, double c) {
    if (a == 0) {
      _resultController.sink.add('Hệ số a phải khác 0');
      return;
    }

    final delta = b * b - 4 * a * c;

    if (delta > 0) {
      final x1 = (-b + sqrt(delta)) / (2 * a);
      final x2 = (-b - sqrt(delta)) / (2 * a);
      _resultController.sink.add('Phương trình có 2 nghiệm phân biệt: x1 = $x1, x2 = $x2');
    } else if (delta == 0) {
      final x = -b / (2 * a);
      _resultController.sink.add('Phương trình có nghiệm kép: x = $x');
    } else {
      _resultController.sink.add('Phương trình vô nghiệm');
    }
  }

  void dispose() {
    _resultController.close();
  }
}

final bloc = Bloc();