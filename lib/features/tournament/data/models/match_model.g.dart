// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TournamentMatchAdapter extends TypeAdapter<TournamentMatch> {
  @override
  final int typeId = 1;

  @override
  TournamentMatch read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TournamentMatch(
      id: fields[0] as String,
      title: fields[1] as String,
      timeStampHistory: (fields[3] as List).cast<String>(),
      participantingPlayers: (fields[4] as List).cast<Player>(),
      bannerUrl: fields[2] as String,
    )..matchedPairs = (fields[5] as List)
        .map((dynamic e) => (e as List).cast<Player>())
        .toList();
  }

  @override
  void write(BinaryWriter writer, TournamentMatch obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.bannerUrl)
      ..writeByte(3)
      ..write(obj.timeStampHistory)
      ..writeByte(4)
      ..write(obj.participantingPlayers)
      ..writeByte(5)
      ..write(obj.matchedPairs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TournamentMatchAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
