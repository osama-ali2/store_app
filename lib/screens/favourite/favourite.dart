import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yagot_app/models/product/product.dart';
import 'package:yagot_app/screens/favourite/empty_favourites.dart';
import 'package:yagot_app/screens/shared/remove_sheet.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FavouriteScreen extends StatefulWidget {
  @override
  _FavouriteScreenState createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  List<ProductModel> products;

  SlidableController _slidableController;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _slidableController = SlidableController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _appBar(),
      body: (products == null || products.isEmpty)
          ? EmptyFavourites()
          : _containFavourites(context),
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: Text(
        getTranslated(context, "favourite"),
        style: Theme.of(context).textTheme.headline1,
      ),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _containFavourites(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, position) {
        return _productCard(products[position], position);
      },
      itemCount: products.length,
      padding: EdgeInsets.all(30),
      physics: BouncingScrollPhysics(),
    );
  }

  Widget _productCard(ProductModel product, int position) {
    return Slidable(
      // key: Key(product.id),
      actionPane: SlidableDrawerActionPane(),
      controller: _slidableController,
      actions: [_removeAction(context, position)],
      closeOnScroll: false,
      dismissal: SlidableDismissal(
        child: SlidableDrawerDismissal(),
        dragDismissible: false,
        onDismissed: (actionType) {
          setState(() {
            products.removeAt(position);
          });
        },
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Color(0xFF00041D).withOpacity(.06),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                  spreadRadius: 2)
            ]),
        clipBehavior: Clip.hardEdge,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: ExactAssetImage(product.details.image),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.details.title,
                  style: TextStyle(
                    color: Color(0xFF00041D),
                    fontFamily: "NeoSansArabic",
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  product.details.price,
                  style: TextStyle(
                    color: Color(0xFF595B67),
                    fontFamily: "NeoSansArabic",
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _removeAction(BuildContext context, int position) {
    return SlideAction(
      onTap: () {
        _showRemoveSheet(context, position);
      },
      closeOnTap: false,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
            color: Color(0xFFE1251B),
            borderRadius:
                BorderRadiusDirectional.horizontal(end: Radius.circular(8))),
        child: Align(
          child: SvgPicture.asset(
            "assets/icons/remove.svg",
            fit: BoxFit.cover,
            height: 24,
            width: 20,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }

  _showRemoveSheet(BuildContext context, int position) {
    showDialog(
      context: context,
      builder: (context) {
        return RemoveSheet(
            "delete_from_favourite", "delete_from_favourite_confirm", () {
          _slidableController.activeState.dismiss();
          Navigator.pop(context);
        });
      },
      barrierColor: Colors.black.withOpacity(.35),
      barrierDismissible: true,
    );
  }
}
