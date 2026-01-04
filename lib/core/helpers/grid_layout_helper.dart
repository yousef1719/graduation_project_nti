class GridLayoutHelper {
  static double productAspectRatio({
    required double screenWidth,
    int crossAxisCount = 2,
    double padding = 8,
    double spacing = 16,
    double? heightFactor,
  }) {
    final gridWidth =
        screenWidth - (padding * 2) - ((crossAxisCount - 1) * spacing);

    final itemWidth = gridWidth / crossAxisCount;
    final imageHeight = itemWidth;
    final textHeight = 20 + 18 + 8;
    final buttonRowHeight = 30;
    final itemHeight = imageHeight + textHeight + buttonRowHeight;

    return itemWidth / itemHeight;
  }
}
