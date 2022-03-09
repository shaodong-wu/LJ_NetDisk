import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lj_netdisk/common/iconfonts_data.dart';
import 'package:lj_netdisk/widget/common/card.dart';
import 'package:lj_netdisk/widget/common/icon_text.dart';

class DocumentScan extends StatelessWidget {

  const DocumentScan({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      title: '文档扫描',
      body: Container(
        margin: const EdgeInsets.only(top: 16.0, bottom: 8.0),
        decoration: const BoxDecoration(
            color: Color.fromRGBO(250, 249, 255, 1),
            borderRadius: BorderRadius.all(Radius.circular(5.0))
        ),
        child: Row(
          children: [
            Container(
                width: 140,
                height: 125,
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(246, 247, 249, 1),
                    borderRadius: BorderRadius.all(Radius.circular(5.0))
                ),
                child: Center(
                    child: Image.asset('lib/assets/images/home_page/home_docscan_default.png', width: 120, fit: BoxFit.contain)
                )
            ),
            Container(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Text('文档扫描', style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                    )),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 12),
                    child: Text('书籍/文档/证件,生成电子版', style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey
                    )),
                  ),
                  CustomIconText('试一试', icon: Icon(IconfontsData.arrowright, size: 18), style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey
                  ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}