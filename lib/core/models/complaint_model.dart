import 'package:cloud_firestore/cloud_firestore.dart';

class ComplaintModel {
  final String id;
  final String title;
  final String description;
  final String studentId;
  final String studentName;
  final String roomNumber;
  final String status; // 'Pending', 'In Progress', 'Resolved', 'Rejected'
  final DateTime createdAt;
  final String category;
  final String priority;
  final String contactNumber;
  final String adminMessage;
  final DateTime? receivedAt;
  final DateTime? assignedAt;
  final DateTime? inProgressAt;
  final DateTime? resolvedAt;
  ComplaintModel({
    required this.id,
    required this.title,
    required this.description,
    required this.studentId,
    required this.studentName,
    required this.roomNumber,
    required this.status,
    required this.createdAt,
    required this.category,
    required this.priority,
    required this.contactNumber,
    this.adminMessage = '',
    this.receivedAt,
    this.assignedAt,
    this.inProgressAt,
    this.resolvedAt,
  });

  factory ComplaintModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return ComplaintModel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      studentId: data['studentId'] ?? '',
      studentName: data['studentName'] ?? '',
      roomNumber: data['roomNumber'] ?? '',
      status: data['status'] ?? 'Pending',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      category: data['category'] ?? '',
      priority: data['priority'] ?? 'lbl_medium',
      contactNumber: data['contactNumber'] ?? '',
      adminMessage: data['adminMessage'] ?? '',
      receivedAt: (data['receivedAt'] as Timestamp?)?.toDate(),
      assignedAt: (data['assignedAt'] as Timestamp?)?.toDate(),
      inProgressAt: (data['inProgressAt'] as Timestamp?)?.toDate(),
      resolvedAt: (data['resolvedAt'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'studentId': studentId,
      'studentName': studentName,
      'roomNumber': roomNumber,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
      'category': category,
      'priority': priority,
      'contactNumber': contactNumber,
      'adminMessage': adminMessage,
      'receivedAt': receivedAt != null ? Timestamp.fromDate(receivedAt!) : null,
      'assignedAt': assignedAt != null ? Timestamp.fromDate(assignedAt!) : null,
      'inProgressAt': inProgressAt != null ? Timestamp.fromDate(inProgressAt!) : null,
      'resolvedAt': resolvedAt != null ? Timestamp.fromDate(resolvedAt!) : null,
    };
  }

  ComplaintModel copyWith({
    String? id,
    String? title,
    String? description,
    String? studentId,
    String? studentName,
    String? roomNumber,
    String? status,
    DateTime? createdAt,
    String? category,
    String? priority,
    String? contactNumber,
    String? adminMessage,
    DateTime? receivedAt,
    DateTime? assignedAt,
    DateTime? inProgressAt,
    DateTime? resolvedAt,
  }) {
    return ComplaintModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      roomNumber: roomNumber ?? this.roomNumber,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      contactNumber: contactNumber ?? this.contactNumber,
      adminMessage: adminMessage ?? this.adminMessage,
      receivedAt: receivedAt ?? this.receivedAt,
      assignedAt: assignedAt ?? this.assignedAt,
      inProgressAt: inProgressAt ?? this.inProgressAt,
      resolvedAt: resolvedAt ?? this.resolvedAt,
    );
  }
}
