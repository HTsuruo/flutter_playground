import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final navigatorKey = Provider(
  (_) => GlobalKey<NavigatorState>(),
);
