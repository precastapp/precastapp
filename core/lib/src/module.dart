import 'package:core/core.dart';
import 'package:flutter_modular/flutter_modular.dart' as modular;

class ModuleApp extends modular.ModularApp {
  final Module _rootModule;
  static final _navigatorKey = GlobalKey<NavigatorState>();
  static late final ModuleApp _instance;

  ModuleApp({super.key, required Module rootModule, required super.child})
      : _rootModule = rootModule,
        super(module: rootModule._impl) {
    _instance = this;
    modular.Modular.setNavigatorKey(_navigatorKey);
  }

  static BuildContext get context => _navigatorKey.currentContext!;

  static RouterConfig<Object>? get routerConfig => modular.Modular.routerConfig;

  static Module get rootModule => _instance._rootModule;

  static void navigateTo(String route) {
    modular.Modular.to.navigate(route);
  }

  static void navigateBack<T>([T? result]) {
    modular.Modular.to.pop(result);
  }

  static void setInitialRoute(String route) {
    modular.Modular.setInitialRoute(route);
  }
}

typedef Injector = modular.Injector;

abstract class Module<T extends Module<T>> {
  late final _impl = _ModuleImpl(this);

  final List<RouteConfig> pages = const [];

  List<Module> get imports => const [];

  final Map<String, Module> submodules = const {};

  void binds(Injector i) {}

  void exportedBinds(Injector i) {}

  Widget loadLibrary(Future<void> libraryFuture, ValueGetter<Widget> builder) {
    return FutureBuilder<void>(
      future: libraryFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          return builder();
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  void loadI18n() {}
}

class _ModuleImpl<T extends Module<T>> extends modular.Module {
  final T module;

  _ModuleImpl(this.module);

  @override
  List<modular.Module> get imports {
    module.loadI18n();
    return module.imports.map((m) => m._impl).toList();
  }

  @override
  void routes(modular.RouteManager r) {
    for (var page in module.pages) {
      r.child(
        page.route,
        child: (context) => page.builder!(),
        children: page.children
            .map((c) => c.module != null
                ? modular.ModuleRoute(c.route, module: c.module!._impl)
                : modular.ChildRoute(c.route, child: (_) => c.builder!()))
            .toList(),
      );
    }
    for (var sub in module.submodules.entries) {
      r.module(sub.key, module: sub.value._impl);
    }
  }

  @override
  void binds(Injector i) {
    module.binds(i);
  }

  @override
  void exportedBinds(Injector i) {
    module.exportedBinds(i);
  }
}