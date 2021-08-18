import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/models/home/client.dart';
import 'package:yagot_app/models/product/product.dart';
import 'package:yagot_app/models/product/product_details.dart';
import 'package:yagot_app/providers/general_provider.dart';
import 'package:yagot_app/screens/common/widgets/contact_button.dart';
import 'package:yagot_app/screens/conversations/single_conversation.dart';
import 'package:yagot_app/screens/common/widgets/app_button.dart';
import 'package:yagot_app/screens/common/widgets/product_card.dart';
import 'package:yagot_app/screens/shipping_address/shipping_screen.dart';
import 'package:yagot_app/screens/show_product/profile_preview.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:yagot_app/utilities/none_glow_scroll_behavior.dart';

class ProductPreview extends StatefulWidget {
  final int id;

  ProductPreview(this.id);

  @override
  _ProductPreviewState createState() => _ProductPreviewState();
}

class _ProductPreviewState extends State<ProductPreview> {
  CarouselController _carouselController;
  bool isFav = false;

  int _sliderIndex = 0;
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    Provider.of<GeneralProvider>(context, listen: false)
        .getProductById(widget.id);
    _carouselController = CarouselController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        body: ScrollConfiguration(
          behavior: NoneGlowScrollBehavior(),
          child: Consumer<GeneralProvider>(builder: (context, provider, child) {
            return provider.product != null
                ? buildBodyContent(provider.product, provider.productImages)
                : Center(
                    child: CircularProgressIndicator(),
                  );
          }),
        ));
  }

  void onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    Provider.of<GeneralProvider>(context, listen: false)
        .getProductById(widget.id);

    refreshController.refreshCompleted();
  }

  void onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    refreshController.loadNoData();
  }

  Widget buildBodyContent(ProductModel product, List<String> images) {
    ProductDetails details = product.details;
    List<ProductDetails> otherProducts = product.others;
    Client client = product.client;
    return CustomScrollView(
      slivers: [
        buildSliverAppBar(context, product, images),
        SliverList(
          delegate: SliverChildListDelegate([
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 40.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        details.title,
                        style: TextStyle(
                          color: accent,
                          fontWeight: FontWeight.bold,
                          fontSize: 20.sp,
                        ),
                      ),
                      Text(
                        details.price + " " + details.currencyName,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: primary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  _divider(),
                  SizedBox(height: 30.h),
                  _subtitle(getTranslated(context, "product_details")),
                  SizedBox(height: 20.h),
                  Text(getDate(details.dateTime),
                      style: TextStyle(
                          color: grey1,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal)),
                  Text(
                    details.details,
                    style: TextStyle(
                      color: grey2,
                      decoration: TextDecoration.none,
                      height: 2,
                      fontWeight: FontWeight.w100,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  _divider(),
                  SizedBox(height: 30.h),
                  _subtitle(getTranslated(context, "about_product_owner")),
                  SizedBox(height: 20.h),
                  (client != null) ? _aboutOwnerRow(client) : Container(),
                  SizedBox(height: 20.h),
                  Text(
                    getTranslated(context, "communication_data"),
                    style: TextStyle(
                      color: accent,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Spacer(),
                      ContactButton(
                        titleKey: 'send_message',
                        iconPath: 'message.svg',
                        color: white1,
                        borderColor: primary,
                        textColor: primary,
                        onPressed: _goToMessage,
                      ),
                      SizedBox(width: 20.w),
                      ContactButton(
                        titleKey: 'call',
                        iconPath: 'phone_call.svg',
                        color: white1,
                        borderColor: primary,
                        textColor: primary,
                        onPressed: (){
                          _goToPhoneApp(product.client.fullMobile);
                        },
                      ),
                      Spacer(),
                    ],
                  ),
                  SizedBox(height: 40.h),
                  AppButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ShippingScreen()));
                    },
                    title: 'buy',
                  ),
                  SizedBox(height: 45.h),
                  Text(
                    getTranslated(context, "similar_products"),
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: accent,
                        decoration: TextDecoration.none),
                  ),
                  SizedBox(height: 20.h),
                  (otherProducts != null && otherProducts.isNotEmpty)
                      ? _productsCardsList(otherProducts)
                      : Text("no similar products"),
                ],
              ),
            )
          ]),
        ),
      ],
    );
  }

  _goToMessage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SingleConversationPage()));
  }

  _goToPhoneApp(String number) async {
    var _url = 'tel:$number';
    await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
  }

  SliverAppBar buildSliverAppBar(
      BuildContext context, ProductModel product, List<String> images) {
    return SliverAppBar(
      brightness: Brightness.dark,
      pinned: true,
      elevation: 0,
      backgroundColor: primary,
      expandedHeight: MediaQuery.of(context).size.height * .4,
      actions: [
        IconButton(
          onPressed: () async {
            await _shareProduct(product.details.title);
          },
          icon: Icon(Icons.share),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: (images != null && images.isNotEmpty)
            ? topSlider(images)
            : Center(child: CircularProgressIndicator()),
      ),
      bottom: _appBarBottom(context),
    );
  }

  _shareProduct(String title) async {
    await Share.share('Check out this pretty product $title');
  }

  PreferredSize _appBarBottom(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(50.h),
      child: Stack(alignment: AlignmentDirectional.topEnd, children: [
        Container(
          height: 50.h,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
            ),
          ),
        ),
        Transform.translate(
            offset: Offset(0, -20.h), child: _favouriteContainer()),
      ]),
    );
  }

  topSlider(List<String> images) {
    return (images == null || images.isEmpty)
        ? Container()
        : Stack(
            children: [
              CarouselSlider(
                items: List.generate(
                  images.length,
                  (index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(images[index], fit: BoxFit.fill,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        );
                      }),
                    );
                  },
                ),
                options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * .4 + 50.h,
                    autoPlay: true,
                    enlargeCenterPage: false,
                    viewportFraction: 1,
                    autoPlayInterval: Duration(seconds: 5),
                    onPageChanged: (position, changReason) {
                      setState(() {
                        _sliderIndex = position;
                      });
                    }),
                carouselController: _carouselController,
              ),
              Positioned(
                bottom: 80.h,
                left: 20.w,
                right: 20.w,
                child: _sliderIndicator(images.length, _sliderIndex),
              ),
            ],
          );
  }

  DotsIndicator _sliderIndicator(int length, int position) {
    return DotsIndicator(
      dotsCount: length,
      position: position.toDouble(),
      onTap: (position) {
        _carouselController.animateToPage(position.toInt(),
            duration: Duration(milliseconds: 500), curve: Curves.easeOut);
      },
      decorator: DotsDecorator(
          color: white.withOpacity(.5),
          activeColor: white,
          size: Size(8, 8),
          spacing: EdgeInsets.only(left: 4.w, right: 4.w)),
    );
  }

  Widget _divider() {
    return Container(
      height: .5.h,
      color: grey3,
      width: MediaQuery.of(context).size.width,
    );
  }

  Widget _subtitle(String subtitle) {
    return Text(
      subtitle,
      style: TextStyle(
        color: accent,
        fontWeight: FontWeight.bold,
        fontSize: 16.sp,
      ),
    );
  }

  Widget _aboutOwnerRow(Client client) {
    return GestureDetector(
      onTap: () {
        print(client.image);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ProfilePreview(client: client);
            },
          ),
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ownerImage(client.image),
          SizedBox(width: 10.w),
          SizedBox(
            height: 50.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      client.name,
                      style: TextStyle(
                        color: accent,
                        fontWeight: FontWeight.w600,
                        fontSize: 14.sp,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    SvgPicture.asset(
                      "assets/icons/check_in.svg",
                      height: 16.h,
                      width: 16.w,
                      fit: BoxFit.cover,
                    )
                  ],
                ),
                Text(
                  client.clientType ?? '',
                  style: TextStyle(
                    color: grey2,
                    fontWeight: FontWeight.w100,
                    fontSize: 12.sp,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _ownerImage(String imageUrl) {
    return Container(
      width: 50.w,
      height: 50.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: white,
      ),
      child: ClipOval(
        child: FadeInImage.assetNetwork(
          placeholder: 'assets/images/place_holder.png',
          image: imageUrl,
          fit: BoxFit.cover,
          alignment: Alignment.center,
          imageErrorBuilder: (context, error, stackTrace) =>
              Image.asset('assets/images/place_holder.png'),
        ),
      ),
    );
  }

  Widget _contactButton(String type, String iconPath, Function onPressed) {
    return MaterialButton(
      height: 50.h,
      minWidth: 130.w,
      elevation: 0,
      color: white1,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: primary, width: 1),
        borderRadius: BorderRadius.circular(25.r),
      ),
      onPressed: onPressed,
      child: Row(
        children: [
          SvgPicture.asset(iconPath),
          SizedBox(width: 10.w),
          Text(
            type,
            style: TextStyle(
              fontWeight: FontWeight.w100,
              color: primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _productsCardsList(List<ProductDetails> products) {
    return SizedBox(
      width: double.infinity,
      height: 250,
      child: ListView.builder(
        itemBuilder: (context, position) {
          ProductDetails currentProduct = products[position];
          return ProductCard(productDetails: currentProduct);
        },
        itemCount: products.length,
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget _favouriteContainer() {
    return Container(
      height: 50.h,
      width: 50.w,
      margin: EdgeInsetsDirectional.only(end: 30.w),
      decoration: BoxDecoration(
        color: white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: accent,
            blurRadius: 6,
            spreadRadius: 0,
          ),
        ],
      ),
      child: IconButton(
          onPressed: () {
            setState(() {
              isFav = !isFav;
            });
          },
          icon: Icon(
            isFav ? Icons.favorite_rounded : Icons.favorite_border,
            color: accent,
            size: 20,
          )),
    );
  }
}
