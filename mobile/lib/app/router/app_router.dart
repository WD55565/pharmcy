import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/pharmacy/presentation/screens/pharmacy_detail_screen.dart';
import 'route_paths.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: RoutePaths.home,
    routes: [
      GoRoute(
        path: RoutePaths.home,
        name: RouteNames.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: RoutePaths.pharmacyDetail,
        name: RouteNames.pharmacyDetail,
        // A malformed or tampered deep link (e.g. `/pharmacy/abc`) must not
        // crash navigation — redirect home instead of reaching the builder.
        redirect: (context, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '');
          return id == null ? RoutePaths.home : null;
        },
        pageBuilder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return _fadeThroughPage(state, PharmacyDetailScreen(pharmacyId: id));
        },
      ),
    ],
  );
}

/// A subtle fade + slide-up transition, used instead of GoRouter's default
/// (platform-dependent, sometimes instant on web/desktop) page transition.
CustomTransitionPage<void> _fadeThroughPage(GoRouterState state, Widget child) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 250),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOut);
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween(begin: const Offset(0, 0.04), end: Offset.zero).animate(curved),
          child: child,
        ),
      );
    },
  );
}
