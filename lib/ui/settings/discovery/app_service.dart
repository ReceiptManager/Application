/*
 * Copyright (c) 2020 - 2021 : William Todt
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import 'dart:io';

import 'package:bonsoir/bonsoir.dart';
import 'package:device_info/device_info.dart';

class AppService {
  /// The service type.
  static const String type = '_receipt-service._tcp';

  /// The service port (in this example we're not doing anything on that port but you should).
  static const int port = 8721;

  /// The cached service.
  static BonsoirService _service;

  static Future<BonsoirService> getService() async {
    if (_service != null) {
      return _service;
    }

    String name;
    if (Platform.isAndroid) {
      name = (await DeviceInfoPlugin().androidInfo).model;
    } else if (Platform.isIOS) {
      name = (await DeviceInfoPlugin().iosInfo).localizedModel;
    } else {
      name = 'Unknown';
    }
    name += ' Receipt server';

    _service = BonsoirService(name: name, type: type, port: port);
    return _service;
  }
}