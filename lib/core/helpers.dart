double remapDouble(
    double value, double min1, double max1, double min2, double max2) {
  return min2 + (value - min1) * (max2 - min2) / (max1 - min1);
}
