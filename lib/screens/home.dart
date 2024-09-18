import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart'; // 用于剪贴板操作
import 'package:windows_ocr/utils/toast_util.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String selectedContact = '';
  List<String> items = ['a', 'b', 'c', 'd', 'e', 'f'];

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      content: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final contact = items[index];
                return ListTile.selectable(
                  title: Text(contact),
                  selectionMode: ListTileSelectionMode.single,
                  selected: selectedContact == contact,
                  onSelectionChange: (selected) {
                    setState(() {
                      selectedContact = selected ? contact : '';
                    });
                  },
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(FluentIcons.copy),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: contact));
                          ToastUtil.showToast(context, 'Contact copied to clipboard!');
                        },
                      ),
                      IconButton(
                        icon: const Icon(FluentIcons.delete),
                        onPressed: () {
                          setState(() {
                            items.removeAt(index);
                            if (selectedContact == contact) {
                              selectedContact = '';
                            }
                          });
                          ToastUtil.showToast(context, 'deleted!');
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
