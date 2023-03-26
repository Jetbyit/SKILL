import 'package:flutter/material.dart';
import 'package:job_portal/src/data/models/dating_model.dart';
import 'package:job_portal/src/presentation/widgets/common_cached_image.dart';
import 'package:job_portal/src/utils/colors.dart';
import 'package:nb_utils/nb_utils.dart';

class AMessageFragment extends StatefulWidget {
  @override
  AMessageFragmentState createState() => AMessageFragmentState();
}

class AMessageFragmentState extends State<AMessageFragment> {
  List<DatingAppModel> list = getAllListData();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    list.shuffle();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat', style: TextStyle(color: jobportalBrownColor),),
        backgroundColor: Colors.white,//jobportalBrownColor
        elevation: 0,
        //centerTitle: true,
        leading: const Icon(Icons.chat_bubble_outline_rounded, color: jobportalBrownColor,),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: jobportalBrownColor,),
            onPressed: (){

            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            8.height,
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text('chat', style: boldTextStyle()),
            //     Icon(Icons.search),
            //   ],
            // ).paddingOnly(left: 16, right: 16, top: 16),
            ListView.builder(
              padding: EdgeInsets.all(8),
              shrinkWrap: true,
              itemCount: list.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                DatingAppModel data = list[index];
                return Container(
                    decoration: boxDecorationWithShadow(
                      borderRadius: BorderRadius.circular(16),
                      backgroundColor: context.cardColor,
                    ),
                    margin: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CommonCachedNetworkImage(imageUrl: data.image, height: 80, width: 80,),
                        ),
                        16.width,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data.name.validate(),
                              style: boldTextStyle(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            8.height,
                            Text(
                              data.subTitle1.validate(),
                              style: secondaryTextStyle(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Spacer(),
                        IconButton(
                          icon: Icon(Icons.chat, color: jobportalBrownColor,),
                          onPressed: (){

                          },
                        ),
                      ],
                    ));
                // ).onTap(() {
                //   DAChatScreen(data: data).launch(context);
                // }, highlightColor: white, splashColor: white);
              },
            ),
          ],
        ),
      ),
    );
  }
}
