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
                              _buildHeaderCell('Time', flex: 2),
                              _buildHeaderCell('Date', flex: 2),
                              _buildHeaderCell('Description', flex: 3),
                              _buildHeaderCell('Temp (°C)', flex: 2),
                              _buildHeaderCell('Wind (m/s)', flex: 2),
                              _buildHeaderCell('Press (hPa)', flex: 2),
                              _buildHeaderCell('Humidity (%)', flex: 2),
                            ],
                          ),
                        ),
                      ),
                      
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
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 1,
        studentIndex: widget.studentIndex,
      ),
    );
  }

  Widget _buildHeaderCell(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
        textAlign: TextAlign.left,
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
              flex: 2,
            ),
            _buildDataCell(
              dateFormat.format(data.lastUpdated),
              flex: 2,
            ),
            _buildDataCell(
              data.weatherDescription,
              flex: 3,
            ),
            _buildDataCell(
              data.temperature.toStringAsFixed(0),
              flex: 2,
            ),
            _buildDataCell(
              data.windSpeed.toStringAsFixed(1),
              flex: 2,
            ),
            _buildDataCell(
              '1014',
              flex: 2,
            ),
            _buildDataCell(
              '84',
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDataCell(String text, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: const TextStyle(fontSize: 11),
        textAlign: TextAlign.left,
      ),
    );
  }
}
