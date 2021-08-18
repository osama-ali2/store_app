import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:yagot_app/models/home/category_model.dart';
import 'package:yagot_app/providers/general_provider.dart';
import 'package:yagot_app/screens/common/unregistered.dart';
import 'package:yagot_app/screens/common/widgets/app_button.dart';
import 'package:yagot_app/utilities/enums.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:yagot_app/utilities/none_glow_scroll_behavior.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  FocusNode node1, node2, node3, node4;
  TextEditingController productNameCtr, priceCtr, detailsCtr;
  int _sectionChoiceValue;
  int _categoryId;

  String dropdownError = "";
  Map<int, String> _currency = {1: 'ريال'};

  final _formKey = GlobalKey<FormState>();
  File mainImage;
  File certificateImage;
  List<File> subImages = [];
  ProgressDialog _progDialog;

  @override
  void initState() {
    super.initState();
    node1 = FocusNode();
    node2 = FocusNode();
    node3 = FocusNode();
    node4 = FocusNode();

    productNameCtr = TextEditingController();
    priceCtr = TextEditingController();
    detailsCtr = TextEditingController();
    _progDialog = ProgressDialog(
      context,
      isDismissible: true,
    );
    Provider.of<GeneralProvider>(context, listen: false).getCategories();
  }

  @override
  void dispose() {
    super.dispose();
    productNameCtr.dispose();
    priceCtr.dispose();
    detailsCtr.dispose();
    node1.dispose();
    node2.dispose();
    node3.dispose();
    node4.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _bodyContent(),
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: white,
      brightness: Brightness.light,
      title: Text(
        getTranslated(context, "adding_product"),
      ),
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

  Widget _bodyContent() {
    return ScrollConfiguration(
      behavior: NoneGlowScrollBehavior(),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(30.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _subtitle("main_image"),
                SizedBox(height: 20.h),
                AddImageBtn(
                  onChangeImage: (image) {
                    mainImage = image;
                  },
                ),
                SizedBox(height: 20.h),
                _subtitle("sub_images"),
                SizedBox(height: 15.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    4,
                    (index) => AddImageBtn(
                      onChangeImage: (image) {
                        if (subImages.length > index) {
                          subImages[index] = image;
                        } else {
                          subImages.add(image);
                        }
                      },
                    ),
                  ).toList(),
                ),
                SizedBox(height: 20.h),
                _subtitle("product_name"),
                SizedBox(height: 15.h),
                _textField("product_name", "enter_product_name", productNameCtr,
                    FieldType.addProduct, node1, node2),
                SizedBox(height: 20.h),
                _subtitle("section"),
                SizedBox(height: 15.h),
                _dropDownButton(),
                SizedBox(height: 20.h),
                _subtitle("price"),
                SizedBox(height: 15.h),
                _textField("price", "enter_price", priceCtr, FieldType.price,
                    node3, node4),
                SizedBox(height: 20.h),
                _subtitle("certificate_registration_product"),
                SizedBox(height: 20.h),
                AddImageBtn(),
                SizedBox(height: 20.h),
                _subtitle("other_details"),
                SizedBox(height: 15.h),
                _textField("add_details_here", "enter_other_details",
                    detailsCtr, FieldType.otherDetails, node4, node4),
                SizedBox(height: 60.h),
                AppButton(
                  title: 'add',
                  onPressed: onPressAddBtn,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Todo: .............
  // List<Widget> b() {
  //   if (list.length <= 4) {
  //     print("${list.length}  1");
  //     var c = AddImageBtn();
  //     c = AddImageBtn(
  //       onChangeImage: (image) {
  //         if (image != null) {
  //           // subImages[index] = image;
  //           // subImages.add(null);
  //           b();
  //           list.add(c);
  //           // print(index.toString() + 'subImages1');
  //         } else if (list.length != 1) {
  //           // print(index.toString() + 'subImages2');
  //           print(list);
  //           list.remove(c);
  //           // subImages.removeAt(index);
  //         }
  //       },
  //     );
  //     if(list.isEmpty){
  //       list.add(c);
  //     }
  //   }
  //   print("${list.length}   2");
  //
  //   setState(() {});
  //   return list;
  // }

  Widget _subtitle(String textKey) {
    return Text(getTranslated(context, textKey));
  }

  _textField(String hintKey, String errorKey, TextEditingController controller,
      FieldType field, FocusNode node, FocusNode nextNode) {
    return Container(
      height: (field == FieldType.otherDetails) ? null : 80.h,
      alignment: Alignment.bottomCenter,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: getTranslated(context, hintKey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: accent.withOpacity(.2), width: 1),
          ),
          suffixText: (field == FieldType.price) ? _currency.values.first : "",
        ),
        maxLines: (field == FieldType.otherDetails) ? 3 : 1,
        maxLength: (field == FieldType.otherDetails) ? 200 : 15,
        focusNode: node,
        onFieldSubmitted: (input) {
          print("sub");
          if (field != FieldType.otherDetails) {
            FocusScope.of(context).requestFocus(nextNode);
          } else {
            FocusScope.of(context).unfocus();
          }
        },
        textInputAction: (field == FieldType.otherDetails)
            ? TextInputAction.newline
            : TextInputAction.next,
        inputFormatters: (field == FieldType.price)
            ? [FilteringTextInputFormatter.digitsOnly]
            : [],
        keyboardType: (field == FieldType.price)
            ? TextInputType.number
            : (field == FieldType.otherDetails)
                ? TextInputType.multiline
                : TextInputType.text,
        validator: (input) {
          if (input.isEmpty) {
            return getTranslated(context, errorKey);
          }
          return null;
        },
      ),
    );
  }

  onPressAddBtn() async {
    bool _isCompleted = _sectionChoiceValue != null &&
        _formKey.currentState.validate() &&
        mainImage != null;
    if (_isCompleted) {
      if (Provider.of<GeneralProvider>(context, listen: false).isAuth) {
        _progDialog.show();
        final _data = {
          'title': productNameCtr.text,
          'details': detailsCtr.text,
          'price': priceCtr.text,
          'category_id': _categoryId,
          'currency_id': _currency.keys.first,
          'main_image': await MultipartFile.fromFile(mainImage.path,
              filename: mainImage.path.split('/').last),
          'images':
              subImages.where((element) => element != null).map((image) async {
            await MultipartFile.fromFile(image.path,
                filename: image.path.split('/').last);
          }).toList(),
          'certified_images': (certificateImage != null)
              ? await MultipartFile.fromFile(certificateImage.path,
                  filename: certificateImage.path.split('/').last)
              : '',
          'city_id': 5,
        };
        Provider.of<GeneralProvider>(context, listen: false)
            .addProduct(context, _data, () {}, () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => Unregistered(page: Pages.addProducts)));
        });
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Unregistered(
                      page: Pages.addProducts,
                    )));
      }
    } else {
      _formKey.currentState.validate();
      if (_sectionChoiceValue == null) {
        setState(() {
          dropdownError = getTranslated(context, "choose_section");
        });
      } else {
        setState(() {
          dropdownError = "";
        });
      }
      if (mainImage == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(getTranslated(context, 'add_main_image')),
          duration: Duration(seconds: 2),
        ));
      }
    }
  }

  Widget _dropDownButton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 60.h,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: accent.withOpacity(.16),
            ),
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Selector<GeneralProvider, List<CategoryModel>>(
            selector: (context, provider) => provider.categories,
            builder: (context, categories, child) {
              return DropdownButton(
                items: categories.map((category) {
                  return DropdownMenuItem(
                    child: Text(category.name),
                    value: categories.indexOf(category),
                    onTap: () {
                      FocusScope.of(context).requestFocus(node3);
                    },
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _categoryId = categories[value].id;
                    _sectionChoiceValue = value;
                  });
                },
                hint: Text(getTranslated(context, "choose_section")),
                iconEnabledColor: blue6,
                value: _sectionChoiceValue,
                focusNode: node2,
                isExpanded: true,
                underline: Container(),
                onTap: () {},
              );
            },
          ),
        ),
        Padding(
          padding: EdgeInsetsDirectional.only(start: 14.w, top: 8.h),
          child: Text(
            dropdownError,
            style: TextStyle(
              color: red1,
              wordSpacing: 2,
              height: 1.5,
              fontSize: 14.sp,
            ),
          ),
        )
      ],
    );
  }
}

class AddImageBtn extends StatefulWidget {
  const AddImageBtn({Key key, this.onChangeImage}) : super(key: key);
  final ValueChanged<File> onChangeImage;

  @override
  _AddImageBtnState createState() => _AddImageBtnState();
}

class _AddImageBtnState extends State<AddImageBtn> {
  ImagePicker _picker;
  File _image;

  @override
  void initState() {
    _picker = ImagePicker();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: (_image != null) ? _imageDisplay() : _emptyImage(),
    );
  }

  DottedBorder _emptyImage() {
    return DottedBorder(
      color: blue6.withOpacity(.2),
      dashPattern: [3, 3],
      strokeWidth: 1,
      radius: Radius.circular(8.r),
      strokeCap: StrokeCap.round,
      borderType: BorderType.RRect,
      padding: EdgeInsets.zero,
      child: InkWell(
        onTap: () {
          _pickImage().then((image) {
            setState(() {
              _image = image;
            });
            widget.onChangeImage(_image);
          }).onError((error, stackTrace) {
            print('error...$error');
          });
        },
        child: Container(
          height: 90.r,
          width: 90.r,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                Icons.add,
                size: 50,
                color: accent.withOpacity(.5),
              ),
              Text(
                getTranslated(context, "image"),
                style: TextStyle(
                  color: accent.withOpacity(.5),
                ),
              ),
              SizedBox(height: 6.h),
            ],
          ),
          decoration: BoxDecoration(
            color: grey6.withOpacity(.2),
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ),
    );
  }

  Widget _imageDisplay() {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(end: 10.w, top: 10.h),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: Image.file(
              _image,
              fit: BoxFit.cover,
              height: 90.r,
              width: 90.r,
            ),
          ),
        ),
        _cancelBtn(),
      ],
    );
  }

  Future<File> _pickImage() async {
    PickedFile pFile = await _picker.getImage(source: ImageSource.gallery);
    File image;
    if (pFile != null) {
      image = File(pFile.path);
    }
    return image;
  }

  Widget _cancelBtn() {
    return GestureDetector(
      onTap: () {
        setState(() {
          _image = null;
        });
        widget.onChangeImage(_image);
      },
      child: Container(
        height: 24.r,
        width: 24.r,
        child: Icon(
          Icons.close,
          color: white,
          size: 14,
        ),
        decoration: BoxDecoration(
          color: primary,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
