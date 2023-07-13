import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const GetMaterialApp(home: Home()));
}

class Controller extends GetxController {
  var count = 0.obs;
  var name = "chanuk".obs;
  var debouncedName = "".obs;

  Controller() {
    debounce(name, (value) => debouncedName.value = value,
        time: const Duration(seconds: 2));
  }

  increment() => count++;

  changeName(String newName) => name.value = newName;
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(context) {
    // Get.put()을 사용하여 클래스를 인스턴스화하여 모든 "child'에서 사용가능하게 합니다.
    final Controller c = Controller();

    return Scaffold(
        // count가 변경 될 때마다 Obx(()=> 를 사용하여 Text()에 업데이트합니다.
        appBar: AppBar(title: Obx(() => Text("Clicks: ${c.count}"))),

        // 8줄의 Navigator.push를 간단한 Get.to()로 변경합니다. context는 필요없습니다.
        body: Center(
            child: Column(
          children: [
            ElevatedButton(
                child: Text("Go to Other"), onPressed: () => Get.to(Other())),
            Obx(() => Text("${c.debouncedName} / ${c.name}")),
            SizedBox(
              width: 250,
              child: TextField(
                onChanged: (text) {
                  c.changeName(text);
                },
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            )
          ],
        )),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add), onPressed: c.increment));
  }
}

class Other extends StatelessWidget {
  // 다른 페이지에서 사용되는 컨트롤러를 Get으로 찾아서 redirect 할 수 있습니다.
  final Controller c = Get.find();

  @override
  Widget build(context) {
    // 업데이트된 count 변수에 연결
    return Scaffold(body: Center(child: Text("${c.count}")));
  }
}
