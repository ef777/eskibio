import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';

class Adetinput extends StatefulWidget {
  final int ilkadet, maxadet, minadet, artismikatri;
  final Function adetgetir;
  const Adetinput(
      {Key? key,
      this.artismikatri = 1,
      required this.ilkadet,
      required this.maxadet,
      required this.minadet,
      required this.adetgetir})
      : super(key: key);

  @override
  State<Adetinput> createState() => _AdetinputState();
}

class _AdetinputState extends State<Adetinput> {
  late int adet, artis = 1;
  late TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    artis = widget.artismikatri;
    adet = widget.ilkadet;
    _controller = TextEditingController(text: adet.toString());
  }

  sayidegitir() {
    // ignore: unrelated_type_equality_checks, unnecessary_null_comparison
    if (adet == "" || adet == null) {
      adet = 1;
    }
    widget.adetgetir(adet);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              adet = adet - artis;

              setState(() {
                _controller = TextEditingController(text: adet.toString());
              });
              sayidegitir();
            },
            icon: const Icon(
              FontAwesome.minus,
              size: 16,
            )),
        Expanded(
          child: Container(
            height: 34,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
            alignment: Alignment.center,
            decoration:
                BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
            child: TextField(
              onChanged: (val) {
                setState(() {
                  adet = int.parse(val);
                });
              },
              keyboardType: TextInputType.number,
              textDirection: TextDirection.rtl,
              controller: _controller,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(0),
                border: InputBorder.none,
              ),
              style: const TextStyle(
                fontSize: 16,
                height: 0,
                color: Colors.black,
              ),
            ),
          ),
        ),
        IconButton(
            onPressed: () {
              adet = adet + artis;
              setState(() {
                _controller = TextEditingController(text: adet.toString());
              });
              sayidegitir();
            },
            icon: const Icon(
              FontAwesome.plus,
              size: 16,
            )),
      ],
    );
  }
}
