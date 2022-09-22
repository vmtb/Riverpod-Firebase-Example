import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controllers/test_controller.dart';
import '../utils/providers.dart';
import 'package:intl/intl.dart';

final currentBackground= StateProvider<Color?>((ref)=>Colors.grey[100]);

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notre app"),
      ),
      backgroundColor: ref.watch(currentBackground),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addElement();
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          SwitchListTile(value: ref.read(currentBackground.state).state
              == Colors.grey[100]?false:true,
              title: const Text("Changer la couleur de fond en noir"), onChanged: (e){
            if(e){
              ref.read(currentBackground.state).state = Colors.black87;
            }else{
              ref.read(currentBackground.state).state = Colors.grey[100];
            }
          }),

          ref.watch(fetchAllTest).when(
              data: (data) {
                if (data.isEmpty) {
                  return const Center(
                    child: Text("No data"),
                  );
                }

                return ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(data[index].text),
                      subtitle: Text(DateFormat("dd MMM yyyy")
                          .format(DateTime.parse(data[index].time))),
                    );
                  },
                  shrinkWrap: true,
                  itemCount: data.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                );
              },
              error: (err, stackErr) {
                print(stackErr!);
                return const Text("Something is wrong...");
              },
              loading: () => const Center(child: CircularProgressIndicator())),
        ],
      ),
    );
  }

  void addElement() {
    showDialog(
        context: context,
        builder: (context2) {
          final controller = TextEditingController();
          bool isLoading = false;

          return AlertDialog(
            content: SizedBox(
              height: 120,
              child: StatefulBuilder(builder: (context, ourSetState) {
                return Column(
                  children: [
                    TextFormField(
                      controller: controller,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    isLoading
                        ? const CupertinoActivityIndicator()
                        : TextButton(
                        onPressed: () async {
                          String text = controller.text;
                          if (text.isNotEmpty) {
                            ourSetState(() {
                              isLoading = true;
                            });
                            await ref
                                .read(testController)
                                .saveToFirestore(text);
                            ref.refresh(fetchAllTest);
                            ourSetState(() {
                              isLoading = false;
                            });
                            Navigator.pop(context2);
                          }
                        },
                        child: const Text("Sauvegarder"))
                  ],
                );
              }),
            ),
          );
        });
  }
}


class Test extends ConsumerWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container();
  }
}

