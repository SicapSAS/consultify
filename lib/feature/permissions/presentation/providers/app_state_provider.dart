import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

final appStateProvider = StateProvider.autoDispose<AppLifecycleState>((ref) {
  return AppLifecycleState.resumed;
  
});