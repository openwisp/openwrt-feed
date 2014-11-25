#!/usr/bin/env bats

#
# assume that:
#  1- RLY02 board is attached to ttyACM0
#  2- $FIRMWARE is set
#

setup() {
  rm -fr /tmp/ap51-flash
  git clone https://github.com/Unidata-SpA/ap51flash.git /tmp/ap51-flash
  make -C /tmp/ap51-flash
  [ -c /dev/ttyACM0 ]
  [ -n ${FIRMWARE} ]
}

@test "flash ap" {
  sudo /tmp/ap51-flash/ap51-flash eth0 ${FIRMWARE}
}

@test "provide and test ip" {
  sudo ifconfig eth0 10.11.12.1
  sudo killall dnsmasq
  sudo dnsmasq -i eth0 --dhcp-range=10.11.12.13,10.11.12.13,9000 &
  sleep 50
  ping 10.11.12.13 -c 2 -w 20 # deadline to 20 sec
  [ $? -ne 2 || $? -ne 0 ]
}

