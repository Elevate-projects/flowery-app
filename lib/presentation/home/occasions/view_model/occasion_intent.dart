import 'package:flowery_app/domain/entities/arguments/occasion_arguments_entity.dart';

sealed class OccasionIntent {}

class LoadOccasionProducts extends OccasionIntent {
  final OccasionArgumentsEntity occasionData;
  LoadOccasionProducts({required this.occasionData});
}
