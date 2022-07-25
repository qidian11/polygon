class SphereUtil {
  static List<List<double>>? pixels;
  static SphereUtil instance = SphereUtil._internal();
  SphereUtil._internal();
  factory SphereUtil() {
    return instance;
  }
}
