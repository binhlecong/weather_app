class MyConvertion {
  static double kelvinToCelsius(temp) {
    return temp - 273.15;
  }

  static double kelvinToFahrenheit(temp) {
    return temp * 9 / 5 - 459.67;
  }

  static double kmphToMiph(kmph) {
    return kmph * 0.621371192237334;
  }

  static double miphToKmph(miph) {
    return miph * 1.609344;
  }

  static double mpsToKmph(mps) {
    return mps * 3.6;
  }

  static double mpsToMiph(mps) {
    return kmphToMiph(mpsToKmph(mps));
  }
}
