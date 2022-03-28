class ServiceRequests {
  ServiceRequests({required this.name, required this.place, required this.serviceType, required this.time});

  String name;
  String serviceType;
  String place;
  String time;
}

List serviceRequests = [
  ServiceRequests(name: "Ritik Jain", place: "UsmanPur ", serviceType: "update", time: "12:00 PM - 12:30 PM"),
  ServiceRequests(name: "Gaurav sharma", place: "Seelumpur", serviceType: "update", time: "1:00 PM - 1:30 PM"),
  ServiceRequests(name: "Mukesh jha", place: "Shahdra", serviceType: "enrollment", time: "3:00 PM - 3:30 PM"),
  ServiceRequests(name: "Suhani shah", place: "krishna nagar", serviceType: "update", time: "5:00 PM - 5:30 PM"),
];

List completedserviceRequests = [
  ServiceRequests(name: "Rahul rastogi", place: "UsmanPur ", serviceType: "update", time: "12:00 - 12:30"),
  ServiceRequests(name: "Utkarsh chabhra", place: "Seelumpur", serviceType: "update", time: "12:00 - 12:30"),
  ServiceRequests(name: "Mobin", place: "Shahdra", serviceType: "enrollment", time: "12:00 - 12:30"),
  ServiceRequests(name: "Kritika", place: "krishna nagar", serviceType: "update", time: "12:00 - 12:30"),
];
