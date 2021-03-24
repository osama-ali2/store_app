import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yagot_app/utilities/helper_functions.dart';
import 'package:yagot_app/utilities/none_glow_scroll_behavior.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  FocusNode node1, node2, node3, node4;
  TextEditingController addProductController,
      priceController,
      otherDetailsController;
  int _sectionChoiceValue;

  String dropdownError = "";
  List<String> _sections;

  List<DropdownMenuItem> _dropItems;

  final _formKey = GlobalKey<FormState>();
  ImagePicker picker;
  File mainImage;

  @override
  void initState() {
    super.initState();
    node1 = FocusNode();
    node2 = FocusNode();
    node3 = FocusNode();
    node4 = FocusNode();

    addProductController = TextEditingController();
    priceController = TextEditingController();
    otherDetailsController = TextEditingController();
    picker = ImagePicker();
  }

  @override
  void dispose() {
    super.dispose();
    addProductController.dispose();
    priceController.dispose();
    otherDetailsController.dispose();
    node1.dispose();
    node2.dispose();
    node3.dispose();
    node4.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _sections = [
      getTranslated(context, "gemstones"),
      getTranslated(context, "jewelry_diamonds"),
      getTranslated(context, "antiques_accessories"),
      getTranslated(context, "other_products"),
    ];
    _dropItems = _buildDropDownItems(_sections);

    return Scaffold(
      appBar: _appBar(),
      body: _bodyContent(),
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
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
          color: Color(0xFF00041D),
        ),
      ),
    );
  }

  Widget _bodyContent() {
    return ScrollConfiguration(
      behavior: NoneGlowScrollBehavior(),
      child: Form(
        key: _formKey,
        child: ListView(
          children: [
            _subtitle("main_image"),
            SizedBox(height: 20),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: _addImage(mainImage),
            ),
            SizedBox(height: 20),
            _subtitle("sub_images"),
            SizedBox(height: 15),
            _addImage(mainImage),
            SizedBox(height: 20),
            _subtitle("product_name"),
            SizedBox(height: 15),
            _textField("product_name", "enter_product_name",
                addProductController, Fields.addProduct, node1, node2),
            SizedBox(height: 20),
            _subtitle("section"),
            SizedBox(height: 15),
            _dropDownButton(_dropItems),
            SizedBox(height: 20),
            _subtitle("price"),
            SizedBox(height: 15),
            _textField("price", "enter_price", priceController, Fields.price,
                node3, node4),
            SizedBox(height: 20),
            _subtitle("certificate_registration_product"),
            SizedBox(height: 20),
            _addImage(mainImage),
            SizedBox(height: 20),
            _subtitle("other_details"),
            SizedBox(height: 15),
            _textField("add_details_here", "", otherDetailsController,
                Fields.otherDetails, node4, node4),
            SizedBox(height: 60),
            _addButton(),
          ],
          padding: EdgeInsets.all(30),
        ),
      ),
    );
  }

  Widget _subtitle(String textKey) {
    return Text(getTranslated(context, textKey));
  }

  Widget _addImage(File image) {
    return (image != null)
        ? _imageContainer(image)
        : DottedBorder(
            color: Color(0xFF203152).withOpacity(.2),
            dashPattern: [3, 3],
            strokeWidth: 1,
            radius: Radius.circular(8),
            strokeCap: StrokeCap.round,
            borderType: BorderType.RRect,
            padding: EdgeInsets.zero,
            child: InkWell(
              onTap: () {
                _pickImage().then((image) {
                  setState(() {
                    mainImage = image;
                  });
                });
              },
              child: Container(
                height: 80,
                width: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.add,
                      size: 50,
                      color: Color(0xFF00041D).withOpacity(.5),
                    ),
                    Text(
                      getTranslated(context, "image"),
                      style: TextStyle(
                        color: Color(0xFF00041D).withOpacity(.5),
                      ),
                    ),
                    SizedBox(height: 6),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF9EA1AF).withOpacity(.2),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          );
  }

  // _showImage(File image) {
  //   if (image != null) {
  //     _imageContainer(image);
  //   }
  // }

  Widget _imageContainer(File image) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(end: 12, top: 12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.file(
              image,
              fit: BoxFit.cover,
              height: 80,
              width: 80,
            ),
          ),
        ),
        _exit(image),
      ],
    );
  }

  Widget _exit(File image) {
    return GestureDetector(
      onTap: () {
        setState(() {
          mainImage = null;
        });
      },
      child: Container(
        height: 24,
        width: 24,
        child: Icon(
          Icons.close,
          color: Colors.white,
          size: 16,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  _textField(String hintKey, String errorKey, TextEditingController controller,
      Fields field, FocusNode node, FocusNode nextNode) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: getTranslated(context, hintKey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:
              BorderSide(color: Color(0xFF00041D).withOpacity(.2), width: 1),
        ),
        suffixText: (field == Fields.price) ? "ريال" : "",
      ),
      maxLines: (field == Fields.otherDetails) ? 3 : 1,
      focusNode: node,
      onFieldSubmitted: (input) {
        print("sub");
        if (field != Fields.otherDetails) {
          FocusScope.of(context).requestFocus(nextNode);
        } else {
          FocusScope.of(context).unfocus();
        }
      },
      textInputAction: (field == Fields.otherDetails)
          ? TextInputAction.newline
          : TextInputAction.next,
      inputFormatters: (field == Fields.price)
          ? [FilteringTextInputFormatter.digitsOnly]
          : [],
      keyboardType: (field == Fields.price)
          ? TextInputType.number
          : (field == Fields.otherDetails)
              ? TextInputType.multiline
              : TextInputType.text,
      validator: (input) {
        if (input.isEmpty && field != Fields.otherDetails) {
          return getTranslated(context, errorKey);
        }
        return null;
      },
    );
  }

  Future<File> _pickImage() async {
    PickedFile file = await picker.getImage(source: ImageSource.gallery);
    File image;
    if (file != null) {
      image = File(file.path);
    }
    return image;
  }

  Widget _addButton() {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xFF00041D).withOpacity(.16),
            offset: Offset(0, 3),
            blurRadius: 6,
          )
        ],
      ),
      child: RaisedButton(
        onPressed: () {
          if (_sectionChoiceValue == null) {
            setState(() {
              dropdownError = getTranslated(context, "choose_section");
            });
          } else {
            setState(() {
              dropdownError = "";
            });
          }
          if (_formKey.currentState.validate()) {
          } else {}
        },
        child: Text(
          getTranslated(context, "add"),
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        color: Theme.of(context).primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }

  List<DropdownMenuItem> _buildDropDownItems(List<String> sections) {
    return sections.map((section) {
      return DropdownMenuItem(
        child: Text(section),
        value: sections.indexOf(section),
        onTap: () {
          FocusScope.of(context).requestFocus(node3);
        },
      );
    }).toList();
  }

  Widget _dropDownButton(List<DropdownMenuItem> dropItems) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 60,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Color(0xFF00041D).withOpacity(.16),
            ),
          ),
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: DropdownButton(
            items: dropItems,
            onChanged: (value) {
              setState(() {
                _sectionChoiceValue = value;
              });
            },
            hint: Text(getTranslated(context, "choose_section")),
            iconEnabledColor: Color(0xFF203152),
            value: _sectionChoiceValue,
            focusNode: node2,
            isExpanded: true,
            underline: Container(),
            onTap: () {},
          ),
        ),
        Text(
          dropdownError,
          style: TextStyle(
            color: Colors.red,
            wordSpacing: 2,
            height: 1.5,
          ),
        )
      ],
    );
  }
}

enum Fields {
  addProduct,
  section,
  price,
  otherDetails,
}
