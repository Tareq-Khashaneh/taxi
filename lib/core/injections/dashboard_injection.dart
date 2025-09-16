// import 'package:openkm_mobile/core/injections/init.dart';
// import 'package:openkm_mobile/features/dashboard/data/data_sources/remote_data_source.dart';
// import 'package:openkm_mobile/features/dashboard/data/repositories/dashboard_repo_impl.dart';
// import 'package:openkm_mobile/features/dashboard/domain/repositories/dashboard_repo.dart';
// import 'package:openkm_mobile/features/dashboard/domain/usecases/downloaded_documents.dart';
// import 'package:openkm_mobile/features/dashboard/domain/usecases/get_last_modified_documents.dart';
// import 'package:openkm_mobile/features/dashboard/domain/usecases/get_last_month_top_documents_use_case.dart';
// import 'package:openkm_mobile/features/dashboard/domain/usecases/get_last_month_top_downloaded_documents_use_case.dart';
// import 'package:openkm_mobile/features/dashboard/domain/usecases/get_last_week_top_modified_documents_use_case.dart';
// import 'package:openkm_mobile/features/dashboard/domain/usecases/get_subscribed_folders.dart';
// import 'package:openkm_mobile/features/dashboard/domain/usecases/get_user_checked_out_documents_use_case.dart';
// import 'package:openkm_mobile/features/dashboard/domain/usecases/get_user_last_imported_mails_use_case.dart';
// import 'package:openkm_mobile/features/dashboard/domain/usecases/locked_documents.dart';
// import 'package:openkm_mobile/features/dashboard/domain/usecases/subscribed_documents.dart';
// import 'package:openkm_mobile/features/dashboard/domain/usecases/uploaded_documents.dart';
// import 'package:openkm_mobile/features/dashboard/presentation/blocs/downloaded_documents_bloc/product_bloc.dart';
// import 'package:openkm_mobile/features/dashboard/presentation/blocs/last_modified_document_bloc/last_modified_document_bloc.dart';
// import 'package:openkm_mobile/features/dashboard/presentation/blocs/last_month_top_downloaded_bloc/last_month_top_downloaded_document_bloc.dart';
// import 'package:openkm_mobile/features/dashboard/presentation/blocs/last_month_top_modified_documents_bloc/last_month_top_modified_docs_bloc.dart';
// import 'package:openkm_mobile/features/dashboard/presentation/blocs/last_week_top_modified_document_bloc/last_week_top_modified_document_bloc.dart';
// import 'package:openkm_mobile/features/dashboard/presentation/blocs/locked_document_bloc/locked_documents_bloc.dart';
// import 'package:openkm_mobile/features/dashboard/presentation/blocs/subscribed_documents_bloc/subscribed_documents_bloc.dart';
// import 'package:openkm_mobile/features/dashboard/presentation/blocs/subscribed_folder_bloc/subscribed_folder_bloc.dart';
// import 'package:openkm_mobile/features/dashboard/presentation/blocs/uploaded_documents_bloc/uploaded_documents_bloc.dart';
// import 'package:openkm_mobile/features/dashboard/presentation/blocs/user_checked_out_document_bloc/user_checked_out_document_bloc.dart';
// import 'package:openkm_mobile/features/dashboard/presentation/blocs/user_last_imported_mails_bloc/user_last_imported_mails_bloc.dart';
// import 'package:openkm_mobile/features/workflow/domain/usecases/approve_task.dart';
// import 'package:openkm_mobile/features/workflow/domain/usecases/get_tasks_usecase.dart';
// import 'package:openkm_mobile/features/workflow/presentation/bloc/tasks_bloc.dart';
//
// import '../../features/workflow/data/datasource/task_datasource.dart';
// import '../../features/workflow/data/datasource/task_datasource_impl.dart';
// import '../../features/workflow/data/repository/tasks_repository_impl.dart';
// import '../../features/workflow/domain/repository/tasks_repository.dart';
// import '../constants/storage_service.dart';
// import '../utils/network/network_checker.dart';
// import '../utils/network/network_service.dart';
//
// Future<void> init() async {
//   //remote data source and dashboard
//   sl.registerLazySingleton<DashboardRepo>(() => DashboardRepoImpl(sl(), sl()));
//   sl.registerLazySingleton<DashboardRemoteDataSource>(
//       () => DashboardRemoteDataSourceImpl(sl(), sl()));
//   //blocs
//   sl.registerFactory<SubscribedFolderBloc>(() => SubscribedFolderBloc(sl()));
//   sl.registerFactory<UserCheckedOutDocumentBloc>(
//       () => UserCheckedOutDocumentBloc(sl()));
//   sl.registerFactory<LastWeekTopModifiedDocumentBloc>(
//       () => LastWeekTopModifiedDocumentBloc(sl()));
//   sl.registerFactory<LastMonthTopDownloadedDocumentBloc>(
//       () => LastMonthTopDownloadedDocumentBloc(sl()));
//   sl.registerFactory<LastModifiedDocumentBloc>(
//       () => LastModifiedDocumentBloc(sl()));
//   sl.registerFactory<DownloadedDocumentsBloc>(
//       () => DownloadedDocumentsBloc(sl()));
//
//   sl.registerFactory<UploadedDocumentsBloc>(() => UploadedDocumentsBloc(sl()));
//   sl.registerFactory<LockedDocumentsBloc>(
//       () => LockedDocumentsBloc(sl(),));
//   sl.registerFactory<SubscribedDocumentsBloc>(
//           () => SubscribedDocumentsBloc(sl(),));
//   sl.registerFactory<LastMonthTopModifiedDocsBloc>(
//       () => LastMonthTopModifiedDocsBloc(sl()));
//   sl.registerFactory<UserLastImportedMailsBloc>(
//           () => UserLastImportedMailsBloc(sl()));
//   //useCases
//   sl.registerLazySingleton(() => GetSubscribedFoldersUseCase(sl()));
//   sl.registerLazySingleton(() => GetLastWeekTopModifiedDocumentsUseCase(sl()));
//   sl.registerLazySingleton(() => GetUserCheckedOutDocumentsUseCase(sl()));
//   sl.registerLazySingleton(
//       () => GetLastMonthTopDownloadedDocumentsUseCase(sl()));
//   sl.registerLazySingleton(() => GetLastModifiedDocumentsUseCase(sl()));
//   sl.registerLazySingleton(() => LockedDocumentsUseCase(sl()));
//   sl.registerLazySingleton(() => SubscribedDocumentsUseCase(sl()));
//   sl.registerLazySingleton(() => UploadedDocumentsUseCase(sl()));
//   sl.registerLazySingleton(() => DownloadedDocumentsUseCase(sl()));
//   sl.registerLazySingleton(() => GetLastMonthTopDocumentsUseCase(sl()));
//   sl.registerLazySingleton(() => GetUserLastImportedMailsUseCase(sl()));
//   //workflow
//   sl.registerLazySingleton<TaskDataSource>(()=>TaskDataSourceImpl(sl<NetworkService>(), sl<StorageService>()));
//   sl.registerLazySingleton<TasksRepository>(()=>TasksRepositoryImpl(sl<TaskDataSource>(), sl<NetworkInfo>()));
//   sl.registerLazySingleton<GetTasksUseCase>(()=>GetTasksUseCase(sl<TasksRepository>()));
//   sl.registerLazySingleton<ApplyTransitionUseCase>(()=>ApplyTransitionUseCase(sl<TasksRepository>()));
//   sl.registerLazySingleton<TasksBloc>(()=>TasksBloc(sl<GetTasksUseCase>(),sl<ApplyTransitionUseCase>()));
// }
