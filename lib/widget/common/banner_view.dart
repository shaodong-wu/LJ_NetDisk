import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class BannerView extends StatelessWidget {

  const BannerView(this.images, {
    Key? key,
    this.height,
    this.activeColor,
    this.onTap,
  }) : super(key: key);

  Widget _swiperBuilder(BuildContext context, int index) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(12.0), // 弧度
        child: Image.network(images[index], fit: BoxFit.fill)
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: height ?? 80.0,
      child: Swiper(
        itemCount: images.length,
        itemBuilder: _swiperBuilder,
        pagination: SwiperPagination(
            margin: const EdgeInsets.only(bottom: 3),
            builder: DotSwiperPaginationBuilder(
                color: Colors.black.withOpacity(.1),
                activeColor: activeColor ?? Colors.blue,
                size: 5.0,
                activeSize: 5.0
            )
        ),
        scrollDirection: Axis.horizontal,
        autoplay: true,
        onTap: onTap,
      ),
    );
  }

  /// 轮播图列表
  final List<String> images;

  /// 横幅高度
  final double? height;

  /// 指示器选中颜色
  final Color? activeColor;

  /// 点击执行动作
  final void Function(int)? onTap;

}