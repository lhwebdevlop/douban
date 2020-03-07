import 'package:flutter/material.dart';
// 图片像心脏一样收缩和舒张
class HeartImgWidget extends StatefulWidget{
  final Image img;
  HeartImgWidget(this.img,{Key key}) : super(key:key);

  @override
  State<StatefulWidget> createState() {
    
    return _HeartImgWidgetState();
  }
  
}

class _HeartImgWidgetState extends State<HeartImgWidget>
// 通过 SingleTickerProviderStateMixin 实现 Tab 的动画切换效果
 with SingleTickerProviderStateMixin{
   AnimationController controller;
   Animation<double> animation;

  @override
  void initState(){
    super.initState();
    controller = new AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this
    );
    animation = new CurvedAnimation(parent: controller, curve: Curves.easeIn)
      ..addStatusListener((status){
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }
  @override
  Widget build(BuildContext context) {
    
    return _AnimatedImg(widget.img, animation: animation);
  }

  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
}
class _AnimatedImg extends AnimatedWidget{
  static final _opacityTween = new Tween<double>(begin: 0.5, end: 1.0);
  static final _sizeTween = new Tween<double>(begin: 290.0, end: 300.0);
  final Image img;
  _AnimatedImg(this.img, {Key key, Animation<double> animation})
    : super (key:key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          height: _sizeTween.evaluate(animation),
          width: _sizeTween.evaluate(animation),
          child: img,
        ),
      ),
    );
  }
  
}