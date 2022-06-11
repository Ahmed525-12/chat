import 'package:chat/screens/base/base_nav.dart';
import 'package:flutter/cupertino.dart';

class BaseViewModel<BN extends BaseNavigator> extends ChangeNotifier {
  BN? baseNavigator;
}
