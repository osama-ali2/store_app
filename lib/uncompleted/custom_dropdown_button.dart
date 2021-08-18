import 'package:flutter/material.dart';
import 'package:yagot_app/constants/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdownButton extends StatefulWidget {
  final double height;

  final double width;
  final Color color;
  final Color iconColor;
  final Border border;

  final double borderRadius;

  final String hint;

  final TextStyle titleStyle;

  final List<Widget> items;

  final double itemExtent;

  final double dropdownBorderRadius;
  final Color dropdownColor;

  final double elevation;


  CustomDropdownButton({
    this.height,
    this.width,
    this.color,
    this.iconColor,
    this.border,
    this.borderRadius,
    this.hint,
    this.titleStyle,
    this.items,
    this.itemExtent,
    this.dropdownBorderRadius,
    this.dropdownColor,
    this.elevation});

  @override
  _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
}

class _CustomDropdownButtonState extends State<CustomDropdownButton>
    with SingleTickerProviderStateMixin {

  bool _isMenuOpened = false;
  LayerLink _layerLink = LayerLink();
  OverlayEntry _overlayEntry;
  String _title;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _title = widget.hint;
    _animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this,);
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  _openMenu(){

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry);
    _animationController.forward();
    _isMenuOpened = !_isMenuOpened;
  }
  _closedMenu(){
    _overlayEntry.remove();
    _animationController.reverse();
    _isMenuOpened = !_isMenuOpened;

  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Align(
        child: Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: widget.border,
          ),
          alignment: Alignment.center,
          child: ListTile(
            onTap: () async{
              if(_isMenuOpened){
                _closedMenu();
              }else{
                _openMenu();
              }

            },
            dense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
            title: Text(
              _title,
              style: widget.titleStyle,
            ),
            trailing: AnimatedIcon(
              icon: AnimatedIcons.menu_arrow,
              progress: _animationController,
              color: widget.iconColor,
            ),
          ),
        ),
      ),
    );
  }

  _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);
    return OverlayEntry(
      builder: (context) {
        return PositionedDirectional(
          width: size.width - 6,
          top: offset.dy,
          end: offset.dx,
          child: CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            offset: Offset(3, size.height + 5),
            child: Material(
              borderRadius: BorderRadius.circular(8.r),
              borderOnForeground: true,
              color: white,
              elevation: 8,
              child: ListView(
                children: [
                  Icon(Icons.image,),
                  Icon(Icons.image),
                  Icon(Icons.image),
                  Icon(Icons.image),
                ],
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                itemExtent: 100,
              ),
            ),
          ),
        );
      },
    );
  }
}
