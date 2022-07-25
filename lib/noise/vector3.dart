import 'dart:math';

class Vector3 {
  double x;
  double y;
  double z;
  double get length => sqrt(x * x + y * y + z * z);
  Vector3(this.x, this.y, this.z);
  double dot(Vector3 a) {
    return a.x * x + a.y * y + a.z * z;
  }
}
