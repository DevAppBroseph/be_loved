import 'dart:ui';
import 'package:be_loved/constants/colors/color_styles.dart';
import 'package:be_loved/constants/texts/text_styles.dart';
import 'package:be_loved/core/services/database/auth_params.dart';
import 'package:be_loved/features/home/domain/entities/archive/gallery_group_files_entity.dart';
import 'package:be_loved/features/home/presentation/bloc/archive/archive_bloc.dart';
import 'package:be_loved/features/home/presentation/bloc/gallery/gallery_bloc.dart';
import 'package:be_loved/features/home/presentation/views/archive/presentation/albums_page.dart';
import 'package:be_loved/features/home/presentation/views/archive/presentation/gallery_page.dart';
import 'package:be_loved/features/home/presentation/views/archive/presentation/moments_page.dart';
import 'package:be_loved/features/home/presentation/views/archive/presentation/widgets/archive_wrapper.dart';
import 'package:be_loved/features/home/presentation/views/events/view/event_detail_view.dart';
import 'package:be_loved/features/home/presentation/views/events/view/event_page.dart';
import 'package:be_loved/locator.dart';
import 'package:cupertino_rounded_corners/cupertino_rounded_corners.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../bloc/events/events_bloc.dart';
import '../../events/view/events_page.dart';
import 'event_page.dart';
import 'helpers/gallery_helper.dart';

class ArchivePage extends StatefulWidget {
  @override
  State<ArchivePage> createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  ScrollController scrollController = ScrollController();
  PageController pageController = PageController();
  bool showTop = false;
  bool hideTopBar = true;
  GalleryGroupFilesEntity? enitityPos;
  String dateTime = '';

  int currentPageIndex = 1;

  int hideGalleryFileID = 0;
  bool hideFixedDate = false;

  @override
  void initState() {
    super.initState();

    GalleryBloc bloc = context.read<GalleryBloc>();
    ArchiveBloc archiveBloc = context.read<ArchiveBloc>();

    if (bloc.state is GalleryFilesInitialState) {
      bloc.add(GetGalleryFilesEvent(isReset: false));
    }
    if (archiveBloc.memoryEntity == null ||
        sl<AuthConfig>().memoryEntity == null) {
      archiveBloc.add(GetMemoryInfoEvent());
    }

    scrollController.addListener(() {
      if (currentPageIndex != 1) {
        if (!hideTopBar) {
          setState(() {
            hideTopBar = true;
          });
        }
        return;
      }
      double position = scrollController.position.pixels;
      int newHideGalleryFileID = 0;
      bool newHideFixedDate = false;
      if (position > 170) {
        newHideFixedDate = false;
        for (int i = 0; i < bloc.groupedFiles.length; i++) {
          double widgetTopPos = bloc.groupedFiles[i].topPosition -
              MediaQuery.of(context).padding.top -
              20.h;
          if (widgetTopPos == 0) {
            break;
          }
          if (position >= widgetTopPos) {
            newHideGalleryFileID = bloc.groupedFiles[i].mainPhoto.id;
          }
          if (i != bloc.groupedFiles.length - 1) {
            if (80.h <=
                ((bloc.groupedFiles[i + 1].topPosition -
                        MediaQuery.of(context).padding.top -
                        20.h) -
                    position)) {
              newHideFixedDate = true;
            } else {
              newHideFixedDate = false;
            }
          }
          if (!(i != bloc.groupedFiles.length - 1 &&
              position >=
                  bloc.groupedFiles[i + 1].topPosition -
                      MediaQuery.of(context).padding.top -
                      20.h)) {
            break;
          }
        }
      } else {
        newHideGalleryFileID = 0;
      }
      if (hideGalleryFileID != newHideGalleryFileID ||
          newHideFixedDate != hideFixedDate) {
        setState(() {
          // print('NEWID: ${newHideGalleryFileID}');
          // print('NEW HIDE: ${newHideFixedDate}');
          hideGalleryFileID = newHideGalleryFileID;
          hideFixedDate = newHideFixedDate;
          onChangeShow(
              hideGalleryFileID == 0 || !hideFixedDate
                  ? null
                  : bloc.groupedFiles
                      .where((element) =>
                          element.mainPhoto.id == hideGalleryFileID)
                      .first,
              hideGalleryFileID == 0);
        });
      }
    });
  }

  onChangeShow(GalleryGroupFilesEntity? show, bool hide) {
    setState(() {
      if (show != null) {
        dateTime = convertToRangeDates(show);
        showTop = true;
        enitityPos = show;
      } else {
        showTop = false;
      }
      hideTopBar = hide;
    });
  }

  void nextPage(int id) {
    context.read<EventsBloc>().eventDetailSelectedId = id;
    pageController.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutQuint);
  }

  void prevPage() => pageController.previousPage(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutQuint);
  ScrollPhysics physics = const NeverScrollableScrollPhysics();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      physics: physics,
      scrollDirection: Axis.horizontal,
      onPageChanged: (value) {
        physics = value == 0
            ? const NeverScrollableScrollPhysics()
            : const ClampingScrollPhysics();
        setState(() {});
      },
      children: [
        Stack(
          children: [
            ArchiveWrapper(
              currentIndex: currentPageIndex,
              onChangePage: (newPage) {
                setState(() {
                  currentPageIndex = newPage;
                });
              },
              child: currentPageIndex == 0
                  ? MomentsPage()
                  : currentPageIndex == 1
                      ? GalleryPage(
                          hideGalleryFileID: hideGalleryFileID,
                        )
                      : currentPageIndex == 2
                          ? AlbumsPage()
                          : currentPageIndex == 3
                              ? EventPageInArchive(
                                  pageController: pageController,
                                  nextPage: nextPage,
                                )
                              : SizedBox.shrink(),
              scrollController: scrollController,
            ),
            if (!hideTopBar)
              Positioned(
                top: MediaQuery.of(context).padding.top + 15.h,
                left: 30.w,
                right: 22.w,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  curve: Curves.easeInOutQuint,
                  margin: EdgeInsets.only(top: showTop ? 10.h : 20.h),
                  child: AnimatedOpacity(
                    opacity: showTop ? 1 : 0,
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeInOutQuint,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              dateTime,
                              style: TextStyles(context).white_35_w800.copyWith(
                                    color: Colors.white.withOpacity(0.7),
                                  ),
                            ),
                            SizedBox(
                              width: 120.w,
                              height: 38.h,
                              child: ClipPath.shape(
                                shape: SquircleBorder(
                                    radius: BorderRadius.circular(30.r)),
                                child: BackdropFilter(
                                  filter:
                                      ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                                  child: Container(
                                    color: Colors.white.withOpacity(0.7),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Выбрать',
                                      style: TextStyles(context)
                                          .black_18_w800
                                          .copyWith(
                                              color: ColorStyles.blackColor
                                                  .withOpacity(0.7)),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Text(
                          enitityPos == null ? '' : enitityPos!.mainPhoto.place,
                          style: TextStyles(context).white_15_w800.copyWith(
                                color: Colors.white.withOpacity(0.5),
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
        EventDetailView(prevPage: prevPage),
      ],
    );
  }
}