

import 'package:fintrack/core/presentaion/state_renderer_type.dart';
import 'package:flutter/material.dart';

class StateRenderer extends StatelessWidget {
  const StateRenderer({
    super.key,
    required this.stateRendererType,
    required this.widgetLoading,
    required this.titleError,
    required this.onPressedRetry,
    this.titleEmpty,
  });

  final StateRendererType stateRendererType;
  final Widget widgetLoading;
  final String titleError;
  final String? titleEmpty;
  final void Function()? onPressedRetry;

  @override
  Widget build(BuildContext context) {
    //TODO ADD FLUTTER TOST WITH LOTTIE ANIMATION
    switch (stateRendererType) {
      case StateRendererType.screenLoadingState:
        return widgetLoading;
      case StateRendererType.screenErrorState:
        return Container();
      case StateRendererType.emptyState:
        return Container();
      case StateRendererType.contentState:
        return SizedBox.shrink();
    }
  }
}
