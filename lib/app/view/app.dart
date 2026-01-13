import 'package:flutter/material.dart';
import 'package:lordicon/lordicon.dart';
import 'package:olive_app/ui/views/customer_view.dart';
import 'package:olive_app/ui/views/product_view.dart';
import 'package:olive_app/ui/views/settings_view.dart';
import 'package:olive_app/ui/widgets/tab_indicator.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with TickerProviderStateMixin {
  late TabController _tabController;
  late IconController _productsController;
  late IconController _customersController;
  late IconController _ordersController;
  late IconController _notificationsController;
  late IconController _settingsController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);

    _productsController = IconController.assets('assets/shopping-bag.json');
    _customersController = IconController.assets('assets/avatar.json');
    _ordersController = IconController.assets('assets/inbox.json');
    _notificationsController = IconController.assets('assets/message.json');
    _settingsController = IconController.assets('assets/settings.json');

    _setupController(_productsController);
    _setupController(_customersController);
    _setupController(_ordersController);
    _setupController(_notificationsController);
    _setupController(_settingsController);
  }

  void _setupController(IconController controller) {
    // No automatic play on ready
  }

  void _onTabTapped(int index) {
    IconController? controller;
    switch (index) {
      case 0:
        controller = _productsController;
        break;
      case 1:
        controller = _customersController;
        break;
      case 2:
        controller = _ordersController;
        break;
      case 3:
        controller = _notificationsController;
        break;
      case 4:
        controller = _settingsController;
        break;
    }

    if (controller != null) {
      controller.playFromBeginning();
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _productsController.dispose();
    _customersController.dispose();
    _ordersController.dispose();
    _notificationsController.dispose();
    _settingsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'RobotoCondensed', useMaterial3: true),
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: Container(
              color: Colors.white,
              child: TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const ProductsTab(),
                  const CustomersTab(),
                  const CustomersTab(),
                  const CustomersTab(),
                  const SettingsTab(),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Container(
            padding: EdgeInsets.zero,
            color: Colors.black,
            child: TabBar(
              onTap: _onTabTapped,
              controller: _tabController,
              dividerHeight: 0,
              dividerColor: Colors.transparent,
              indicator: TabIndicator(),
              splashFactory: NoSplash.splashFactory,
              isScrollable: false,
              labelPadding: const EdgeInsets.symmetric(vertical: 8),
              tabs: [
                Tab(
                  icon: IconViewer(
                    controller: _productsController,
                    height: 24,
                    width: 24,
                    colorize: const Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
                Tab(
                  icon: IconViewer(
                    controller: _customersController,
                    height: 24,
                    width: 24,
                    colorize: const Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
                Tab(
                  icon: IconViewer(
                    controller: _ordersController,
                    height: 24,
                    width: 24,
                    colorize: const Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
                Tab(
                  icon: IconViewer(
                    controller: _notificationsController,
                    height: 24,
                    width: 24,
                    colorize: const Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
                Tab(
                  icon: IconViewer(
                    controller: _settingsController,
                    height: 24,
                    width: 24,
                    colorize: const Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
