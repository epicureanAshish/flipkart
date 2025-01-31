part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent {}


class ChangeTabEvent extends DashboardEvent {
  final int index;

  ChangeTabEvent({required this.index});
}