import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:common/features/profile/presentation/common_imports.dart';

class ChartWebView extends StatefulWidget {
  const ChartWebView({super.key});

  @override
  _ChartWebViewState createState() => _ChartWebViewState();
}

class _ChartWebViewState extends State<ChartWebView> {
  late final WebViewController _controller;
  final List<Map<String, dynamic>> _seriesData = [
    {'name': 'Samsung', 'value': 23},
    {'name': 'Apple', 'value': 18},
    {'name': 'Xiaomi', 'value': 12},
    {'name': 'Oppo*', 'value': 9},
    {'name': 'Vivo', 'value': 8},
    {'name': 'Others', 'value': 30},
  ];
  String _generateChartHtml(List<Map<String, dynamic>> seriesData) {
    final series = jsonEncode(seriesData.map((data) {
      return [data['name'], data['value']];
    }).toList());

    return '''
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <script src="https://code.highcharts.com/6.1.0/highcharts.js"></script>
        <script src="https://code.highcharts.com/6.1.0/highcharts-3d.js"></script>
        <script src="https://code.highcharts.com/modules/accessibility.js"></script>
        <title>3D Pie Chart</title>
        <style>
            #container {
                height: 400px;
            }
        </style>
    </head>
    <body>
        <div id="container"></div>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                Highcharts.chart('container', {
                    chart: {
                        type: 'pie',
                        options3d: {
                            enabled: true,
                            alpha: 45,
                            beta: 0
                        },
                        backgroundColor: 'rgba(255, 255, 255, 0)'
                    },
                    title: {
                        text: 'Global smartphone shipments market share, Q1 2022',
                        align: 'left'
                    },
                    subtitle: {
                        text: 'Source: <a href="https://www.counterpointresearch.com/global-smartphone-share/" target="_blank">Counterpoint Research</a>',
                        align: 'left'
                    },
                    accessibility: {
                        enabled: true,
                        point: {
                            valueSuffix: '%'
                        }
                    },
                    tooltip: {
                        pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
                    },
                    plotOptions: {
                        pie: {
                            allowPointSelect: true,
                            cursor: 'pointer',
                            depth: 35,
                            dataLabels: {
                                enabled: false,
                            }
                        }
                    },
                    series: [{
                        type: 'pie',
                        name: 'Share',
                        data: $series
                    }]
                });
            });
        </script>
    </body>
    </html>
    ''';
  }

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      _controller = WebViewController()

        ..loadHtmlString(_generateChartHtml(_seriesData));
    }
    else {
      _controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadHtmlString(_generateChartHtml(_seriesData));
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,width: 500,
      child: WebViewWidget(controller: _controller),
    );
  }
}
