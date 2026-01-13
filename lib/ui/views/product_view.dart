import 'package:flutter/material.dart';
import 'package:olive_app/ui/widgets/olive_list_tile.dart';
import 'package:olive_app/ui/widgets/generic_list_view.dart';

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
            actions: const [
              IconButton.filledTonal(onPressed: null, icon: Icon(Icons.search)),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Products'),
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
