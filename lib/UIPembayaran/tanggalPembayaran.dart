import 'package:flutter/material.dart';
import 'package:mob3_uas_klp_09/UIPembayaran/controllerPembayaran/TglPembayrCTRl.dart';
import 'package:mob3_uas_klp_09/UIPembayaran/informasiPasien.dart';




class Tanggalpembayaran extends StatefulWidget {
  const Tanggalpembayaran({Key? key, required Map<String, String> selectedPackage}) : super(key: key);

  @override
  _TanggalpembayaranState createState() => _TanggalpembayaranState();
}

class _TanggalpembayaranState extends State<Tanggalpembayaran> {
  final TanggalPembayaranController _controller = TanggalPembayaranController();
  int? selectedDay;
  String? selectedTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header with steps
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // Back button and title
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back),
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          'Pilih Tanggal Pemeriksaan',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Steps indicator
                    Row(
                      children: [
                        _buildStep(1, 'Pilih Tanggal', true),
                        _buildStepLine(),
                        _buildStep(2, 'Informasi Pasien', false),
                        _buildStepLine(),
                        _buildStep(3, 'Konfirmasi', false),
                        _buildStepLine(),
                        _buildStep(4, 'Bayar', false),
                      ],
                    ),
                  ],
                ),
              ),

              // Calendar section
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Month navigation
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.chevron_left),
                          onPressed: () {},
                          color: const Color(0xFF1A237E),
                        ),
                        const Text(
                          'Januari',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.chevron_right),
                          onPressed: () {},
                          color: const Color(0xFF1A237E),
                        ),
                      ],
                    ),

                    // Calendar legend
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildLegendItem('Tersedia', Colors.green),
                          const SizedBox(width: 16),
                          _buildLegendItem('Hari Ini', const Color(0xFF1A237E)),
                          const SizedBox(width: 16),
                          _buildLegendItem('Tidak tersedia', Colors.grey),
                        ],
                      ),
                    ),

                    // Calendar grid with Card
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                          childAspectRatio: 1,
                        ),
                        itemCount: 35,
                        itemBuilder: (context, index) {
                          return _buildCalendarDay(index);
                        },
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Time slots
                    const Text(
                      'Pilihan Waktu',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildTimeSlot('09:30', true),
                        _buildTimeSlot('10:30', true),
                        _buildTimeSlot('11:00', true),
                        _buildTimeSlot('11:30', true),
                        _buildTimeSlot('12:00', true),
                        _buildTimeSlot('12:30', true),
                        // _buildTimeSlot('13:30', false),
                      ],
                    ),
                  ],
                ),
              ),

              // Bottom button
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: selectedDay != null && selectedTime != null
                      ? () async {
                        await _controller.simpanTanggalDanWaktu(selectedDay!, selectedTime!);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Informasipasien(
                            ),
                          ),
                        );
                      }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A237E),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'PILIH TANGGAL',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep(int number, String title, bool isActive) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? const Color(0xFF1A237E) : Colors.grey,
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: isActive ? const Color(0xFF1A237E) : Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStepLine() {
    return Container(
      height: 1,
      width: 20,
      color: Colors.grey,
      margin: const EdgeInsets.only(bottom: 20),
    );
  }

  Widget _buildLegendItem(String text, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildCalendarDay(int index) {
    final dayNumber = (index % 31) + 1;
    final isAvailable = [5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16 ,17, 18, 19, 20, 21, 22, 23, 24, 25, 26,27, 28,29,30,].contains(dayNumber);
    final isToday = dayNumber == 19;
    final isSelected = dayNumber == selectedDay;

    return GestureDetector(
      onTap: isAvailable
          ? () {
              setState(() {
                selectedDay = dayNumber;
              });
            }
          : null,
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.green
              : isToday
                  ? const Color(0xFF1A237E)
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            dayNumber.toString(),
            style: TextStyle(
              color: isSelected
                  ? Colors.white
                  : isToday
                      ? Colors.white
                      : isAvailable
                          ? Colors.green
                          : Colors.grey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimeSlot(String time, bool isAvailable) {
    final isSelected = time == selectedTime;

    return GestureDetector(
      onTap: isAvailable
          ? () {
              setState(() {
                selectedTime = time;
              });
            }
          : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: isAvailable
                ? (isSelected ? Colors.green : Colors.grey)
                : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8),
          color: isAvailable
              ? (isSelected ? Colors.green.shade100 : Colors.white)
              : Colors.grey.shade100,
        ),
        child: Text(
          time,
          style: TextStyle(
            color: isAvailable ? (isSelected ? Colors.green : Colors.grey) : Colors.grey,
          ),
        ),
      ),
    );
  }
}
