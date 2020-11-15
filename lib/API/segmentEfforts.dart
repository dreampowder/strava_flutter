import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:strava_flutter/globals.dart' as globals;
import 'package:strava_flutter/Models/fault.dart';
import 'package:strava_flutter/Models/segmentEffort.dart';
import 'package:strava_flutter/errorCodes.dart' as error;

abstract class SegmentEfforts {
  Future<DetailedSegmentEffort> getSegmentEffortById(int segId) async {
    DetailedSegmentEffort _returnSeg = DetailedSegmentEffort();

    var _header = globals.createHeader();

    globals.displayInfo('Entering getSegmentEffortById');

    if (_header.containsKey('88') == false) {
      final reqSeg =
          'https://www.strava.com/api/v3/segment_efforts/' + segId.toString();

      var rep = await http.get(reqSeg, headers: _header);

      if (rep.statusCode == 200) {
        globals.displayInfo(rep.statusCode.toString());
        if (rep.body != '[]') {
          globals.displayInfo('Segment info ${rep.body}');
          var jsonResponse = json.decode(rep.body);

          if (jsonResponse != null) {
            _returnSeg = DetailedSegmentEffort.fromJson(jsonResponse);
            globals.displayInfo('${_returnSeg.name}');
          }
        }
      } else {
        // No proper answer to the request
        _returnSeg.fault =
            Fault(error.statusUnknownError, 'error ${rep.statusCode}');
      }
    } else {
      globals.displayInfo('Token not yet known');
      _returnSeg.fault =
          Fault(error.statusTokenNotKnownYet, 'Token not yet known');
    }
    return _returnSeg;
  }

  /// NOT YET WORKING
  ///
  /// scope needed:
  /// Multiple page request has not been tested yet
  ///
  Future<DetailedSegmentEffort> getEffortsbySegmentId(
      int segId, String startDateLocal, String endDateLocal) async {
    DetailedSegmentEffort _returnSeg = DetailedSegmentEffort();

    var _header = globals.createHeader();
    bool isRetrieveDone = false;
    int _perPage = 50; // Nombre of segments retrieved by request

    globals.displayInfo('Entering getEffortsbySegmentId');

    if (_header.containsKey('88') == false) {
      do {
        final reqSeg =
            'https://www.strava.com/api/v3/segment_efforts?segment_id=' +
                segId.toString() +
                '&start_date_local=' +
                startDateLocal +
                '&end_date_local=' +
                endDateLocal +
                '&per_page=' +
                _perPage.toString();

        var rep = await http.get(reqSeg, headers: _header);
        int _nbSegments = 0;

        if (rep.statusCode == 200) {
          globals.displayInfo(rep.statusCode.toString());
          if (rep.body != '[]') {
            globals.displayInfo('Segment info ${rep.body}');
            var jsonResponse = json.decode(rep.body);

            if (jsonResponse != null) {
              jsonResponse.forEach((_seg) {
                var _detailedSegmentEffort =
                    DetailedSegmentEffort.fromJson(_seg);
                globals.displayInfo('${_detailedSegmentEffort.name}');
                // _listSummary.add(member);
                _nbSegments++;
              });

              // Check if it is the last page
              globals.displayInfo(_nbSegments.toString());
              if (_nbSegments < _perPage) {
                isRetrieveDone = true;
              } else {
                // Move to the next page

              }

              DetailedSegmentEffort _segEffort =
                  DetailedSegmentEffort.fromJson(jsonResponse[0]);
              globals.displayInfo(_segEffort.name);

              _returnSeg = _segEffort;
            } else {
              // The segment has been ridden by the athlete during the data range
              globals.displayInfo(
                  'Segment unknown to this athlete during date range');
              _returnSeg.fault = Fault(error.statusSegmentNotRidden,
                  'Segment unknown to the athlete');
            }
          } else {
            globals.displayInfo('problem in getEffortsBySegmentId request');
            _returnSeg.fault = Fault(
                error.statusUnknownError, 'Error in getEffortsbySegmentId');
          }
        }
      } while (!isRetrieveDone);
    } else {
      globals.displayInfo('Token not yet known');
      _returnSeg.fault =
          Fault(error.statusTokenNotKnownYet, 'Token not yet known');
    }
    return _returnSeg;
  }
}
