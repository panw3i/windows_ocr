
import 'package:fluent_ui/fluent_ui.dart';
import 'package:window_manager/window_manager.dart';
import 'package:windows_ocr/components/window_buttons.dart';
import 'package:windows_ocr/screens/home.dart';
import 'package:windows_ocr/screens/settings.dart';

class Navbar extends StatefulWidget {
  const Navbar({Key? key}) : super(key: key);

  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int topIndex = 0; // 当前选中的导航索引
  PaneDisplayMode displayMode = PaneDisplayMode.open; // 导航显示模式

  // 导航项
  List<NavigationPaneItem> items = [
    PaneItem(
      icon: const Icon(FluentIcons.home),
      title: const Text('Home'),
      body: Home(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar:  NavigationAppBar(
        automaticallyImplyLeading: false, // 隐藏返回按钮
        title: () {
          return const DragToMoveArea(
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text('Windows OCR'),
              ),
            ),
          );
        }(),
        actions: Row(
          mainAxisAlignment:MainAxisAlignment.end ,
          children: [
            const WindowButtons(),
          ]
        )
      ),
      pane: NavigationPane(
        selected: topIndex,
        onChanged: (index) => setState(() => topIndex = index),
        displayMode: displayMode,
        items: items,
        size: NavigationPaneSize(
          openWidth: 50.0,
        ),
        footerItems: [
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Settings'),
            body: const Settings(),
          ),
        ],
      ),
    );
  }
}


