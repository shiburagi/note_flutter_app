import 'package:business_logic/bloc/note.dart';
import 'package:coordinator_layout/coordinator_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        sliver: SliverSafeArea(
          top: false,
          bottom: false,
          sliver: SliverCollapsingHeader(
            builder: (context, offset, diff) {
              return Stack(
                children: [
                  buildAppBar(),
                  buildBottom(context, offset),
                ],
              );
            },
          ),
        ),
      );
    });
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.menu),
        onPressed: () {},
      ),
      actions: [
        Container(
          width: 48,
          height: 48,
          margin: EdgeInsets.only(right: 16),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: InkWell(
            child: Image.network(
              "https://images.pexels.com/photos/614810/pexels-photo-614810.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=60",
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }

  Positioned buildBottom(BuildContext context, double offset) {
    double curveOffset = Curves.easeInOut.transform(offset);
    double curveInverseOffset = Curves.decelerate.transform(1 - offset);

    double adjustBottom = curveOffset * 8;
    double adjustLeft = curveInverseOffset * 40;
    double adjustRight = curveInverseOffset * 64;
    double adjustPaddingVertical = curveOffset * 4;
    return Positioned(
      left: 16 + adjustLeft,
      right: 16 + adjustRight,
      bottom: 8 + adjustBottom,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Opacity(
            opacity: curveOffset,
            child: Container(
              margin: EdgeInsets.fromLTRB(8, 8, 8, 16),
              child: Text(
                "Hi, Michael",
                style: Theme.of(context).primaryTextTheme.headline4,
              ),
            ),
          ),
          TextField(
            onChanged: (value) =>
                context.read<NoteBloc>().filter(searchText: value),
            decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.fromLTRB(16,
                    12 + adjustPaddingVertical, 16, 12 + adjustPaddingVertical),
                filled: true,
                fillColor: Theme.of(context).cardColor,
                hintText: "Find note (title, text, tag)",
                border: OutlineInputBorder(borderSide: BorderSide.none)),
          ),
        ],
      ),
    );
  }
}
