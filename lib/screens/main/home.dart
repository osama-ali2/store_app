import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/constants/constants.dart';
import 'package:yagot_app/models/home/home_part_model.dart';
import 'package:yagot_app/models/home/slider_model.dart';
import 'package:yagot_app/models/product/product_details.dart';
import 'package:yagot_app/providers/general_provider.dart';
import 'package:yagot_app/screens/main/categories.dart';
import 'package:yagot_app/screens/main/single_section.dart';
import 'package:yagot_app/screens/search/search.dart';
import 'package:yagot_app/screens/common/widgets/product_card.dart';
import 'package:yagot_app/utilities/custom_icons.dart';
import 'package:yagot_app/utilities/helper_functions.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _sliderIndex = 0;

  CarouselController _carouselController;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<HomePartModel> sections;

  List<SliderModel> banners;

  HomePartModel categories;

  List<HomePartModel> productsParts;

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselController();
    print('home initState');
    context.read<GeneralProvider>().getHomeSections(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: _bodyContent(),
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      brightness: Brightness.light,
      leading: IconButton(
        icon: Icon(
          CustomIcons.search,
          color: grey1,
        ),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => SearchScreen()));
        },
      ),
      title: Text(getTranslated(context, "main")),
    );
  }

  Widget _bodyContent() {
    return Consumer<GeneralProvider>(
      builder: (context, provider, child) {
        sections = provider.homeSections;
        banners = provider.banners;
        categories = provider.homeCategories;
        productsParts = provider.homeProducts;
        return SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: MaterialClassicHeader(),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Text("pull up load");
              } else if (mode == LoadStatus.loading) {
                body = CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = Text("Load Failed!Click retry!");
              } else if (mode == LoadStatus.canLoading) {
                body = Text("release to load more");
              } else {
                body = Text("No more Data");
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: (sections == null || sections.isEmpty)
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemBuilder: (context, position) {
                    if (position == 0) {
                      return topSlider(banners);
                    }
                    if (position == 1) {
                      return _categoriesList(categories);
                    }
                    return _productList(productsParts[position - 2]);
                  },
                  itemCount: productsParts.length + 2,
                ),
        );
      },
    );
  }

  topSlider(List<SliderModel> banners) {
    return (banners == null || banners.isEmpty)
        ? Container()
        : Stack(
            children: [
              CarouselSlider(
                items: List.generate(
                  banners.length,
                  (index) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      child:
                          Image.network(banners[index].image, fit: BoxFit.fill,
                              loadingBuilder: (BuildContext context,
                                  Widget child,
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
                    height: 200.h,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    autoPlayInterval: Duration(seconds: 3),
                    onPageChanged: (position, changReason) {
                      setState(() {
                        _sliderIndex = position;
                      });
                    }),
                carouselController: _carouselController,
              ),
              Positioned(
                bottom: 20.h,
                left: 20.w,
                right: 20.w,
                child: _sliderIndicator(banners.length, _sliderIndex),
              ),
            ],
          );
  }

  _categoriesList(HomePartModel part) {
    return (part == null)
        ? Container()
        : Column(
            children: [
              _sectionTitleRow(part.title, part.type),
              SizedBox(
                height: 60.h,
                width: double.infinity,
                child: ListView.builder(
                  itemBuilder: (context, position) {
                    var category = part.category[position];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return SectionScreen(category.name, category.id);
                        }));
                      },
                      child: Card(
                        shadowColor: primary,
                        color: white1,
                        child: Padding(
                          padding: EdgeInsets.only(left: 40.w, right: 16.w),
                          child: Row(
                            children: [
                              Icon(CustomIcons.diamond),
                              SizedBox(
                                width: 16.w,
                              ),
                              Container(
                                  constraints: BoxConstraints(maxWidth: 150.w),
                                  child: Text(
                                    category.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: blue8,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8.r)),
                        ),
                      ),
                    );
                  },
                  itemCount: part.category.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                ),
              ),
            ],
          );
  }

  _productList(HomePartModel part) {
    return (part == null || part.products.isEmpty)
        ? Container()
        : Column(
            children: [
              _sectionTitleRow(part.title, part.type, id: part.id),
              SizedBox(
                height: 300.h,
                width: double.infinity,
                child: ListView.builder(
                  itemBuilder: (context, position) {
                    ProductDetails currentProduct = part.products[position];
                    return ProductCard(productDetails: currentProduct);
                  },
                  itemCount: part.products.length,
                  scrollDirection: Axis.horizontal,
                  padding:
                      EdgeInsets.only(right: 10.w, left: 10.w, bottom: 10.h),
                ),
              ),
            ],
          );
  }

  Widget _sectionTitleRow(String title, int type, {int id}) {
    return Padding(
      padding:
          EdgeInsets.only(right: 16.w, left: 16.w, top: 32.h, bottom: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                color: accent, fontWeight: FontWeight.bold, fontSize: 16.sp),
          ),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return (type == CATEGORY)
                        ? CategoriesScreen()
                        : SectionScreen(title, id);
                  },
                ),
              );
            },
            child: Padding(
              padding: EdgeInsets.all(8.0.r),
              child: Text(
                getTranslated(context, "show_all"),
                style: TextStyle(
                  color: grey2,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ],
      ),
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

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 500));

    _clearData();
    context.read<GeneralProvider>().getHomeSections(context, refresh: true);

    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));

    _refreshController.loadNoData();
  }

  void _clearData() {
    if (banners != null) banners.clear();
    if (sections != null) sections.clear();
    if (productsParts != null) productsParts.clear();
    if (categories != null) categories = null;
  }
}
