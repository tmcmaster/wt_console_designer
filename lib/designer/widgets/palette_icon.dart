import 'package:flutter/material.dart';

class PaletteIcon extends StatefulWidget {
  final IconData icon;
  final String label;

  const PaletteIcon({
    super.key,
    required this.icon,
    required this.label,
  });

  @override
  State<PaletteIcon> createState() => _PaletteIconState();
}

class _PaletteIconState extends State<PaletteIcon> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: hovering ? 10 : 0),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(6)),
              boxShadow: hovering
                  ? [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: hovering ? 4 : 0,
                        blurRadius: hovering ? 4 : 0,
                        offset: const Offset(-3, 3), // changes position of shadow
                      ),
                    ]
                  : null,
            ),
            child: InkWell(
              onTap: () {},
              onHover: (state) {
                setState(() {
                  hovering = state;
                });
              },
              child: Icon(widget.icon),
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            widget.label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
