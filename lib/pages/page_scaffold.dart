import 'package:flutter/material.dart';
import 'package:ttrpg_character_tools/adaptive_info.dart';
import 'package:ttrpg_character_tools/navigation/nav_bar.dart';
import 'package:ttrpg_character_tools/navigation/nav_menu.dart';

class PageScaffold extends StatefulWidget {
  const PageScaffold({
    super.key,
    required this.adaptiveInfo,
    required this.body,
    required this.title,
  });

  final AdaptiveInfo adaptiveInfo;
  final Widget body;
  final String title;

  @override
  State<PageScaffold> createState() => _PageScaffoldState();
}

class _PageScaffoldState extends State<PageScaffold> {
  bool extended = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Classes"),
          automaticallyImplyLeading: widget.adaptiveInfo.isLandscape && !widget.adaptiveInfo.isLarge,
          leading: widget.adaptiveInfo.isLandscape && widget.adaptiveInfo.isLarge
              ? IconButton(
                  onPressed: () => setState(() {
                    extended = !extended;
                  }),
                  icon: const Icon(Icons.menu),
                  iconSize: 24,
                  padding: const EdgeInsets.all(16),
                )
              : null,
        ),
        bottomNavigationBar: NavBar.fromAdaptiveInfo(widget.adaptiveInfo),
        drawer: widget.adaptiveInfo.isLandscape && !widget.adaptiveInfo.isLarge ? const NavMenu() : null,
        body: Row(
          children: [
            if (widget.adaptiveInfo.isLandscape && widget.adaptiveInfo.isLarge)
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: extended ? 300 : 0,
                curve: Curves.fastOutSlowIn,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(24.0),
                    bottomRight: Radius.circular(24.0),
                  ),
                ),
                clipBehavior: Clip.antiAlias,
                child: const OverflowBox(
                  maxWidth: 300,
                  alignment: Alignment.centerLeft,
                  child: NavMenu(
                    showAppTitle: false,
                  ),
                ),
              ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: widget.body,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
