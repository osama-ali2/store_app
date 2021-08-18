import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/constants/constants.dart';
import 'package:yagot_app/providers/general_provider.dart';
import 'package:yagot_app/screens/main/main_page_view.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'lang_dialog.dart';

class OptionListTile extends StatelessWidget {
  final int type;

  final Widget page;
  final String iconKey;

  final String titleKey;

  const OptionListTile(
      {Key key,
        this.type = NORMAL_OPTION,
        this.page,
        this.titleKey,
        this.iconKey})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        if (type == LOGOUT_OPTION) {
          context.read<GeneralProvider>().logout(context, () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => MainPages()),
                    (route) => false);
          }, () {});
        } else if (type == NORMAL_OPTION) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return page;
              },
            ),
          );
        } else if (type == LANG_OPTION) {
          showDialog(
            context: context,
            builder: (context) {
              return LangDialog();
            },
          );
        }
      },
      leading: _icon(iconKey),
      trailing: Icon(
        CupertinoIcons.forward,
        color: accent,
      ),
      title: Text(getTranslated(context,titleKey)),
      contentPadding: EdgeInsetsDirectional.only(
          start: 30.w, end: 40.w, top: 5.h, bottom: 5.h),
    );
  }

  Widget _icon(String iconKey) {
    return Container(
      height: 40.h,
      width: 40.w,
      decoration: BoxDecoration(
        color: white1,
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.all(5.r),
      child: SvgPicture.asset(
        'assets/icons/$iconKey',
        color: primary,
        alignment: Alignment.center,
      ),
    );
  }

}
