import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin<MyApp> {
  late TabController _tabController;
  late TabController _tabController2;
  late TabController _tabController3;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController2 = TabController(length: 2, vsync: this);
    _tabController3 = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('TabBar Bug Demo')),
        body: Column(
          children: [
            // ✅ 1st tabbar
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: 'Tab 0'),
                Semantics(
                  label: 'label1',
                  child: Tab(text: 'Tab 1'),
                ),
                Semantics(
                  label: 'label2',
                  excludeSemantics: true,
                  child: Tab(text: 'Tab 2'),
                ),
                Semantics(
                  label: 'label3',
                  button: true,
                  enabled: true,
                  child: Tab(text: 'Tab 3'),
                ),
              ],
            ),
            Container(
              height: 100,
              color: Colors.blueGrey.shade100,
              child: TabBarView(
                controller: _tabController,
                children: [
                  myBox(text: 'Pure Tab bar with no semantics tag'),
                  myBox(text: 'Tab with only label'),
                  myBox(text: 'Tab with label and excludeSemantics as true'),
                  myBox(
                    text:
                        'Tab with label and button as true and enabled as true',
                  ),
                ],
              ),
            ),

            // ✅ 2nd tabbar
            TabBar(
              controller: _tabController2,
              tabs: [
                ExcludeSemantics(child: Tab(text: 'Tab 4')),
                MergeSemantics(
                  child: Semantics(
                    label: 'label 5',
                    child: Tab(text: 'Tab 5'),
                  ),
                ),
              ],
            ),
            Container(
              height: 100,
              color: Colors.blueGrey.shade100,
              child: TabBarView(
                controller: _tabController2,
                children: [
                  myBox(text: 'This is ExcludeSemantics tab'),
                  myBox(text: 'Tab with only label'),
                ],
              ),
            ),

            // ✅ 3rd tabbar
            TabBar(
              controller: _tabController3,
              tabs: [
                Semantics(
                  role: SemanticsRole.tab,
                  label: 'custom label 1',
                  child: Tab(text: 'Tab 6'),
                ),
                Semantics(
                  role: SemanticsRole.tabBar,
                  label: 'custom label 2',
                  child: Tab(text: 'Tab 7'),
                ),
                Semantics(
                  role: SemanticsRole.tabPanel,
                  label: 'custom label 3',
                  child: Tab(text: 'Tab 8'),
                ),
                ExcludeSemantics(child: Semantics(
                  label: 'custom label 4',
                  child: Tab(text: 'Tab 9'))),
              ],
            ),
            Container(
              height: 100,
              color: Colors.blueGrey.shade100,
              child: TabBarView(
                controller: _tabController3,
                children: [
                  myBox(text: 'Semantics with rold = tab'),
                  myBox(text: 'Semantics with rold = tabBar'),
                  myBox(text: 'Semantics with rold = tabPanel'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget myBox({required String text}) {
  return SizedBox(height: 40, width: 80, child: Center(child: Text(text)));
}
