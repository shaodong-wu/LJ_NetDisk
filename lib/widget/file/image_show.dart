import 'package:flutter/material.dart';
import 'package:lj_netdisk/common/images_data.dart';
import 'package:lj_netdisk/utils/tools/local_storage.dart';
import 'package:lj_netdisk/utils/tools/network_image_ssl.dart';
import 'package:lj_netdisk/widget/common/loading.dart';
import 'package:lj_netdisk/widget/user/common/title.dart';
import 'package:photo_view/photo_view.dart';

class ImageShow extends StatefulWidget {
  final String imageUrl;

  final String fileName;

  const ImageShow({
    Key? key,
    required this.imageUrl,
    this.fileName = "",
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ImageShowState();
}

class _ImageShowState extends State<ImageShow> {

  Image? image;

  bool isloaded = false;

  @override
  void initState() {
    super.initState();
    _getImage();
  }

  Future _getImage() async {
    Map<String, String> headers = {};
    // 请求截拦
    List<dynamic>? credentials = await LocalStorage.get('credentials');
    if (credentials != null && credentials.isNotEmpty) {
      // 将多个内容凭借为字符串
      String credentialsStr =
      credentials.map((item) => (item as String).split(';')[0]).join(',');
      // 添加请求头
      headers.addAll({'Cookie-Credentials': credentialsStr});
    }
    var img = Image(
      image: NetworkImageSSL(
        widget.imageUrl,
        headers: headers,
        callback: () {
          setState(() {
            isloaded = true;
          });
        }
      ),
    );
    setState(() {
      image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomTitle(
        backgroundcolor: Colors.black,
        foregroundColor: Colors.white,
        title: widget.fileName,
      ),
      body: Stack(
        children: [
          Offstage(
            offstage: isloaded,
              child: const Center(child: CustomLoading())
          ),
          Offstage(
            offstage: !isloaded,
            child: PhotoView(
              imageProvider: image == null
                  ? Image.asset(CommonImagesData.fileType["image"].toString()).image
                  : image!.image,
            ),
          )
        ],
      )
    );
  }
}
