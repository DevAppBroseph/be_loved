import 'dart:async';
import 'package:be_loved/core/bloc/common_socket/web_socket_bloc.dart';
import 'package:be_loved/features/auth/presentation/views/login/invite_for_start_relationship.dart';
import 'package:be_loved/features/auth/presentation/views/login/invite_partner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InviteRelation extends StatelessWidget {
  InviteRelation({Key? key, required this.previousPage}) : super(key: key);

  final VoidCallback previousPage;
  bool isSwipe = false;

  final streamController = StreamController<int>();
  final pageController =
      PageController(initialPage: 1, viewportFraction: 1.0, keepPage: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        child: StreamBuilder<int>(
            initialData: 1,
            stream: streamController.stream,
            builder: (context, snapshot) {
              // var user = BlocProvider.of<AuthBloc>(context).user;
              return BlocBuilder<WebSocketBloc, WebSocketState>(
                  builder: (context, state) {
                // pageController.addListener(() {
                //   if (pageController.offset.toInt() % 5 == 0) {
                //     if ((pageController.offset.toInt() <
                //             pageController.position.maxScrollExtent ~/ 2 + 5) &&
                //         pageController.offset.toInt() >
                //             pageController.position.maxScrollExtent ~/ 2 - 5 &&
                //         pageController.position.userScrollDirection ==
                //             ScrollDirection.reverse) {
                //       print('three hundred bags');
                //       BlocProvider.of<AuthBloc>(context)
                //           .add(DeleteInviteUser());
                //     } else if (pageController.position.userScrollDirection ==
                //             ScrollDirection.reverse &&
                //         pageController.offset.toInt() ==
                //             pageController.position.maxScrollExtent &&
                //         user?.love != null &&
                //         state is AuthLoading == false &&
                //         state is DeleteInviteError == false &&
                //         state is DeleteInviteSuccess == false &&
                //         state is DeleteInviteError == false &&
                //         state is ReletionshipsError == false &&
                //         state is CheckIsUserExistError == false) {
                //       print('four hundred bags: $state');
                //       BlocProvider.of<AuthBloc>(context)
                //           .add(DeleteInviteUser());
                //     }
                //   }
                // print((pageController.offset.toInt() <
                //         pageController.position.maxScrollExtent ~/ 2 + 5) &&
                //     pageController.offset.toInt() >
                //         pageController.position.maxScrollExtent ~/ 2 - 5 &&
                //     pageController.position.userScrollDirection ==
                //         ScrollDirection.reverse);
                // });
                if(state is WebSocketInviteGetState) {
                  isSwipe = true;
                } else {
                  isSwipe = false;
                }
                // pageController.addListener(() {
                //   if (state is WebSocketGetInviteMessage) {
                //     isSwipe = true;
                //   } else {
                //     isSwipe = false;
                //   }
                // });
                return PageView(
                  scrollDirection: Axis.vertical,
                  physics: snapshot.data == 1
                      ? const NeverScrollableScrollPhysics()
                      : isSwipe
                          ? const ClampingScrollPhysics()
                          : const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  onPageChanged: (value) => streamController.add(value),
                  children: [
                    InviteForStartRelationship(
                      isSwipe: isSwipe,
                      nextPage: () => previewPage(context),
                      streamController: streamController,
                    ),
                    InvitePartner(
                      nextPage: nextPage,
                      previousPage: previousPage,
                      streamController: streamController,
                    ),
                  ],
                );
              });
            }),
      ),
    );
  }

  void nextPage() {
    pageController.previousPage(
        duration: const Duration(milliseconds: 1200), curve: Curves.easeInOut);
  }

  void previewPage(BuildContext context) {
    // BlocProvider.of<AuthBloc>(context).add(DeleteInviteUser());
    pageController.nextPage(
        duration: const Duration(milliseconds: 1200), curve: Curves.easeInOut);
  }
}
