import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_09/UI_Admin/Profil/utils/theme.dart';


class ReportAndStatsScreen extends StatefulWidget {
  const ReportAndStatsScreen({super.key});

  @override
  _ReportAndStatsScreenState createState() => _ReportAndStatsScreenState();
}

class _ReportAndStatsScreenState extends State<ReportAndStatsScreen> {
  // Data dummy untuk laporan
  List<Map<String, String>> usersData = List.generate(10, (index) {
    return {
      'id': 'ID-${index + 1}',
      'name': 'Pengguna ${index + 1}',
      'joinDate': '2024-12-${index + 1}',
      'status': index % 2 == 0 ? 'Aktif' : 'Tersuspend',
    };
  });

  String? selectedStatus = 'Semua'; // Status filter
  bool isSortedAsc = true; // Urutan sorting berdasarkan Nama Pengguna

  // Fungsi untuk menyortir berdasarkan Nama Pengguna
  void _sortByName() {
    setState(() {
      if (isSortedAsc) {
        usersData.sort((a, b) => a['name']!.compareTo(b['name']!));
      } else {
        usersData.sort((a, b) => b['name']!.compareTo(a['name']!));
      }
      isSortedAsc = !isSortedAsc;
    });
  }

  // Fungsi untuk memfilter berdasarkan status
  List<Map<String, String>> _filterUsers() {
    if (selectedStatus == 'Semua') {
      return usersData;
    } else {
      return usersData
          .where((user) => user['status'] == selectedStatus)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredData = _filterUsers();

    return Scaffold(
      appBar: AppBar(
        title: Text('Laporan dan Statistik'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Statistik Umum
              Text(
                'Statistik Umum',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 20),
              _buildStatsCard('Total Pengguna', '1200', Icons.people),
              _buildStatsCard('Total Pembayaran', '500', Icons.payment),
              _buildStatsCard('Total Akun Tersuspend', '50', Icons.block),
              SizedBox(height: 30),
        
              // Grafik Aktivitas Pengguna
              Text(
                'Grafik Aktivitas Pengguna',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 20),
              _buildActivityChart(),
        
              SizedBox(height: 30),
        
              // Filter Dropdown
              DropdownButton<String>(
                value: selectedStatus,
                onChanged: (newValue) {
                  setState(() {
                    selectedStatus = newValue;
                  });
                },
                items: ['Semua', 'Aktif', 'Tersuspend']
                    .map((status) => DropdownMenuItem<String>(
                          value: status,
                          child: Text(status),
                        ))
                    .toList(),
              ),
              SizedBox(height: 20),
        
              // Tabel Laporan
              Text(
                'Laporan Terperinci',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              _buildReportTable(filteredData),
            ],
          ),
        ),
      ),
    );
  }

  // Card untuk statistik umum
  Widget _buildStatsCard(String title, String value, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 5,
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Icon(
          icon,
          color: AppTheme.primary,
          size: 40,
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        trailing: Text(
          value,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  // Grafik aktivitas pengguna menggunakan fl_chart
  Widget _buildActivityChart() {
    return AspectRatio(
      aspectRatio: 1.7,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: false),
          titlesData: FlTitlesData(show: false),
          borderData: FlBorderData(show: true, border: Border.all(color: Colors.grey)),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 1),
                FlSpot(1, 3),
                FlSpot(2, 5),
                FlSpot(3, 1),
                FlSpot(4, 4),
              ],
              isCurved: true,
              color: AppTheme.primary,
              dotData: FlDotData(show: false),
              // belowBarData: BarChartBarData(show: false),
            ),
          ],
        ),
      ),
    );
  }

  // Tabel laporan dengan sorting dan filtering
  Widget _buildReportTable(List<Map<String, String>> data) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text('ID', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          DataColumn(
            label: Text('Nama Pengguna', style: TextStyle(fontWeight: FontWeight.bold)),
            onSort: (columnIndex, ascending) {
              _sortByName();
            },
          ),
          DataColumn(
            label: Text('Tanggal Bergabung', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          DataColumn(
            label: Text('Status', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
        rows: List.generate(
          data.length,
          (index) => DataRow(cells: [
            DataCell(Text(data[index]['id']!)),
            DataCell(Text(data[index]['name']!)),
            DataCell(Text(data[index]['joinDate']!)),
            DataCell(Text(data[index]['status']!)),
          ]),
        ),
      ),
    );
  }
}
