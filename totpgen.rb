#!/usr/bin/env ruby

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.
#
# Authors: Matt Moyer & Chris Brentano

require 'securerandom'
require 'base32'
require 'rqrcode'
require 'optimist'
require 'etc'

# puts an ansi QR code on the screen that can be scanned
def ansi_qr(uri)
  qr = RQRCode::QRCode.new(uri, :size => 6, :level => :m)
  code = qr.as_ansi(light: "\033[47m", dark: "\033[40m", fill_character: '  ', quiet_zone_size: 4)
end

def new_otpauth(username)
  key_bundle = {
    :secret => Base32.encode(SecureRandom.random_bytes(10)),
  }

  uri = "otpauth://totp/#{username}@openvpn-totp?secret=#{key_bundle[:secret]}&issuer=#{username}"

  puts "\nYou are generating a new TOTP code for username: #{username}\n\n"
  puts "1. This seed is required for use with the openvpn-otp plugin: #{key_bundle[:secret]}\n\n"
  puts "2. Scan this QR code with your 2FA application:"
  puts "\n\n#{ansi_qr(uri)}\n\n"
end

def main
  opts = Optimist::options do
    version "#{__FILE__} 0.1"
    banner <<-EOS
 _______ _______ _______ ______    _______                                __              
|_     _|       |_     _|   __ \\  |     __|.-----.-----.-----.----.---.-.|  |_.-----.----.
  |   | |   -   | |   | |    __/  |    |  ||  -__|     |  -__|   _|  _  ||   _|  _  |   _|
  |___| |_______| |___| |___|     |_______||_____|__|__|_____|__| |___._||____|_____|__|   \n\n
#{__FILE__}: generate a Google Authenticator/Duo/Authy compatible TOTP code.\n
By default this will generate a new TOTP secret for your current user ('#{Etc.getlogin}') and draw
a QR code to your terminal for scanning it with your 2FA application.

Usage:
  bundle exec #{__FILE__} --username 'bob'
    EOS
    opt :username, "Username of user", :type => String, :default => Etc.getlogin
  end
  new_otpauth(opts[:username])
end

if __FILE__ == $0
  main
end
