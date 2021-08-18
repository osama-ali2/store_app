import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/providers/language_provider.dart';
import 'package:yagot_app/screens/main/user_account.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class LangDialog extends StatefulWidget {
  @override
  _LangDialogState createState() => _LangDialogState();
}

class _LangDialogState extends State<LangDialog> {
  int _selectedLangId;

  List<Language> languages;

  Locale currentLocal;

  @override
  void initState() {
    super.initState();
    languages = [
      Language(id: 0, name: "العربية", code: "ar"),
      Language(id: 1, name: "English", code: "en"),
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    currentLocal = Localizations.localeOf(context);
    _selectedLangId = languages.firstWhere((language) {
      return language.code == currentLocal.languageCode;
    }).id;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: languages.length * 50.0 + 120.h,
        width: 280.w,
        padding:
        EdgeInsets.only(bottom: 20.h, right: 30.w, left: 30.w, top: 30.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              getTranslated(context, "change_language"),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.h),
            ...languages.map((language) {
              return _langChoice(context, language.name, language.id);
            }).toList(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    String langCode = languages.firstWhere((language) {
                      return language.id == _selectedLangId;
                    }).code;
                    Provider.of<LanguageProvider>(context, listen: false)
                        .setLanguageCode(langCode);
                    Navigator.pop(context);
                  },
                  child: Text(getTranslated(context, "yes")),
                  style: TextButton.styleFrom(
                    primary: accent
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    SharedPreferences.getInstance()
                        .then((value) => print(value.getString('language')));
                  },
                  child: Text(getTranslated(context, "cancel")),
                  style: TextButton.styleFrom(
                      primary: accent
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row _langChoice(BuildContext context, String name, int id) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        _selectCircle(context, id),
        SizedBox(width: 14.w),
        Text(name),
      ],
    );
  }

  _selectCircle(BuildContext context, int id) {
    bool isSelected = _selectedLangId == id;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLangId = id;
        });
      },
      child: Container(
        height: 20.h,
        width: 20.w,
        margin: EdgeInsets.only(bottom: 20.h),
        decoration: BoxDecoration(
          color: isSelected ? primary : white,
          border: !isSelected ? Border.all(color: grey4, width: 2) : null,
          shape: BoxShape.circle,
        ),
        child: Align(
          child: SvgPicture.asset(
            "assets/icons/correct_2.svg",
            fit: BoxFit.cover,
            height: 8.h,
            width: 8.h,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}