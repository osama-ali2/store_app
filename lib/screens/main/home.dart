import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/models/home/home_section_model.dart';
import 'package:yagot_app/models/home/category_model.dart';
import 'package:yagot_app/models/home/slider_model.dart';
import 'package:yagot_app/models/product/product.dart';
import 'package:yagot_app/providers/general_provider.dart';
import 'package:yagot_app/screens/main/categories.dart';
import 'package:yagot_app/screens/main/product_preview.dart';
import 'package:yagot_app/screens/main/single_section.dart';
import 'package:yagot_app/screens/search/search.dart';
import 'package:yagot_app/screens/shared/product_card.dart';
import 'package:yagot_app/screens/sign_login/login.dart';
import 'package:yagot_app/utilities/custom_icons.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:yagot_app/singleton/APIsData.dart';
import 'package:yagot_app/singleton/dio.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:yagot_app/constants/constants.dart';
import 'package:yagot_app/models/product/product_details.dart';
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _sliderIndex = 0;

  CarouselController _carouselController;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<HomeSectionModel> sections ;
  List<SliderModel> banners ;
  HomeSectionModel categories ;
  List<HomeSectionModel> productList ;

  @override
  void initState() {
    super.initState();
    _carouselController = CarouselController();

    if(Provider.of<GeneralProvider>(context, listen: false).homeSections == null)
      Provider.of<GeneralProvider>(context, listen: false).getHomeSections(context);
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
        productList = provider.homeProducts;
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
              return _productList(productList[position - 2]);
            },
            itemCount: productList.length + 2,
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

  _categoriesList(HomeSectionModel section) {
    return (section == null)
        ? Container()
        : Column(
            children: [
              _sectionTitleRow(section.title, section.type),
              SizedBox(
                height: 60.h,
                width: double.infinity,
                child: ListView.builder(
                  itemBuilder: (context, position) {
                    var category = section.category[position];
                    return GestureDetector(
                      onTap: () {
                        Provider.of<GeneralProvider>(context, listen: false)
                            .clearCategoryProducts();
                        Provider.of<GeneralProvider>(context, listen: false)
                            .getCategoryById(category.id);
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return SectionScreen(category.name, category.id);
                        }));
                      },
                      child: Card(
                        shadowColor: Color(0xFF1F4282),
                        color: Color(0xFFECF3FF),
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
                                      color: Color(0xFF0E2756),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            ],
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                    );
                  },
                  itemCount: section.category.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                ),
              ),
            ],
          );
  }

  _productList(HomeSectionModel section) {
    return (section == null || section.products.isEmpty)
        ? Container()
        : Column(
            children: [
              _sectionTitleRow(section.title, section.type, id: section.id),
              SizedBox(
                height: 300.h,
                width: double.infinity,
                child: ListView.builder(
                  itemBuilder: (context, position) {
                    ProductDetails currentProduct = section.products[position];
                    return ProductCard(productDetails: currentProduct);
                  },
                  itemCount: section.products.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(right: 10, left: 10, bottom: 10),
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
                color: blue1, fontWeight: FontWeight.bold, fontSize: 16.ssp),
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
              padding: const EdgeInsets.all(8.0),
              child: Text(
                getTranslated(context, "show_all"),
                style: TextStyle(
                  color: grey2,
                  fontSize: 12.ssp,
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
    await Future.delayed(Duration(milliseconds: 1500));

    Provider.of<GeneralProvider>(context, listen: false).clear();
    _clearData();
    Provider.of<GeneralProvider>(context, listen: false).getHomeSections(context);

    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));

    _refreshController.loadNoData();
  }

  void _clearData(){
    if(banners != null) banners.clear() ;
    if(sections != null) sections.clear() ;
    if(productList != null) productList.clear() ;
    if(categories != null) categories = null ;
  }

}
