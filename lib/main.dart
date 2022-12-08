import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prakt4/cubit/click_cubit.dart';

int countforhistory = 0;
int countlistitems = 0;
List<String> history =[];

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

bool LightMode = true;

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
                  countforhistory = state.count.round();
                  return Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.black)),
                    child: Text(
                      countforhistory.toString(),
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
                    if (LightMode)
                      context.read<ClickCubit>().onClick(1, "+");
                    else
                      context.read<ClickCubit>().onClick(2, "+");
                  },
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
                SizedBox(
                  width: 20,
                ),
                FloatingActionButton(
                  onPressed: () {
                    if (LightMode)
                      context.read<ClickCubit>().onClick(1, "-");
                    else
                      context.read<ClickCubit>().onClick(2, "-");
                  },
                  tooltip: 'Decrement',
                  child: const Icon(Icons.remove),
                ),
                FloatingActionButton(
                  onPressed: () {
                    if (LightMode)
                      context.read<ClickCubit>().onClick(2, "*");
                    else
                      context.read<ClickCubit>().onClick(4, "*");
                  },
                  tooltip: 'Multiply',
                  child: const Icon(Icons.clear),
                ),
                SizedBox(
                  width: 20,
                ),
                FloatingActionButton(
                  onPressed: () {
                    if (LightMode)
                      context.read<ClickCubit>().onClick(2, "/");
                    else
                      context.read<ClickCubit>().onClick(4, "/");
                  },
                  tooltip: 'Divission',
                  child: const Icon(Icons.undo),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 800,
                  height: 450,
                  child: BlocBuilder<ClickCubit, ClickState>(
                          builder: (context, state) {
                            if (state is Click) {
                              history.add(state.history.toString());
                              return ListView.builder(
                                  padding: const EdgeInsets.all(8),
                                  itemCount: state.history.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 50),
                                      child: Text(
                                          state.history[index],
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline4),
                                      alignment: Alignment.center,
                                    );
                                  });
                            }
                            return Container();
                          },
                        ),
                )
              ],
            ),
            Container(
              alignment: Alignment.centerRight,
              child: BlocBuilder<SwitchCubit, SwitchState>(
                builder: (context, state) {
                  return Switch(
                    value: state.isDarkThemeOff,
                    onChanged: (newValue) {
                      LightMode = newValue;
                      context.read<SwitchCubit>().toggleSwitch(newValue);
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
