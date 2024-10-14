#!/bin/bash

# Needs keyboard set to "British - PC" to work

# USB usage tables (from the USB HID Usage Tables (HUT) doc):
#  1 (0x01) = Generic desktop page
# 12 (0x0c) = Consumer page

# HID devices for the keyboard:

# % hidutil list | grep -E '(Services:|VendorID|Devices|HS60 V2)'
# Services:
# VendorID ProductID LocationID UsagePage Usage RegistryID  Transport Class                                Product                            UserClass               Built-In
# 0x8968   0x4853    0x2130000  1         6     0x100000fc3 USB       AppleUserHIDEventService             HS60 V2                            AppleUserHIDEventDriver 0
# 0x8968   0x4853    0x2130000  1         2     0x100000fc9 USB       AppleUserHIDEventService             HS60 V2                            AppleUserHIDEventDriver 0
# Devices:
# VendorID ProductID LocationID UsagePage Usage RegistryID  Transport Class                      Product                             UserClass                 Built-In
# 0x8968   0x4853    0x2130000  1         2     0x100000fa4 USB       AppleUserHIDDevice         HS60 V2                             AppleUserUSBHostHIDDevice 0
# 0x8968   0x4853    0x2130000  1         6     0x100000f9e USB       AppleUserHIDDevice         HS60 V2                             AppleUserUSBHostHIDDevice 0

# Default mappings (none):

# % hidutil property --matching '{"ProductID":0x4853,"VendorID":0x8968}' --get "UserKeyMapping"
# RegistryID  Key                   Value
# RegistryID  Key                   Value
# 100000fc3   UserKeyMapping   (null)
# 100000fc9   UserKeyMapping   (null)

# VendorID ProductID ... Product
# 0x8968   0x4853    ... HS60 V2
MATCH='{"ProductID":0x4853,"VendorID":0x8968}'

echo "Old mapping:"
sudo hidutil property --matching "$MATCH" --get "UserKeyMapping"

echo
echo "Clearing mapping:"
sudo hidutil property --matching "$MATCH" --set '{"UserKeyMapping":[]}'
#sudo hidutil property --set '{"UserKeyMapping":[]}'

# XXX: mappings?
MAPPING=$(cat <<EOT | grep -v '^#'
{
# Swap "non-US \ and |" with "grave accent and tilde"
# to make sure they are on the right keys
# (assuming "British - PC" Input Source has been selected).
  "UserKeyMapping": [
    {
      "HIDKeyboardModifierMappingSrc": 0x700000064,
      "HIDKeyboardModifierMappingDst": 0x700000035
    },
    {
      "HIDKeyboardModifierMappingSrc": 0x700000035,
      "HIDKeyboardModifierMappingDst": 0x700000064
    },
# Map Application key (context menu key) to Left GUI,
# which is then mapped by OS to Option
# (assuming that Windows and Alt keys have been swapped
# to Option and Command).
    {
      "HIDKeyboardModifierMappingSrc": 0x700000065,
      "HIDKeyboardModifierMappingDst": 0x7000000E2
    }
  ]
}
EOT
)

SHORTMAPPING=$(echo "$MAPPING" | perl -ne 's/\s//g; print;')
#echo "$MAPPING"
#echo "$SHORTMAPPING"

#exit 0

echo
echo "Setting mapping:"
sudo hidutil property --matching "$MATCH" --set "$SHORTMAPPING"
#sudo hidutil property --set "$SHORTMAPPING"
