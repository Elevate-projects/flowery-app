import 'package:flowery_app/presentation/terms_and_conditions/views_model/terms_and_conditions_cubit.dart';
import 'package:flowery_app/presentation/terms_and_conditions/views_model/terms_and_conditions_state.dart';
import 'package:flowery_app/utils/common_widgets/loading_circle.dart';
import 'package:flowery_app/utils/flowery_method_helper.dart';
import 'package:flowery_app/utils/loaders/loaders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TermsAndConditionsViewBody extends StatelessWidget {
  const TermsAndConditionsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isArabic = false;
    final theme = Theme.of(context);
    return BlocConsumer<TermsAndConditionsCubit, TermsAndConditionsState>(
      listener: (context, state) {
        if (state.termsAndConditionsStatus.isFailure) {
          Loaders.showErrorMessage(
            message: state.termsAndConditionsStatus.error?.message ?? "",
            context: context,
          );
        }
      },
      builder: (context, state) =>
          (state.termsAndConditionsStatus.data != null &&
              (state.termsAndConditionsStatus.data?.isNotEmpty ?? false) &&
              !state.termsAndConditionsStatus.isLoading)
          ? ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.termsAndConditionsStatus.data!.length,
              itemBuilder: (context, index) {
                final section = state.termsAndConditionsStatus.data![index];

                final content = section['content'];
                final text = (content is Map)
                    ? content[isArabic ? 'ar' : 'en']
                    : content.toString();

                final title = section['title'];
                final titleText = title != null
                    ? (title is Map
                          ? title[isArabic ? 'ar' : 'en']
                          : title.toString())
                    : null;

                final style = section['style'];
                final textStyle = FloweryMethodHelper.parseTextStyle(
                  style is Map ? style : null,
                );
                final align = FloweryMethodHelper.parseAlignment(
                  style,
                  isArabic,
                );

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (titleText != null)
                      Text(
                        titleText,
                        style: FloweryMethodHelper.parseTextStyle(
                          style?['title'],
                        ),
                        textAlign: FloweryMethodHelper.parseAlignment(
                          style?['title'],
                          isArabic,
                        ),
                      ),
                    if (text is List)
                      ...text.map<Widget>((contentText) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            contentText,
                            style: FloweryMethodHelper.parseTextStyle(
                              style?['content'] ?? style,
                            ),
                            textAlign: FloweryMethodHelper.parseAlignment(
                              style?['content'] ?? style,
                              isArabic,
                            ),
                          ),
                        );
                      }),
                    if (text is String)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(text, style: textStyle, textAlign: align),
                      ),
                    const SizedBox(height: 16),
                  ],
                );
              },
            )
          : LoadingCircle(circleColor: theme.colorScheme.primary),
    );
  }
}
