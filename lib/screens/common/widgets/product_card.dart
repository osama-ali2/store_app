import 'package:flutter/material.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/models/product/product_details.dart';
import 'package:yagot_app/screens/main/product_preview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:yagot_app/providers/general_provider.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
class ProductCard extends StatefulWidget {
  final ProductDetails productDetails;

  ProductCard({@required this.productDetails});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool isFav = false ;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) {
            return ChangeNotifierProvider(child: ProductPreview(widget.productDetails.id) , create: (_)=> GeneralProvider(),);
          },
        ));
      },
      child: Align(
        child: Card(
          shadowColor: accent,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
          ),
          clipBehavior: Clip.hardEdge,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Container(
                    child: Image.network(
                      widget.productDetails.image,
                      width: 150.w,
                      height: 170.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isFav ? Icons.favorite_rounded :Icons.favorite_border,
                      size: 20,
                    ),
                    onPressed: () {
                      setState(() {
                        isFav= !isFav ;
                      });
                    },
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h, right: 20.w, left: 20.w),
                child: Text(
                  widget.productDetails.title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.h, right: 20.w, left: 20.w),
                child: Text(
                  getDate(widget.productDetails.dateTime),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: grey2,
                    fontSize: 12.sp,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
