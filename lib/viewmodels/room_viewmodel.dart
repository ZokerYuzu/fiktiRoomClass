import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/models/room_model.dart';
import '../data/repositories/room_repository.dart';

class RoomViewModel extends ChangeNotifier {
  final RoomRepository _repository = RoomRepository();
  
  List<RoomModel> _rooms = [];
  Role? _selectedRole;
  int _selectedFloor = 6;
  RoomModel? _activeRoom;
  String _searchQuery = '';
  RoomStatus? _statusFilter;
  bool _isLoading = true;

  // SharedPreferences keys
  static const String _keyRole = 'user_selected_role';

  RoomViewModel() {
    _init();
  }

  // Getters
  List<RoomModel> get rooms => _rooms;
  Role? get selectedRole => _selectedRole;
  int get selectedFloor => _selectedFloor;
  RoomModel? get activeRoom => _activeRoom;
  String get searchQuery => _searchQuery;
  RoomStatus? get statusFilter => _statusFilter;
  bool get isLoading => _isLoading;

  // Initialize data
  Future<void> _init() async {
    _rooms = _repository.getSeedRooms();
    await _loadPersistedRole();
    _isLoading = false;
    notifyListeners();
  }

  // Persist User Role
  Future<void> _loadPersistedRole() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final roleIndex = prefs.getInt(_keyRole);
      if (roleIndex != null) {
        _selectedRole = Role.values[roleIndex];
      }
    } catch (e) {
      debugPrint('Error loading role from preferences: $e');
    }
  }

  Future<void> setSelectedRole(Role role) async {
    _selectedRole = role;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_keyRole, role.index);
    } catch (e) {
      debugPrint('Error saving role to preferences: $e');
    }
  }

  Future<void> clearSelectedRole() async {
    _selectedRole = null;
    notifyListeners();
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_keyRole);
    } catch (e) {
      debugPrint('Error clearing role from preferences: $e');
    }
  }

  void setSelectedFloor(int floor) {
    if (floor == 6 || floor == 7) {
      _selectedFloor = floor;
      notifyListeners();
    }
  }

  void setActiveRoom(RoomModel? room) {
    _activeRoom = room;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setStatusFilter(RoomStatus? status) {
    _statusFilter = status;
    notifyListeners();
  }

  // Action: Update Room Status
  void updateRoomStatus(String id, RoomStatus newStatus) {
    final index = _rooms.indexWhere((room) => room.id == id);
    if (index != -1) {
      _rooms[index].status = newStatus;
      // If updating the active room, update it too
      if (_activeRoom != null && _activeRoom!.id == id) {
        _activeRoom = _rooms[index];
      }
      notifyListeners();
    }
  }

  // Action: Update Room Schedule (Biro only)
  void updateRoomSchedule(
    String id, {
    String? lecturerName,
    String? courseName,
    String? startTime,
    String? endTime,
    RoomStatus? status,
  }) {
    final index = _rooms.indexWhere((room) => room.id == id);
    if (index != -1) {
      final current = _rooms[index];
      _rooms[index] = RoomModel(
        id: current.id,
        floor: current.floor,
        lecturerName: lecturerName ?? current.lecturerName,
        courseName: courseName ?? current.courseName,
        startTime: startTime ?? current.startTime,
        endTime: endTime ?? current.endTime,
        status: status ?? current.status,
      );
      
      // If updating the active room, update it too
      if (_activeRoom != null && _activeRoom!.id == id) {
        _activeRoom = _rooms[index];
      }
      notifyListeners();
    }
  }

  // Reset all room statuses back to initial seed data
  void resetData() {
    _rooms = _repository.getSeedRooms();
    if (_activeRoom != null) {
      final updatedActive = _rooms.firstWhere((r) => r.id == _activeRoom!.id, orElse: () => _activeRoom!);
      _activeRoom = updatedActive;
    }
    _searchQuery = '';
    _statusFilter = null;
    notifyListeners();
  }

  // Helper getters for filtered rooms based on: floor, search query, and status filter
  List<RoomModel> get filteredRooms {
    return _rooms.where((room) {
      // Floor filter
      if (room.floor != _selectedFloor) return false;
      
      // Status filter
      if (_statusFilter != null && room.status != _statusFilter) return false;

      // Search filter (number or lecturer name or course name)
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final matchId = room.id.toLowerCase().contains(query);
        final matchLecturer = room.lecturerName?.toLowerCase().contains(query) ?? false;
        final matchCourse = room.courseName?.toLowerCase().contains(query) ?? false;
        if (!matchId && !matchLecturer && !matchCourse) return false;
      }

      return true;
    }).toList();
  }

  // Statistics calculation for the header row
  int get countActive => _rooms.where((room) => room.status == RoomStatus.dosenMasuk).length;
  int get countWaiting => _rooms.where((room) => room.status == RoomStatus.menunggu).length;
  int get countEmpty => _rooms.where((room) => room.status == RoomStatus.kosong).length;
}
