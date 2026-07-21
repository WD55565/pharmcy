import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/assistant/presentation/widgets/assistant_launcher.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/onboarding/presentation/providers/onboarding_provider.dart';
import '../../features/onboarding/presentation/screens/onboarding_flow_screen.dart';
import '../../features/pharmacy/presentation/screens/pharmacy_detail_screen.dart';
import 'route_paths.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: RoutePaths.home,
    // First visit only: bounce `/` to the onboarding flow until it's been
    // completed, and bounce `/onboarding` back to `/` once it has (e.g. a
    // stale bookmark/back-navigation on a returning visit).
    redirect: (context, state) {
      final completed = ref.read(onboardingCompletedProvider);
      final atOnboarding = state.matchedLocation == RoutePaths.onboarding;
      if (!completed && !atOnboarding) return RoutePaths.onboarding;
      if (completed && atOnboarding) return RoutePaths.home;
      return null;
    },
    routes: [
      // Deliberately outside the ShellRoute below — the onboarding screens
      // are full-bleed and shouldn't show the assistant FAB.
      GoRoute(
        path: RoutePaths.onboarding,
        name: RouteNames.onboarding,
        pageBuilder: (context, state) => _fadeThroughPage(
          state,
          OnboardingFlowScreen(onComplete: () => context.go(RoutePaths.home)),
        ),
      ),
      // ShellRoute wraps every nested route's page with a persistent
      // widget — used here to layer the assistant FAB/panel on every
      // screen. Critically, this keeps it a genuine descendant of
      // GoRouter's own Navigator/Overlay, rather than the app.dart
      // `MaterialApp.builder` + manual `Overlay` approach previously used,
      // which nested a *second*, competing Overlay outside the Router's
      // own — that mismatch corrupted the launcher's layout (a caught
      // "RenderBox was not laid out" error) so it still painted but no
      // longer responded to taps.
      ShellRoute(
        builder: (context, state, child) {
          return Stack(children: [child, const AssistantLauncher()]);
        },
        routes: [
          GoRoute(
            path: RoutePaths.home,
            name: RouteNames.home,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: RoutePaths.pharmacyDetail,
            name: RouteNames.pharmacyDetail,
            // A malformed or tampered deep link (e.g. `/pharmacy/abc`) must
            // not crash navigation — redirect home instead of reaching the
            // builder.
            redirect: (context, state) {
              final id = int.tryParse(state.pathParameters['id'] ?? '');
              return id == null ? RoutePaths.home : null;
            },
            pageBuilder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return _fadeThroughPage(
                state,
                PharmacyDetailScreen(pharmacyId: id),
              );
            },
          ),
        ],
      ),
    ],
  );
}

/// A fade + slide-up + gentle scale transition, used instead of GoRouter's
/// default (platform-dependent, sometimes instant on web/desktop) page
/// transition — tuned to read as a deliberate, cinematic hand-off rather
/// than an instant cut, while staying short enough not to feel sluggish.
CustomTransitionPage<void> _fadeThroughPage(GoRouterState state, Widget child) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 320),
    reverseTransitionDuration: const Duration(milliseconds: 260),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween(
            begin: const Offset(0, 0.06),
            end: Offset.zero,
          ).animate(curved),
          child: ScaleTransition(
            scale: Tween(begin: 0.98, end: 1.0).animate(curved),
            child: child,
          ),
        ),
      );
    },
  );
}
