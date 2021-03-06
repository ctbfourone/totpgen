# totpgen.rb

This was originally intended to be used in conjunction with Evgeny Gridasov's [OpenVPN OTP plug-in](https://github.com/evgeny-gridasov/openvpn-otp), but it could be used with other things like PAM or Wireguard.

By default this will generate a new TOTP secret for your current user and draw a QR code to your terminal for scanning it with your 2FA application.

It requires the following rubygems:
- base32
- rqrcode
- optimist

## Screenshot
![totpgen.rb Screenshot](screenshot.png)

## Authors
- Matt Moyer <<https://moyer.pub>>
- Chris Brentano <<https://fourone.org/~ctb/>>

## License
This Source Code Form is subject to the terms of the Mozilla Public
License, v. 2.0. If a copy of the MPL was not distributed with this
file, You can obtain one at http://mozilla.org/MPL/2.0/.
