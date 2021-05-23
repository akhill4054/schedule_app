import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedule_app/login/ui/logout_bottom_sheet.dart';
import 'package:schedule_app/models/user.dart';
import 'package:schedule_app/widgets/profile_pic.dart';

class DrawerProfilePage extends StatelessWidget {
  final User _user;

  const DrawerProfilePage({
    @required User user,
  }) : _user = user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 5,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                  child: ProfilePic(
                    width: 120,
                    imgUrl: _user.picUrl,
                  ),
                ),
              ),
              Container(
                width: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).accentColor,
                  // border: Border.all(
                  //   width: 3,
                  //   color: Theme.of(context).scaffoldBackgroundColor,
                  // ),
                ),
                margin: EdgeInsets.only(top: 80, left: 160),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 16),
            child: Text(
              _user.name,
              style: TextStyle(fontSize: 20),
            ),
          ),
          Container(
            child: (_user.about?.isNotEmpty == true)
                ? Container(
                    margin: EdgeInsets.only(top: 8),
                    child: Text(
                      _user.about,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  )
                : null,
          ),
          Container(
            margin: EdgeInsets.all(16),
            child: CupertinoButton(
              child: Text(
                'Logout',
                style: TextStyle(
                  fontSize: 18,
                  color: Theme.of(context).accentColor,
                ),
              ),
              onPressed: () {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  context: context,
                  builder: (context) => LogoutBottomSheetPage(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
