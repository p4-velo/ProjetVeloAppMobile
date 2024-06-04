import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:projet_velo_app_mobile/global.dart' as global;

class MobileView {
  BuildContext context;
  Widget body;

  MobileView({
    required this.context,
    required this.body,
  });

  render() {
    return Material(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: LayoutBuilder(
          builder: (context, constraints) => SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: SafeArea(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: LayoutBuilder(
                            builder: (context, constraints) => SizedBox(
                              width: constraints.maxWidth,
                              height: constraints.maxHeight,
                              child: body
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                bottomNavigationBar: BottomAppBar(
                  height: 60,
                  color: global.primary,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      MenuItem(
                        goToRoute: '/favaddress',
                        icon: Icons.star_outline,
                      ),
                      MenuItem(
                        goToRoute: '/map',
                        icon: Icons.map,
                      ),
                      MenuItem(
                        goToRoute: '/signin',
                        icon: Icons.person,
                      )
                    ],
                  ),
                )
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String goToRoute;
  final IconData icon;

  const MenuItem({
    required this.goToRoute,
    required this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String? currentRoute = GoRouter.of(context).routeInformationProvider.value.uri.toString();

    return InkWell(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            context.go(goToRoute);
          },
          child: Container(
            height: 45,
            width: 38,
            decoration: currentRoute == goToRoute
                ? BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                    color: global.iconSelected,
                  )
                : const BoxDecoration(
                    color: Colors.transparent,
                  ),
            child: Align(
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
