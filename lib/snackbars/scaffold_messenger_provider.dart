import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final scaffoldMessengerKey = Provider(
  (_) => GlobalKey<ScaffoldMessengerState>(),
);
