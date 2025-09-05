sealed class OccasionIntent {}

class LoadOccasionProducts extends OccasionIntent {
  final String occasionId;

  LoadOccasionProducts(this.occasionId);
}
