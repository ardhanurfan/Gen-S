import 'package:flutter/material.dart';
import 'package:music_player/shared/theme.dart';

class DetailGalleryPage extends StatelessWidget {
  const DetailGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return SliverPadding(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 20),
        sliver: SliverAppBar(
          stretch: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          titleSpacing: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: primaryColor,
                ),
              ),
              Text(
                "Album Name",
                style: primaryColorText.copyWith(
                  fontWeight: bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          backgroundColor: backgroundColor,
          floating: true,
          snap: true,
        ),
      );
    }

    Widget image1() {
      return ClipRRect(
        child: Image.asset(
          "assets/ex_gallery.png",
        ),
      );
    }

    Widget image2() {
      return ClipRRect(
        child: Image.asset(
          "assets/ex_gallery1.png",
        ),
      );
    }

    Widget image3() {
      return ClipRRect(
        child: Image.asset(
          "assets/ex_gallery2.png",
        ),
      );
    }

    Widget gridImages() {
      return GridView(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        children: [
          image1(),
          image2(),
          image3(),
          image1(),
          image2(),
          image3(),
          image1(),
          image2(),
          image3(),
          image1(),
          image2(),
          image3(),
          image1(),
          image2(),
          image3(),
          image1(),
          image2(),
          image3(),
          image1(),
          image2(),
          image3(),
          image1(),
          image2(),
          image3(),
          image1(),
          image2(),
          image3(),
        ],
      );
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              header(),
            ];
          },
          body: gridImages(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: secondaryColor,
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
