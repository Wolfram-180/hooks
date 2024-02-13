import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/* 3
extension CompactMap<T> on Iterable<T?> {
  Iterable<T> compactMap<E>([
    E? Function(T?)? transform,
  ]) =>
      map(
        transform ?? (e) => e,
      )
          .where(
            (e) => e != null,
          )
          .cast();
}
*/

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    ),
  );
}

/* 3
const url = 'http://bit.ly/3wh1u1S';
*/

// /* 5
const url = 'http://bit.ly/3wh1u1S';
const imageHeight = 300.0;

extension Normalize on num {
  num normalized(
    num selfRangeMin,
    num selfRangeMax, [
    num normalizedRangeMin = 0.0,
    num normalizedRangeMax = 1.0,
  ]) =>
      (normalizedRangeMax - normalizedRangeMin) *
          ((this - selfRangeMin) / (selfRangeMax - selfRangeMin)) +
      normalizedRangeMin;
}
// */

class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
/* 1
    final dateTime = useStream(getTime()); 
*/
/* 2
   final controller = useTextEditingController();
    final text = useState('');
    useEffect(
      () {
        controller.addListener(
          () {
            text.value = controller.text;
          },
        );
        return null;
      },
      [controller],
    ); 
*/
/* 3.1
    final image = useFuture(
      NetworkAssetBundle(Uri.parse(url))
          .load(url)
          .then((data) => data.buffer.asUint8List())
          .then(
            (data) => Image.memory(data),
          ),
    );
*/
/* 3.2
    final future = useMemoized(
      () => NetworkAssetBundle(Uri.parse(url))
          .load(url)
          .then((data) => data.buffer.asUint8List())
          .then(
            (data) => FittedBox(
              fit: BoxFit.fitHeight,
              child: Image.memory(data),
            ),
          ),
    );

    final snapshot = useFuture(future);
*/
/* 4
    final countDown = useMemoized(() => CountDown(from: 20));
    final notifier = useListenable(countDown);
*/

// /* 5
    final opacity = useAnimationController(
      duration: const Duration(seconds: 1),
      initialValue: 1.0,
      lowerBound: 0.0,
      upperBound: 1.0,
    );

    final size = useAnimationController(
      duration: const Duration(seconds: 1),
      initialValue: 1.0,
      lowerBound: 0.0,
      upperBound: 1.0,
    );

    final controller = useScrollController();

    useEffect(
      () {
        controller.addListener(() {
          final newOpacity = max(imageHeight - controller.offset, 0.0);
          final normalized = newOpacity.normalized(0.0, imageHeight).toDouble();
          opacity.value = normalized;
          size.value = normalized;
        });
        return null;
      },
      [controller],
    );
// */
    return Scaffold(
      appBar: AppBar(
/* 1
         title: Text(dateTime.data ?? 'Home page'),
*/
        title: const Text('Home page'),
      ),
/* 2
  body: Column(
        children: [
          TextField(
            controller: controller,
          ),
          Text('You typed ${text.value}'),
        ],
), 
*/
/* 3
      body: Column(
        children: [snapshot.data].compactMap().toList(),
      ),
*/
/* 4
      body: Center(
        child: Column(
          children: [
            Text(
              notifier.value.toString(),
            ),
          ],
        ),
      ),
*/
// /* 5
      body: Column(
        children: [
          SizeTransition(
            sizeFactor: size,
            axis: Axis.vertical,
            axisAlignment: -1.0,
            child: FadeTransition(
              opacity: opacity,
              child: Image.network(
                url,
                height: imageHeight,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                controller: controller,
                itemCount: 100,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      'Person ${index + 1}',
                    ),
                  );
                }),
          ),
        ],
      ),
// */
    );
  }
}

/* 1
 Stream<String> getTime() => Stream.periodic(
     const Duration(seconds: 1), (_) => DateTime.now().toIso8601String());
*/

/* 4
class CountDown extends ValueNotifier<int> {
  late StreamSubscription sub;
  CountDown({required int from}) : super(from) {
    sub = Stream.periodic(const Duration(seconds: 1), (v) => from - v)
        .takeWhile((value) => value >= 0)
        .listen(
      (value) {
        this.value = value;
      },
    );
  }

  @override
  void dispose() {
    sub.cancel();
    super.dispose();
  }
}
*/
