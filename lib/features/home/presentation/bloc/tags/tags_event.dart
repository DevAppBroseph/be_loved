part of 'tags_bloc.dart';

abstract class TagsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}


class GetTagsEvent extends TagsEvent{}

class TagAddEvent extends TagsEvent{
  final TagEntity tagEntity;
  TagAddEvent({required this.tagEntity});
}

// class TagDeleteEvent extends TagsEvent{
//   final List<int> ids;
//   TagDeleteEvent({required this.ids});
// }