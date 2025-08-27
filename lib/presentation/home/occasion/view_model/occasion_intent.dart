sealed class OccasionIntent {}

class LoadOccasionProducts extends OccasionIntent {
  final String occasionName;
  LoadOccasionProducts(this.occasionName);
}
