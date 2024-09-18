import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'utils/platform_utils.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (isDesktop()) {
    await flutter_acrylic.Window.initialize();
    await flutter_acrylic.Window.hideWindowControls();
    await WindowManager.instance.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setTitleBarStyle(
        TitleBarStyle.hidden,
      );
      await windowManager.setMinimumSize(const Size(574, 450));
      await windowManager.setSize(const Size(700, 500));
      await windowManager.show();
      await windowManager.setPreventClose(true);
      await windowManager.setSkipTaskbar(false);
    });
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      title: 'Flutter Demo',

      darkTheme: FluentThemeData(
        brightness: Brightness.dark,
        visualDensity: VisualDensity.standard,
        focusTheme: FocusThemeData(
          glowFactor: is10footScreen(context) ? 2.0 : 0.0,
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int topIndex = 0; // 当前选中的导航索引
  PaneDisplayMode displayMode = PaneDisplayMode.open; // 导航显示模式

  // 导航项
  List<NavigationPaneItem> items = [
    PaneItem(
      icon: const Icon(FluentIcons.home),
      title: const Text('Home'),
      body: const _NavigationBodyItem(content: Text('Home Page')),
    ),
    PaneItemSeparator(),
    PaneItem(
      icon: const Icon(FluentIcons.issue_tracking),
      title: const Text('Track orders'),
      infoBadge: const InfoBadge(source: Text('8')),
      body: const _NavigationBodyItem(
        content: Text(
          'This is the tracking orders page.',
        ),
      ),
    ),
    PaneItem(
      icon: const Icon(FluentIcons.disable_updates),
      title: const Text('Disabled Item'),
      body: const _NavigationBodyItem(content: Text('Disabled Page')),
      enabled: false,
    ),
    PaneItemExpander(
      icon: const Icon(FluentIcons.account_management),
      title: const Text('Account'),
      body: const _NavigationBodyItem(
        content: Text(
          'This is the account page.',
        ),
      ),
      items: [
        PaneItemHeader(header: const Text('Apps')),
        PaneItem(
          icon: const Icon(FluentIcons.mail),
          title: const Text('Mail'),
          body: const _NavigationBodyItem(content: Text('Mail Page')),
        ),
        PaneItem(
          icon: const Icon(FluentIcons.calendar),
          title: const Text('Calendar'),
          body: const _NavigationBodyItem(content: Text('Calendar Page')),
        ),
      ],
    ),
    PaneItemWidgetAdapter(
      child: Builder(builder: (context) {
        if (NavigationView.of(context).displayMode == PaneDisplayMode.compact) {
          return const FlutterLogo();
        }
        return ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 200.0),
          child: const Row(children: [
            FlutterLogo(),
            SizedBox(width: 6.0),
            Text('This is a custom widget'),
          ]),
        );
      }),
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
                child: Text('Window OCR'),
              ),
            ),
          );
        }(),
      ),
      pane: NavigationPane(
        selected: topIndex,
        onChanged: (index) => setState(() => topIndex = index),
        displayMode: displayMode,
        items: items,
        footerItems: [
          PaneItem(
            icon: const Icon(FluentIcons.settings),
            title: const Text('Settings'),
            body: const _NavigationBodyItem(content: Text('Settings Page')),
          ),
          PaneItemAction(
            icon: const Icon(FluentIcons.add),
            title: const Text('Add New Item'),
            onTap: () {
              setState(() {
                items.add(
                  PaneItem(
                    icon: const Icon(FluentIcons.new_folder),
                    title: const Text('New Item'),
                    body: const _NavigationBodyItem(
                      content: Text(
                        'This is a newly added item',
                      ),
                    ),
                  ),
                );
              });
            },
          ),
        ],
      ),
    );
  }
}

// 导航项内容类
class _NavigationBodyItem extends StatelessWidget {
  final Widget? content;

  const _NavigationBodyItem({Key? key, this.content}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: const PageHeader(title: Text('Fluent UI Navigation')),
      content: Center(
        child: content ?? const Text('Default Content'),
      ),
    );
  }
}
