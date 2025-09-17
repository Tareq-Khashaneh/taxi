// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:openkm_mobile/features/dashboard/presentation/screens/dashboard_screen.dart';
// import 'package:openkm_mobile/features/search/presentation/blocs/cubits/date_range_cubit.dart';
// import 'package:openkm_mobile/features/search/presentation/screens/search_screen.dart';
// import '../../features/search/presentation/blocs/cubits/form_validate_cubit.dart';
// import '../../features/search/presentation/blocs/search_bloc.dart';
// import '../constants/api_endpoint.dart';
// import '../constants/app_colors.dart';
// import '../injections/init.dart';
//
// class AppDrawer extends StatelessWidget {
//   const AppDrawer({super.key});
//
//   void _navigateTo(BuildContext context, Widget pageName) {
//     Navigator.of(context).pop(); // Close drawer
//     Navigator.push(context, MaterialPageRouteEntity(builder: (context) => pageName));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           const DrawerHeader(
//             decoration: BoxDecoration(
//                 color: AppColors.surface,
//                 image: DecorationImage(
//                     image: NetworkImage(Api.logo), fit: BoxFit.contain)),
//             child: SizedBox(),
//           ),
//           ListTile(
//             leading: const Icon(Icons.dashboard),
//             title: const Text('Dashboard'),
//             onTap: () => _navigateTo(context, const DashboardScreen()),
//           ),
//           ListTile(
//             leading: const Icon(Icons.search),
//             title: const Text('Search'),
//             onTap: () => _navigateTo(
//                 context,
//                 MultiBlocProvider(
//                   providers: [
//                     BlocProvider(
//                       create: (context) => SearchBloc(sl()),
//                     ),
//                     BlocProvider(
//                       create: (context) => FormValidationCubit(),
//                     ),
//                     BlocProvider(
//                       create: (context) => DateRangeCubit(),
//                     ),
//                   ],
//                   child: SearchScreen(),
//                 )),
//           ),
//         ],
//       ),
//     );
//   }
// }
