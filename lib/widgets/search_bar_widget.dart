import 'package:flutter/material.dart';

class ModernSearchBar extends StatefulWidget {
  @override
  _ModernSearchBarState createState() => _ModernSearchBarState();
}

class _ModernSearchBarState extends State<ModernSearchBar> {
  TextEditingController _controller = TextEditingController();
  bool _showClearButton = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11.0),
        color: Color(0xFF9CA3AF).withOpacity(.2),
      ),
      width: 280.0,
      height: 36.0,
      child: TextField(
        onTap: () {},
        controller: _controller,
        onChanged: (value) {
          setState(() {
            _showClearButton = value.isNotEmpty;
          });
        },
        decoration: InputDecoration(
          contentPadding: EdgeInsets.zero,
          prefixIcon: Image.asset(
            "assets/icons/search_icon.png",
            color: Color(0xFF9CA3AF),
          ),
          hintText: 'Search',
          hintStyle: TextStyle(
            color: Color(0xFF9CA3AF),
            fontSize: 14.0,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(11.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFE6E7E9)),
            borderRadius: BorderRadius.circular(11.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(11.0),
          ),
          suffixIcon: _showClearButton
              ? IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    setState(() {
                      _controller.clear();
                      _showClearButton = false;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
