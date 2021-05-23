import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:schedule_app/home/ui/left_drawer.dart';

class HomePage extends StatelessWidget {
  //  Current State of InnerDrawerState
  final _innerDrawerKey = GlobalKey<InnerDrawerState>();

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
      key: _innerDrawerKey,
      onTapClose: true,
      swipe: true,
      offset: IDOffset.only(left: 0.75, right: 0.6),
      leftChild: LeftDrawerPage(
        drawerKey: _innerDrawerKey,
      ),
      rightChild: Container(),
      backgroundDecoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
      scaffold: Scaffold(
        body: NoScheduleHomePage(
          innerDrawerKey: _innerDrawerKey,
        ),
      ),
    );
  }
}

class NoScheduleHomePage extends StatelessWidget {
  final GlobalKey<InnerDrawerState> _innerDrawerKey;

  NoScheduleHomePage({GlobalKey<InnerDrawerState> innerDrawerKey})
      : _innerDrawerKey = innerDrawerKey {
    assert(_innerDrawerKey != null);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final surfaceColor = theme.colorScheme.surface;

    return Stack(
      children: [
        Container(
          height: 420,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  theme.colorScheme.secondary,
                  theme.colorScheme.secondaryVariant,
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
        ),
        Container(
            height: 32,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 400),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            )),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            iconTheme: IconThemeData(color: surfaceColor),
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(Icons.menu_rounded),
              onPressed: () {
                _innerDrawerKey.currentState
                    .open(direction: InnerDrawerDirection.start);
              },
            ),
            actions: [
              IconButton(
                icon: Container(
                  margin: EdgeInsets.only(right: 16),
                  child: Icon(Icons.list_rounded),
                ),
                onPressed: () {
                  _innerDrawerKey.currentState
                      .open(direction: InnerDrawerDirection.end);
                },
              ),
            ],
          ),
          body: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(left: 32, top: 32),
                  child: Text(
                    "Schedule",
                    style: TextStyle(fontSize: 40, color: surfaceColor),
                  )),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.only(top: 16),
                  child: Image(
                    image: AssetImage('assets/icon/ic_calendar.png'),
                    width: 230,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 24, right: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 275,
                          child: ElevatedButton.icon(
                            onPressed: () => {},
                            icon: Icon(Icons.add_box_rounded),
                            label: Text(
                              "Create",
                              style: TextStyle(fontSize: 22),
                            ),
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(12),
                                primary: theme.buttonColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32))),
                          ),
                        ),
                        Container(
                          child: Text(
                              "Create a schedule and invite others to join it."),
                          margin: EdgeInsets.only(top: 6),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 16),
                          child: SizedBox(
                            width: 275,
                            child: ElevatedButton(
                              onPressed: () => {},
                              child: Text(
                                "Join",
                                style: TextStyle(fontSize: 22),
                              ),
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(12),
                                primary: theme.buttonColor,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            "Join a schedule created by your office, school or someone else.",
                            textAlign: TextAlign.center,
                          ),
                          margin: EdgeInsets.only(top: 8),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
