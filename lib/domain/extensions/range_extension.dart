extension Range on num {
  bool isBetween(num min, num max) => min <= this && this <= max;
}
