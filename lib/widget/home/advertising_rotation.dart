import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lj_netdisk/common/iconfonts_data.dart';

import '../common/banner_view.dart';

class AdvertisingRotation extends StatefulWidget {
  const AdvertisingRotation({Key? key}) : super(key: key);

  @override
  _AdvertisingRotationState createState() => _AdvertisingRotationState();
}

class _AdvertisingRotationState extends State<AdvertisingRotation> {

  /// 是否显示横幅
  bool isShow = true;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isShow,
      child: Stack(
        children: [
          const BannerView([
            'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fup.enterdesk.com%2Fedpic_source%2F53%2F0a%2Fda%2F530adad966630fce548cd408237ff200.jpg&refer=http%3A%2F%2Fup.enterdesk.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1641732602&t=4dc373c0452d256bd9282c7a9c7d773e',
            'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Ffile02.16sucai.com%2Fd%2Ffile%2F2014%2F0829%2Fb871e1addf5f8e96f3b390ece2b2da0d.jpg&refer=http%3A%2F%2Ffile02.16sucai.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1641732602&t=71c47e743e4f92e9bd58756730632109',
            'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fwallcoo.com%2Fnature%2FSZ_178_Water_Air_and_Greenery%2Fimages%2FHJ069_350A.jpg&refer=http%3A%2F%2Fwallcoo.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1641732602&t=3cca7ee23054c614385df4aea3d631e6'
          ]),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
                icon: Icon(IconfontsData.close, color: Colors.white, size: 12),
                onPressed: () => setState(() {
                  isShow = !isShow;
                })
            ),
          )
        ],
      ),
    );
  }
}