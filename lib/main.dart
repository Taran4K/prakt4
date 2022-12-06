import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prakt4/cubit/click_cubit.dart';

List<String> history = [];
int count = 0;
String themeName = "Light";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<SwitchCubit>(
      create: (context) => SwitchCubit(),
      child: BlocBuilder<SwitchCubit, SwitchState>(
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: state.theme,
              home: BlocProvider(
                create: (context) => ClickCubit(),
                child: MyHomePage(),
              ));
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            BlocBuilder<ClickCubit, ClickState>(
              builder: (context, state) {
                if (state is ClickError) {
                  return Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: Text(
                      state.message,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  );
                }
                if (state is Click) {
                  if (history.isNotEmpty) {
                    if (count != state.count) {
                      history.add(state.count.toString() + " - " + state.theme);
                    }
                  } else {
                    history.add(state.count.toString() + " - " + state.theme);
                  }
                  count = state.count;
                  context.read<SwitchCubit>().toggleSwitch(null, false);
                  return Container(
                    height: 50,
                    width: 50,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: Text(
                      state.count.toString(),
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  );
                }
                return Container();
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    context.read<ClickCubit>().onClick(1);
                  },
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
                SizedBox(
                  width: 20,
                ),
                FloatingActionButton(
                  onPressed: () {
                    context.read<ClickCubit>().onClick(-1);
                  },
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Container(
                    width: 800,
                    height: 450,
                    child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: history.length,
                        itemBuilder: (BuildContext context, int index) {
                          return BlocBuilder<ClickCubit, ClickState>(
                            builder: (context, state) {
                              if (state is Click) {
                                return Container(
                                  padding: EdgeInsets.symmetric(horizontal: 50),
                                  child: Text(history[index],
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium),
                                          alignment: Alignment.center,
                                );
                              }
                              return Container();
                            },
                          );
                        }),
                  ),
              ],
            ),
            Container(
              alignment: Alignment.centerRight,
              child: BlocBuilder<SwitchCubit, SwitchState>(
                builder: (context, state) {
                  return Switch(
                    value: state.isDarkThemeOff,
                    
                    onChanged: (newValue) {
                      context.read<SwitchCubit>().toggleSwitch(newValue, true);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
