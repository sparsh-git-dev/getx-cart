import 'package:flutter/material.dart';

import '../resources/theme.dart';

extension BuildContextX on BuildContext {
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
  Orientation get appOrientation => MediaQuery.of(this).orientation;
  Size get size => MediaQuery.of(this).size;
  CustomTheme get appTextTheme => AppTheme.of(this);
}
