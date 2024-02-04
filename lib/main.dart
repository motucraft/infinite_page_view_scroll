import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Infinite PageView Scroll',
      theme: ThemeData.dark(),
      home: const InfinitePageViewScroll(),
    );
  }
}

class InfinitePageViewScroll extends HookWidget {
  static final List<String> urls = [
    'https://p.npb.jp/img/common/logo/2024/logo_b_l.gif',
    'https://p.npb.jp/img/common/logo/2024/logo_m_l.gif',
    'https://p.npb.jp/img/common/logo/2024/logo_h_l.gif',
  ];

  const InfinitePageViewScroll({super.key});

  @override
  Widget build(BuildContext context) {
    final controller =
        usePageController(viewportFraction: 0.75, initialPage: 1);

    final itemCount = urls.length + 2;

    useEffect(() {
      controller.addListener(() {
        if (controller.page! > (urls.length + 0.999)) {
          controller.jumpToPage(1);
        } else if (controller.page! < 0.001) {
          controller.jumpToPage(itemCount - 2);
        }
      });
      return null;
    }, []);

    return Scaffold(
      appBar: AppBar(title: const Text('Infinite PageView Scroll')),
      body: PageView.builder(
        controller: controller,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Image.network(urls.last);
          } else if (index == itemCount - 1) {
            return Image.network(urls.first);
          } else {
            return Image.network(urls[(index - 1) % urls.length]);
          }
        },
      ),
    );
  }
}
