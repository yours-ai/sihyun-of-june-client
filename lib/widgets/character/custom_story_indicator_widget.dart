import 'package:flutter/material.dart';

class CustomStoryIndicator extends StatefulWidget {
  const CustomStoryIndicator(
      {super.key,
        required this.itemCount,
        required this.currentIndex,
        this.highlightColor = Colors.blue,
        this.defaultColor = Colors.white,
        this.indicatorSpacing = 6,
        this.interval = const Duration(seconds: 4)});

  final int itemCount;
  final ValueNotifier<int> currentIndex;
  final Duration interval;
  final Color highlightColor;
  final Color defaultColor;
  final double indicatorSpacing;

  @override
  State<StatefulWidget> createState() => _CustomStoryIndicatorState();
}

class _CustomStoryIndicatorState extends State<CustomStoryIndicator> {
  List<Widget> getListIndicator() {
    List<Widget> listWidget = [];
    for (var i = 0; i < widget.itemCount; i++) {
      listWidget.add(Expanded(
          child: StoryItem(
            interval: widget.interval,
            isSelected: i == widget.currentIndex.value,
            highlightColor: widget.highlightColor,
            defaultColor: widget.defaultColor,
            onComplete: _next,
            isFill: i < widget.currentIndex.value,
          )));
      if (i < widget.itemCount - 1) {
        listWidget.add(SizedBox(width: widget.indicatorSpacing));
      }
    }
    return listWidget;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.currentIndex,
        builder: (_, child) => Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: getListIndicator(),
        ));
  }

  void _next() {
    if (widget.currentIndex.value == widget.itemCount - 1) {
    } else {
      widget.currentIndex.value += 1;
    }
  }
}

class StoryItem extends StatefulWidget {
  const StoryItem(
      {super.key,
        required this.interval,
        this.isSelected = false,
        this.onComplete,
        required this.isFill,
        this.highlightColor = Colors.blue,
        this.defaultColor = Colors.white});

  final Duration interval;
  final bool isSelected;
  final bool isFill;
  final Color highlightColor;
  final Color defaultColor;
  final VoidCallback? onComplete;

  @override
  State<StatefulWidget> createState() => _StoryItemState();
}

class _StoryItemState extends State<StoryItem> with TickerProviderStateMixin {
  final double height = 3;
  final double height = 2.5;
  late AnimationController _progressAnimationController;
  late Animation _progressAnimation;

  @override
  void initState() {
    super.initState();
    _progressAnimationController =
        AnimationController(vsync: this, duration: widget.interval);
    _progressAnimation =
        Tween<double>(begin: 0, end: 1).animate(_progressAnimationController);
    _progressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete?.call();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isSelected) {
      _progressAnimationController.forward();
    } else {
      _progressAnimationController.reset();
    }

    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
          color: widget.defaultColor,
          borderRadius: BorderRadius.circular(height / 2)),
      child: AnimatedBuilder(
        animation: _progressAnimationController,
        builder: (_, child) => FractionallySizedBox(
          alignment: Alignment.centerLeft,
          heightFactor: 1,
          widthFactor: widget.isFill ? 1 : _progressAnimation.value,
          child: GestureDetector(
              onTap: () {
                if (_progressAnimationController.isAnimating) {
                  _progressAnimationController.stop();
                } else {
                  _progressAnimationController.forward();
                }
              },
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    color: widget.highlightColor,
                    borderRadius: BorderRadius.circular(height / 2)),
              )),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _progressAnimationController.dispose();
    super.dispose();
  }
}
