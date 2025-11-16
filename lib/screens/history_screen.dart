import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/weather_service.dart';
import '../models/weather_data.dart';
import '../widgets/bottom_nav_bar.dart';

class HistoryScreen extends StatefulWidget {
  final String studentIndex;

  const HistoryScreen({super.key, required this.studentIndex});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<WeatherData> _history = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final history = await WeatherService.getHistory();
    setState(() {
      _history = history;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text(
          'History',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            tooltip: 'Logout',
            color: Colors.red,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Weather History',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      
                      // Scrollable Table with visible scrollbar
                      Scrollbar(
                        thumbVisibility: true,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: SizedBox(
                            width: 900,
                            child: Column(
                              children: [
                                // Table Header
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(color: Colors.grey.shade300),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                                    child: Row(
                                      children: [
                                        _buildHeaderCell('Time', width: 100),
                                        _buildHeaderCell('Date', width: 110),
                                        _buildHeaderCell('Description', width: 150),
                                        _buildHeaderCell('Code', width: 70),
                                        _buildHeaderCell('Temp (°C)', width: 90),
                                        _buildHeaderCell('Wind (m/s)', width: 100),
                                        _buildHeaderCell('Press (hPa)', width: 110),
                                        _buildHeaderCell('Humidity (%)', width: 120),
                                      ],
                                    ),
                                  ),
                                ),
                                
                                // Table Rows
                                
                                // Table Rows
                                if (_history.isEmpty)
                                  Padding(
                                    padding: const EdgeInsets.all(32.0),
                                    child: Center(
                                      child: Text(
                                        'No weather history available yet.',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ),
                                  )
                                else
                                  ..._history.map((data) => _buildHistoryRow(data)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 1,
        studentIndex: widget.studentIndex,
      ),
    );
  }

  Widget _buildHeaderCell(String text, {required double width}) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }

  Widget _buildHistoryRow(WeatherData data) {
    final timeFormat = DateFormat('h:mm a');
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade200),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            _buildDataCell(
              timeFormat.format(data.lastUpdated),
              width: 100,
            ),
            _buildDataCell(
              dateFormat.format(data.lastUpdated),
              width: 110,
            ),
            _buildDataCell(
              data.weatherDescription,
              width: 150,
            ),
            _buildDataCell(
              data.weatherCode.toString(),
              width: 70,
            ),
            _buildDataCell(
              data.temperature.toStringAsFixed(0),
              width: 90,
            ),
            _buildDataCell(
              data.windSpeed.toStringAsFixed(1),
              width: 100,
            ),
            _buildDataCell(
              '1014',
              width: 110,
            ),
            _buildDataCell(
              '84',
              width: 120,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataCell(String text, {required double width}) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          text,
          style: const TextStyle(fontSize: 11),
          textAlign: TextAlign.left,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
