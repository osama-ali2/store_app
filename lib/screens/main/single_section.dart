import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yagot_app/models/product/product_details.dart';
import 'package:yagot_app/providers/general_provider.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yagot_app/screens/common/widgets/product_card.dart';
import 'package:yagot_app/utilities/helper_functions.dart';

class SectionScreen extends StatefulWidget {
  final int id;

  final String name;

  SectionScreen(this.name, this.id);

  @override
  _SectionScreenState createState() => _SectionScreenState();
}

class _SectionScreenState extends State<SectionScreen> {
  @override
  void initState() {
    Provider.of<GeneralProvider>(context, listen: false)
        .clearCategoryProducts();
    Provider.of<GeneralProvider>(context,listen: false).getCategoryById(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        title: Text(widget.name),
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
      List<ProductDetails> products = provider.categoryProducts;
      return products == null
          ? Center(child: CircularProgressIndicator())
          : products.isEmpty
              ? Center(
                  child: Text(getTranslated(context, "no_products_currently"))
                )
              : GridView.builder(
                  itemBuilder: (context, position) {
                    return ProductCard(productDetails : products[position]);
                  },
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .82,
                    mainAxisSpacing: 14,
                  ),
                  padding: EdgeInsets.all(20.r),
                  itemCount: products.length,
                );
    });
  }
}
