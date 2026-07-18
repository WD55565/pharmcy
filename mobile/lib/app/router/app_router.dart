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
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return PharmacyDetailScreen(pharmacyId: id);
        },
      ),
    ],
  );
}
