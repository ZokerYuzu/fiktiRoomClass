import '../models/room_model.dart';

class RoomRepository {
  List<RoomModel> getSeedRooms() {
    return [
      RoomModel(
        id: '601',
        floor: 6,
        lecturerName: 'Dosen A',
        courseName: 'Pemrograman Web',
        startTime: '08:00',
        endTime: '09:40',
        status: RoomStatus.menunggu,
      ),
      RoomModel(
        id: '602',
        floor: 6,
        lecturerName: 'Dosen B',
        courseName: 'Basis Data',
        startTime: '08:00',
        endTime: '09:40',
        status: RoomStatus.menunggu,
      ),
      RoomModel(
        id: '603',
        floor: 6,
        lecturerName: 'Dosen C',
        courseName: 'Jaringan Komputer',
        startTime: '08:00',
        endTime: '09:40',
        status: RoomStatus.menunggu,
      ),
      RoomModel(
        id: '604',
        floor: 6,
        lecturerName: 'Dosen D',
        courseName: 'Kecerdasan Buatan',
        startTime: '08:00',
        endTime: '09:40',
        status: RoomStatus.menunggu,
      ),
      RoomModel(
        id: '701',
        floor: 7,
        lecturerName: 'Dosen A',
        courseName: 'Struktur Data',
        startTime: '10:00',
        endTime: '11:40',
        status: RoomStatus.menunggu,
      ),
      RoomModel(
        id: '702',
        floor: 7,
        lecturerName: 'Dosen B',
        courseName: 'Sistem Operasi',
        startTime: '10:00',
        endTime: '11:40',
        status: RoomStatus.menunggu,
      ),
      RoomModel(
        id: '703',
        floor: 7,
        status: RoomStatus.kosong,
      ),
      RoomModel(
        id: '704',
        floor: 7,
        status: RoomStatus.kosong,
      ),
      RoomModel(
        id: '705',
        floor: 7,
        lecturerName: 'Dosen C',
        courseName: 'Rekayasa Perangkat Lunak',
        startTime: '10:00',
        endTime: '11:40',
        status: RoomStatus.menunggu,
      ),
      RoomModel(
        id: '706',
        floor: 7,
        lecturerName: 'Dosen D',
        courseName: 'Keamanan Siber',
        startTime: '10:00',
        endTime: '11:40',
        status: RoomStatus.menunggu,
      ),
      RoomModel(
        id: '707',
        floor: 7,
        status: RoomStatus.kosong,
      ),
      RoomModel(
        id: '708',
        floor: 7,
        status: RoomStatus.kosong,
      ),
    ];
  }
}
