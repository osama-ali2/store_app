import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/models/address.dart';
import 'package:yagot_app/screens/buying_product/buying_screen.dart';
import 'package:yagot_app/screens/common/widgets/app_button.dart';
import 'package:yagot_app/screens/common/widgets/remove_sheet.dart';
import 'package:yagot_app/screens/shipping_address/add_new_address.dart';
import 'package:yagot_app/screens/shipping_address/edit_address.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:yagot_app/utilities/none_glow_scroll_behavior.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddressesScreen extends StatefulWidget {
  @override
  _AddressesScreenState createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  List<AddressModel> addresses = List.generate(
      5,
      (index) => AddressModel(
          id: index,
          bloc: 'bloc',
          city: 'city',
          coordinates: LatLng(2222, 1123),
          homeNumber: '5225',
          street: 'street'));

  int _selectedIndex = -1;
  SlidableController _slidableController;

  @override
  void initState() {
    super.initState();
    _slidableController = SlidableController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: (addresses == null || addresses.isEmpty)
          ? EmptyAddresses()
          : _containingAddresses(),
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: white,
      title: Text(getTranslated(context, "addresses")),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back,
          color: accent,
        ),
      ),
    );
  }

  Widget _containingAddresses() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              EdgeInsets.only(left: 30.w, right: 30.w, top: 40.h, bottom: 30.h),
          child: Text(
            getTranslated(context, "choose_address"),
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ScrollConfiguration(
            behavior: NoneGlowScrollBehavior(),
            child: ListView.builder(
              itemBuilder: (context, position) {
                return (position == addresses.length)
                    ? _addNewAddress()
                    : _addressCard(context, position, addresses[position],
                        _slidableController);
              },
              itemCount: addresses.length + 1,
            ),
          ),
        ),
      ],
    );
  }

  _addressCard(BuildContext context, int position, AddressModel address,
      SlidableController controller) {
    return GestureDetector(
      onTap: () {
        if (_selectedIndex == position) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => BuyingScreen()));
        } else {
          _showMessage();
          setState(() {
            _selectedIndex = position;
          });
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 6.h),
        child: Slidable(
          key: Key(address.id.toString()),
          controller: controller,
          child: _addressContent(position, address),
          secondaryActions: [
            _removeAction(context, position),
          ],
          actionPane: SlidableDrawerActionPane(),
          closeOnScroll: false,
          dismissal: SlidableDismissal(
            child: SlidableDrawerDismissal(),
            dragDismissible: false,
            onDismissed: (actionType) {
              setState(() {
                if (_selectedIndex == position) {
                  _selectedIndex = -1;
                } else {
                  _selectedIndex--;
                }
                addresses.removeAt(position);
              });
            },
          ),
        ),
      ),
    );
  }

  _addressContent(int position, AddressModel address) {
    return Container(
      height: 130.h,
      width: MediaQuery.of(context).size.width * .85,
      decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(6.r),
          boxShadow: [
            BoxShadow(
              color: blue2.withOpacity(.1),
              offset: Offset(0, 1),
              blurRadius: 6,
            )
          ]),
      padding: EdgeInsets.all(20.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Username',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '888859966',
                style: TextStyle(
                  color: grey2,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.normal,
                ),
                textDirection: TextDirection.ltr,
              ),
              Text(
                '${address.city},${address.bloc},${address.street},${address.homeNumber}',
                style: TextStyle(
                  color: grey2,
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 2),
              _editButton(),
            ],
          ),
          _selectCircle(position),
        ],
      ),
    );
  }

  _editButton() {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return EditAddress();
            },
          ),
        );
      },
      child: Text(
        getTranslated(context, "edit"),
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          color: primary,
        ),
      ),
    );
  }

  _selectCircle(int position) {
    return Container(
      height: 20.h,
      width: 20.h,
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: (_selectedIndex == position) ? primary : white,
        border: (_selectedIndex != position)
            ? Border.all(color: grey4, width: 2)
            : null,
        shape: BoxShape.circle,
      ),
      child: Align(
          child: SvgPicture.asset(
        "assets/icons/correct_2.svg",
        fit: BoxFit.cover,
        height: 8.h,
        width: 8.h,
        alignment: Alignment.center,
      )),
    );
  }

  _removeAction(BuildContext context, int position) {
    return SlideAction(
      onTap: () {
        _showRemoveSheet(context, position);
      },
      closeOnTap: false,
      child: Container(
        width: 80.w,
        height: 130.h,
        decoration: BoxDecoration(
            color: red1,
            borderRadius: BorderRadius.horizontal(right: Radius.circular(8.r))),
        child: Align(
          child: SvgPicture.asset(
            "assets/icons/remove.svg",
            fit: BoxFit.cover,
            height: 24.h,
            width: 20.w,
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
      barrierColor: black.withOpacity(.35),
      barrierDismissible: true,
    );
  }

  _addNewAddress() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 100.w),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return AddNewAddress();
          }));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add,
              color: primary,
            ),
            SizedBox(width: 10.w),
            Text(
              getTranslated(context, "add_new_address"),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMessage() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(getTranslated(context, 'click_again_to_continue'))));
  }
}

class EmptyAddresses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Spacer(flex: 2),
        SvgPicture.asset("assets/icons/empty_addresses.svg"),
        Spacer(flex: 1),
        Text(
          getTranslated(context, "no_addresses_currently"),
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          getTranslated(context, "you_can_add_new_address"),
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
        Spacer(flex: 1),
        AppButton(
          title: 'add_new_address',
            onPressed:() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return AddNewAddress();
                  },
                ),
              );
            },
          width: 0.9.sw,
        ),
        Spacer(flex: 4),
      ],
    );
  }
}
