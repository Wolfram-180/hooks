import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

///* 3
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
//*/

void main() {
  runApp(
    MaterialApp(
      title: 'Test app',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    ),
  );
}

///* 3
const url = 'http://bit.ly/3wh1u1S';
//*/

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

    ///* 3
    NetworkAssetBundle(Uri.parse(url))
        .load(url)
        .then((data) => data.buffer.asUint8List())
        .then((data) => Image.memory(data));
//*/
    return Scaffold(
      appBar: AppBar(
        /* 1
         title: Text(dateTime.data ?? 'Home page'),
         */
        title: Text('Home page'),
      ),
/* 2
  body: Column(
        children: [
          TextField(
            controller: controller,
          ),
          Text('You typed ${text.value}'),
        ],
), */
    );
  }
}

/* 1
 Stream<String> getTime() => Stream.periodic(
     const Duration(seconds: 1), (_) => DateTime.now().toIso8601String());
*/     
