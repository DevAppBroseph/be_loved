part of 'web_socket_bloc.dart';

class WebSocketState {}

class WebSocketInitState extends WebSocketState {}

class WebSocketLoadingState extends WebSocketState {}

class WebSocketErrorState extends WebSocketState {
  final String message;
  WebSocketErrorState({required this.message});
}

class WebSocketInviteGetState extends WebSocketState {}

class WebSocketInviteSendState extends WebSocketState {}

class WebSocketInviteCloseState extends WebSocketState {}

class WebSocketInviteAcceptState extends WebSocketState {}

class WebSocketStartRelatioinshipsState extends WebSocketState {}
