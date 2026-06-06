import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

/// Global service locator instance used across the app.
///
/// GetIt is responsible for:
/// - Dependency injection
/// - Managing singletons
/// - Providing services, cubits, and repositories
final getIt = GetIt.instance;

/// Initializes dependency injection using Injectable.
///
/// This function generates and registers all dependencies
/// defined with @injectable, @singleton, etc.
///
/// Must be called before running the app (usually in main()).
@InjectableInit(
  initializerName: 'init', // generated function name
  preferRelativeImports: true,
  asExtension: true,
)
void configureDependencies() => getIt.init();