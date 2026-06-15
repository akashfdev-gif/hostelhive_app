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
  final String? adminRemark;

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
    this.adminRemark,
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
      adminRemark: data['adminRemark'],
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
      'adminRemark': adminRemark,
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
    String? adminRemark,
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
      adminRemark: adminRemark ?? this.adminRemark,
    );
  }
}
