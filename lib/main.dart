import 'package:flutter/material.dart';
import 'package:lordicon/lordicon.dart';
import 'package:olive_app/features/posts/view/widgets/olive_list_tile.dart';
import 'package:olive_app/features/posts/view/widgets/tab_indicator.dart';

import 'features/posts/view/customer_page.dart';
import 'features/posts/view/settings_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          body: ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            child: Container(
              color: Colors.white,
              child: TabBarView(
                controller: _tabController,
                physics:
                    NeverScrollableScrollPhysics(), // Optional: disable swiping if desired
                children: [
                  CustomersTab(),
                  CustomersTab(),
                  CustomersTab(),
                  CustomersTab(),
                  SettingsTab(),
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
              labelPadding: EdgeInsets.symmetric(vertical: 8),
              tabs: [
                Tab(
                  icon: IconViewer(
                    controller: _productsController,
                    height: 24,
                    width: 24,
                    colorize: Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
                Tab(
                  icon: IconViewer(
                    controller: _customersController,
                    height: 24,
                    width: 24,
                    colorize: Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
                Tab(
                  icon: IconViewer(
                    controller: _ordersController,
                    height: 24,
                    width: 24,
                    colorize: Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
                Tab(
                  icon: IconViewer(
                    controller: _notificationsController,
                    height: 24,
                    width: 24,
                    colorize: Color.fromRGBO(255, 255, 255, 1),
                  ),
                ),
                Tab(
                  icon: IconViewer(
                    controller: _settingsController,
                    height: 24,
                    width: 24,
                    colorize: Color.fromRGBO(255, 255, 255, 1),
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

class ProductsTab extends StatelessWidget {
  const ProductsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final products = List.generate(
      50,
      (index) => {
        'title': 'Product Item testt$index',
        'subtitle': 'Product description $index',
        'badge': 'sss',
        'imageUrl':
            'https://www.gravatar.com/avatar/2c7d99fe281ecd3bcd65ab915bac6dd5?s=250',
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: Colors.white,
            pinned: true,
            expandedHeight: 160.0,
            floating: true,
            actions: [
              IconButton.filledTonal(onPressed: null, icon: Icon(Icons.search)),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Products'),
              centerTitle: true,
              background: Image.asset(
                "assets/product_cover.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
        body: GenericListView<Map<String, String>>(
          items: products,
          itemBuilder: (context, item) => OliveListTile(
            title: item['title']!,
            subtitle: item['subtitle']!,
            imageUrl: item['imageUrl'],
            badgeText: item['badge'],
            badgeColor: Colors.green,
            noteText: '10 min ago',
          ),
        ),
      ),
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

// Builder widget
class GenericListView<T> extends StatelessWidget {
  final List<T> items;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final EdgeInsetsGeometry padding;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const GenericListView({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.padding = EdgeInsets.zero,
    this.shrinkWrap = false,
    this.physics,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: padding,
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: items.length,
      itemBuilder: (context, index) => itemBuilder(context, items[index]),
      separatorBuilder: (context, index) => const Divider(
        height: 1,
        indent: 16,
        endIndent: 0,
        color: Color(0xFFEEEEEE),
      ),
    );
  }
}
