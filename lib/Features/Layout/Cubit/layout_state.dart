part of 'layout_cubit.dart';

@immutable
sealed class LayoutState {}

final class LayoutInitial extends LayoutState {}
final class LayoutChangeState extends LayoutState {}

