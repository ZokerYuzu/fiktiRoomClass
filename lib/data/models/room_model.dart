enum RoomStatus {
  dosenMasuk,
  menunggu,
  dosenTidakMasuk,
  kosong,
  perbaikan,
  ujian,
}

enum Role {
  relator,
  mahasiswa,
  biro,
}

class RoomModel {
  final String id;
  final int floor;
  final String? lecturerName;
  final String? courseName;
  final String? startTime;
  final String? endTime;
  RoomStatus status;

  RoomModel({
    required this.id,
    required this.floor,
    this.lecturerName,
    this.courseName,
    this.startTime,
    this.endTime,
    required this.status,
  });

  // Create a copyWith method to easily duplicate room objects when updating status
  RoomModel copyWith({
    String? id,
    int? floor,
    String? lecturerName,
    String? courseName,
    String? startTime,
    String? endTime,
    RoomStatus? status,
  }) {
    return RoomModel(
      id: id ?? this.id,
      floor: floor ?? this.floor,
      lecturerName: lecturerName ?? this.lecturerName,
      courseName: courseName ?? this.courseName,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      status: status ?? this.status,
    );
  }
}
