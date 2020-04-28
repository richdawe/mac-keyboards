#!/bin/bash

# USB usage tables (from the USB HID Usage Tables (HUT) doc):
#  1 (0x01) = Generic desktop page
# 12 (0x0c) = Consumer page

# HID devices for the keyboard:

# % hidutil list | grep -E '(Services:|VendorID|Devices|Fantastic60)'
# Services:
# VendorID ProductID LocationID         UsagePage Usage RegistryID  Transport Class                         Product                            UserClass               Built-In
# 0x6c4e   0x6060    0x14110000         1         2     0x1000051d6 USB       AppleUserHIDEventService      Fantastic60                        AppleUserHIDEventDriver (null)
# 0x6c4e   0x6060    0x14110000         1         128   0x1000051d4 USB       IOHIDEventDriver              Fantastic60                        (null)                  (null)
# 0x6c4e   0x6060    0x14110000         1         6     0x1000051d2 USB       AppleUserHIDEventService      Fantastic60                        AppleUserHIDEventDriver (null)
# 0x6c4e   0x6060    0x14110000         1         6     0x1000051df USB       AppleUserHIDEventService      Fantastic60                        AppleUserHIDEventDriver (null)
# Devices:
# VendorID ProductID LocationID         UsagePage Usage RegistryID  Transport Class                    Product                             UserClass                 Built-In
# 0x6c4e   0x6060    0x14110000         65329     116   0x1000051ad USB       AppleUserHIDDevice       Fantastic60                         AppleUserUSBHostHIDDevice 0
# 0x6c4e   0x6060    0x14110000         1         6     0x1000051b0 USB       AppleUserHIDDevice       Fantastic60                         AppleUserUSBHostHIDDevice 0
# 0x6c4e   0x6060    0x14110000         1         128   0x1000051a7 USB       AppleUserHIDDevice       Fantastic60                         AppleUserUSBHostHIDDevice 0
# 0x6c4e   0x6060    0x14110000         1         2     0x1000051a1 USB       AppleUserHIDDevice       Fantastic60                         AppleUserUSBHostHIDDevice 0
# 0x6c4e   0x6060    0x14110000         1         6     0x10000519a USB       AppleUserHIDDevice       Fantastic60                         AppleUserUSBHostHIDDevice 0

# Default mappings (none):

# % hidutil property --matching '{"ProductID":0x6060,"VendorID":0x6c4e}' --get "UserKeyMapping"
# RegistryID  Key                   Value
# 1000051d6   UserKeyMapping   (null)
# 1000051d4   UserKeyMapping   (null)
# 1000051d2   UserKeyMapping   (null)
# 1000051df   UserKeyMapping   (null)

# VendorID ProductID ... Product
# 0x6c4e   0x6060    ... Fantastic60
MATCH='[{"ProductID":0x6060,"VendorID":0x6c4e},{"PrimaryUsagePage":1}]'

echo "Old mapping:"
sudo hidutil property --matching "$MATCH" --get "UserKeyMapping"

echo
echo "Clearing mapping:"
sudo hidutil property --matching "$MATCH" --set '{"UserKeyMapping":[]}'
#sudo hidutil property --set '{"UserKeyMapping":[]}'

# XXX: mappings?
MAPPING=$(cat <<'EOT' | grep -v '^#'
{
  "UserKeyMapping": [
# Map Application key (context menu key) to Grave/Backtick (`) and Tilde (~)
# to make that character more accessible than using FN+Shift+Escape.
    {
      "HIDKeyboardModifierMappingSrc": 0x700000065,
      "HIDKeyboardModifierMappingDst": 0x700000035
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
