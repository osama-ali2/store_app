import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yagot_app/screens/main/single_section.dart';
import 'package:yagot_app/utilities/custom_icons.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/providers/general_provider.dart';
import 'package:provider/provider.dart';
import 'package:yagot_app/models/home/category_model.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<GeneralProvider>(context,listen: false).getCategories();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(getTranslated(context, "categories")),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back, color: black),
        ),
      ),
      body: SafeArea(child: _bodyContent(context)),
    );
  }

  Widget _bodyContent(BuildContext context) {
    return Consumer<GeneralProvider>(builder: (context, provider, child) {
      List<CategoryModel> categories = provider.categories;

      return categories == null
          ? Center(child: CircularProgressIndicator())
          : _categoriesList(context, categories);
    });
  }

  _categoriesList(BuildContext context, List<CategoryModel> categories) {
    return ListView.builder(
        itemBuilder: (context, position) {
          return _singleSectionCard(context, categories[position]);
        },
        itemCount: categories.length,
        padding: EdgeInsets.symmetric(
          vertical: 30.h,
        ));
  }

  _singleSectionCard(BuildContext context, CategoryModel category) {
    return GestureDetector(
      onTap: () {
        Provider.of<GeneralProvider>(context, listen: false).clearCategoryProducts();
        Provider.of<GeneralProvider>(context, listen: false)
            .getCategoryById(category.id);
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return SectionScreen(category.name, category.id);
        }));
      },
      child: Container(
        height: 70.h,
        margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
        padding: EdgeInsets.only(left: 30.w, right: 30.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              CustomIcons.diamond,
              color: white,
            ),
            Spacer(
              flex: 1,
            ),
            Text(
              category.name,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.sp,
                color: white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(
              flex: 6,
            ),
            Icon(
              CupertinoIcons.chevron_back,
              color: white,
            )
          ],
        ),
        decoration: BoxDecoration(
          color: primary,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
    );
  }
}

