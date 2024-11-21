
import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomePage(); 
  }
}

class _HomePage extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // SafeArea留白组件  
      body: SafeArea(child: Column(children: [
        // 容器
        Container(
          height: 150,
          width: double.infinity,
          child: Swiper(
            indicatorLayout: PageIndicatorLayout.NONE,
            autoplay: true,
            pagination: const SwiperPagination(),
            control: const SwiperControl(),
            itemCount: 3,
            itemBuilder: (context, index) {
             return Container(
              height: 150,
              color: Colors.lightGreen[300],
             ); 
            },
          ),
        ),
        // Expanded 填充剩余所有空白  ListView.builder 列表清单
        Expanded(child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index){
            return _listItemVIew();
          },
        ))
      ])),
    );
  }

  Widget _listItemVIew(){
    return Column(children: [
      Row(children: [
        // 本地资源
        // Image.asset(name)
        // api
        Image.network("https://tse1-mm.cn.bing.net/th/id/OIP-C.zF3IWg3TWafxNR5mnujBrgHaHX?rs=1&pid=ImgDetMain",
          width: 30,height: 30,
        ),
        const Text("作者"),
        const Expanded(child: SizedBox()),
        const Text("作者2024-10-28"),
        const Text("置顶"),
      ])
    ]);
  }
}

