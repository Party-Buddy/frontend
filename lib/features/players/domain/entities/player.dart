import 'package:equatable/equatable.dart';

class PlayerEntity extends Equatable {
  final int id;
  final String? name;
  final String? photoUrl;

  const PlayerEntity({required this.id, this.name, this.photoUrl});

  @override
  List<Object?> get props => [id];
}
