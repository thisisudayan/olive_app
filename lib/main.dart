import 'package:flutter/material.dart';
import 'package:lordicon/lordicon.dart';
import 'package:olive_app/data/repositories/customer_repository.dart';
import 'package:olive_app/data/models/customer_model.dart';

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
                  ProductsTab(),
                  CustomersTab(),
                  OrdersTab(),
                  NotificationsTab(),
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

class OliveListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? imageUrl;
  final Widget? trailing;
  final VoidCallback? onTap;
  final String? badgeText;
  final Color? badgeColor;
  final String? noteText;

  const OliveListTile({
    super.key,
    required this.title,
    required this.subtitle,
    this.imageUrl,
    this.trailing,
    this.onTap,
    this.badgeText,
    this.badgeColor,
    this.noteText,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: EdgeInsets.zero,
        decoration: ShapeDecoration(
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(28),
            side: BorderSide(color: Colors.transparent),
          ),
        ),
        child: ClipPath(
          clipper: ShapeBorderClipper(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
          child: imageUrl != null
              ? Image.network(
                  imageUrl!,
                  fit: BoxFit.cover,
                  width: 48,
                  height: 48,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      "assets/default_avatar.png",
                      fit: BoxFit.cover,
                      width: 48,
                      height: 48,
                    );
                  },
                )
              : Image.asset(
                  "assets/default_avatar.png",
                  fit: BoxFit.cover,
                  width: 48,
                  height: 48,
                ),
        ),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          if (badgeText != null) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: (badgeColor ?? Colors.blue).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: (badgeColor ?? Colors.blue).withOpacity(0.2),
                ),
              ),
              child: Text(
                badgeText!,
                style: TextStyle(
                  color: badgeColor ?? Colors.blue,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
      subtitle: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          if (noteText != null) ...[
            const SizedBox(width: 12),
            Text(
              noteText!,
              style: TextStyle(fontSize: 12, color: Colors.grey[400]),
            ),
          ],
        ],
      ),
      trailing: trailing,
    );
  }
}

class CustomersTab extends StatefulWidget {
  const CustomersTab({super.key});

  @override
  State<CustomersTab> createState() => _CustomersTabState();
}

class _CustomersTabState extends State<CustomersTab> {
  final CustomerRepository _repository = CustomerRepository();
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _syncData();
  }

  Future<void> _syncData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      await _repository.refreshCustomers();
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        // If we have local data already, don't show an error just because the sync failed
        final localData = await _repository.getCustomers();
        setState(() {
          _isLoading = false;
          if (localData.isEmpty) {
            _errorMessage =
                "Failed to load customers. Please check your connection.";
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            backgroundColor: Colors.white,
            pinned: true,
            expandedHeight: 160.0,
            actions: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 32,
                    height: 32,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      strokeCap: StrokeCap.round,
                      color: Colors.black,
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  Icon(Icons.cloud_download, size: 20, color: Colors.blue),
                ],
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                _isLoading ? 'Loading...' : 'Customers',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              centerTitle: true,
              background: Image.asset(
                "assets/customer_cover.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
        body: StreamBuilder<List<CustomerModel>>(
          stream: _repository.watchCustomers(),
          builder: (context, snapshot) {
            if (_errorMessage != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _syncData,
                      child: const Text("Retry"),
                    ),
                  ],
                ),
              );
            }

            final customers = snapshot.data ?? [];

            if (_isLoading && customers.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (customers.isEmpty) {
              return const Center(child: Text("No customers found."));
            }

            return GenericListView<CustomerModel>(
              items: customers,
              itemBuilder: (context, item) => OliveListTile(
                title: item.name,
                subtitle: item.email ?? item.phone ?? "No contact info",
                imageUrl: item.avatar,
                badgeText: item.status.toUpperCase(),
                badgeColor: item.status == 'active'
                    ? Colors.green
                    : Colors.grey,
              ),
            );
          },
        ),
      ),
    );
  }
}

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          pinned: true,
          expandedHeight: 160.0,
          flexibleSpace: const FlexibleSpaceBar(
            title: Text('Orders'),
            centerTitle: true,
          ),
        ),
        SliverList.builder(
          itemCount: 15,
          itemBuilder: (BuildContext context, int index) {
            return OliveListTile(
              title: 'Order #100${index + 1}',
              subtitle: 'Status: Processing',
              imageUrl: 'https://www.gravatar.com/avatar/${index}?d=identicon',
              trailing: Text('\$${(index + 1) * 20}.00'),
            );
          },
        ),
      ],
    );
  }
}

class NotificationsTab extends StatelessWidget {
  const NotificationsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = List.generate(
      10,
      (index) => {
        'title': 'Notification title ${index + 1}',
        'subtitle': 'This is a sample notification message.',
        'imageUrl': 'https://api.dicebear.com/7.x/bottts/png?seed=${index}',
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
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('Notifications'),
              centerTitle: true,
            ),
          ),
        ],
        body: GenericListView<Map<String, String>>(
          items: notifications,
          itemBuilder: (context, item) {
            final index = notifications.indexOf(item);
            return OliveListTile(
              title: item['title']!,
              subtitle: item['subtitle']!,
              imageUrl: item['imageUrl'],
              badgeText: index % 2 == 0 ? 'NEW' : null,
              badgeColor: index % 2 == 0 ? Colors.green : null,
            );
          },
        ),
      ),
    );
  }
}

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: Colors.white,
          pinned: true,
          expandedHeight: 160.0,
          flexibleSpace: const FlexibleSpaceBar(
            title: Text('Settings'),
            centerTitle: true,
          ),
        ),
        SliverList.builder(
          itemCount: 4,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.person_outline),
              title: Text('Profile Settings'),
              onTap: () {},
            );
          },
        ),
      ],
    );
  }
}
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
        ..color = Colors.white
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
