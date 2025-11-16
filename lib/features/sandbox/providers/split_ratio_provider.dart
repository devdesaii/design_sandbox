import 'package:flutter_riverpod/flutter_riverpod.dart';

final splitRatioProvider = NotifierProvider<SplitRatioNotifier, double>(
  SplitRatioNotifier.new,
);
double defaultRatio = 0.3;
double minratio = 0.3;
double maxratio = 0.7;
class SplitRatioNotifier extends Notifier<double> {
  @override
  double build() {
    return defaultRatio;
  }

  void updateRatio(double verticalOffset, double totalHeight) {
    state = (state + verticalOffset / totalHeight).clamp(minratio, maxratio);
  }
}
