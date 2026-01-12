import 'package:flutter/material.dart';
import 'package:lordicon/lordicon.dart';

void main() {
  runApp(MainApp());
}

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
    _settingsController = IconController.assets('assets/message.json');

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
      home: Scaffold(
        backgroundColor: Colors.grey[200],
        body: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: Container(
            color: Colors.white,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  pinned: true,
                  snap: false,
                  floating: false,
                  expandedHeight: 160.0,
                  actions: [
                    IconButton.filledTonal(
                      onPressed: null,
                      icon: Icon(Icons.search),
                    ),
                  ],
                  flexibleSpace: const FlexibleSpaceBar(
                    title: Text('Products'),
                    centerTitle: true,
                  ),
                ),

                SliverList.builder(
                  itemCount: 50,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(title: Text('Item $index'));
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.zero,
          child: TabBar(
            onTap: _onTabTapped,
            controller: _tabController,
            indicator: TabIndicator(),
            splashFactory: NoSplash.splashFactory,
            isScrollable: false,
            labelPadding: EdgeInsets.symmetric(vertical: 8),
            tabs: [
              Tab(
                icon: IconViewer(
                  controller: _productsController,
                  height: 24,
                  width: 24,
                ),
              ),
              Tab(
                icon: IconViewer(
                  controller: _customersController,
                  height: 24,
                  width: 24,
                ),
              ),
              Tab(
                icon: IconViewer(
                  controller: _ordersController,
                  height: 24,
                  width: 24,
                ),
              ),
              Tab(
                icon: IconViewer(
                  controller: _notificationsController,
                  height: 24,
                  width: 24,
                ),
              ),
              Tab(
                icon: IconViewer(
                  controller: _settingsController,
                  height: 24,
                  width: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Source - https://stackoverflow.com/a
// Posted by MischievousChild, modified by community. See post 'Timeline' for change history
// Retrieved 2026-01-13, License - CC BY-SA 4.0

class TabIndicator extends BoxDecoration {
  final BoxPainter _painter;

  TabIndicator() : _painter = _TabIndicatorPainter();

  @override
  BoxPainter createBoxPainter([onChanged]) => _painter;
}

class _TabIndicatorPainter extends BoxPainter {
  final Paint _paint;

  _TabIndicatorPainter()
    : _paint = Paint()
        ..color = Colors.blue
        ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration cfg) {
    final double xPos = offset.dx + cfg.size!.width / 2;

    canvas.drawRRect(
      RRect.fromRectAndCorners(
        Rect.fromLTRB(xPos - 20, 0, xPos + 20, 5),
        bottomLeft: const Radius.circular(5.0),
        bottomRight: const Radius.circular(5.0),
      ),
      _paint,
    );
  }
}

// TabBar with IconViewer
class TabBarWithIconViewer extends StatefulWidget {
  const TabBarWithIconViewer({super.key});

  @override
  State<TabBarWithIconViewer> createState() => _TabBarWithIconViewerState();
}

class _TabBarWithIconViewerState extends State<TabBarWithIconViewer>
    with TickerProviderStateMixin {
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
    _settingsController = IconController.assets('assets/lock.json');

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
    return TabBar(
      onTap: _onTabTapped,
      controller: _tabController,
      indicator: TabIndicator(),
      splashFactory: NoSplash.splashFactory,
      isScrollable: false,
      labelPadding: EdgeInsets.symmetric(vertical: 8),
      tabs: [
        Tab(
          icon: IconViewer(
            controller: _productsController,
            height: 24,
            width: 24,
          ),
        ),
        Tab(
          icon: IconViewer(
            controller: _customersController,
            height: 24,
            width: 24,
          ),
        ),
        Tab(
          icon: IconViewer(
            controller: _ordersController,
            height: 24,
            width: 24,
          ),
        ),
        Tab(
          icon: IconViewer(
            controller: _notificationsController,
            height: 24,
            width: 24,
          ),
        ),
        Tab(
          icon: IconViewer(
            controller: _settingsController,
            height: 24,
            width: 24,
          ),
        ),
      ],
    );
  }
}
