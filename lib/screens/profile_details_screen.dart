import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:go_router/go_router.dart';

class ProfileDetailsScreen extends StatefulWidget {
  final List<String> imageList;

  const ProfileDetailsScreen(this.imageList, {super.key});

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() {
          _currentPage = next;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Container(
            padding: const EdgeInsets.only(left: 15),
            child: const Icon(
              PhosphorIcons.x_bold,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),
        backgroundColor: Colors.black,
        title: Text(
          '${_currentPage + 1}/${widget.imageList.length}',
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Pretendard',
            fontSize: 16,
          ),
        ),
      ),
      body: Container(
        color: Colors.black,
        child: SafeArea(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final double appBarHeight =
                  Scaffold.of(context).appBarMaxHeight ?? 0;
              final double availableHeight =
                  constraints.maxHeight - appBarHeight;
              return Center(
                child: SizedBox(
                  height: availableHeight,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: widget.imageList.length,
                    itemBuilder: (context, index) {
                      return Hero(
                        tag: widget.imageList[index],
                        child: InteractiveViewer(
                          panEnabled: false,
                          minScale: 0.5,
                          maxScale: 4,
                          child: Image.network(
                            widget.imageList[index],
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
