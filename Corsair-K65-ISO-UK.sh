#!/bin/bash

# Needs keyboard set to "British - PC" to work

# USB usage tables (from the USB HID Usage Tables (HUT) doc):
#  1 (0x01) = Generic desktop page
# 12 (0x0c) = Consumer page

# HID devices for the keyboard:

# % hidutil list | grep -E '(Services:|VendorID|Devices|Corsair K65)'
# Services:
# VendorID ProductID LocationID         UsagePage Usage RegistryID  Transport Class                         Product                            UserClass               Built-In 
# 0x1b1c   0x1b07    0x14110000         1         6     0x1000007aa USB       AppleUserHIDEventService      Corsair K65 Gaming Keyboard        AppleUserHIDEventDriver (null)   
# 0x1b1c   0x1b07    0x14110000         12        1     0x100000783 USB       AppleUserHIDEventService      Corsair K65 Gaming Keyboard        AppleUserHIDEventDriver (null)   
# 0x1b1c   0x1b07    0x14110000         1         6     0x10000074b USB       AppleUserHIDEventService      Corsair K65 Gaming Keyboard        AppleUserHIDEventDriver (null)   
# Devices:
# VendorID ProductID LocationID         UsagePage Usage RegistryID  Transport Class                    Product                             UserClass                 Built-In 
# 0x1b1c   0x1b07    0x14110000         1         6     0x100000707 USB       AppleUserHIDDevice       Corsair K65 Gaming Keyboard         AppleUserUSBHostHIDDevice 0        
# 0x1b1c   0x1b07    0x14110000         12        1     0x100000719 USB       AppleUserHIDDevice       Corsair K65 Gaming Keyboard         AppleUserUSBHostHIDDevice 0        
# 0x1b1c   0x1b07    0x14110000         1         6     0x100000724 USB       AppleUserHIDDevice       Corsair K65 Gaming Keyboard         AppleUserUSBHostHIDDevice 0        

# Default mappings (none):

# % hidutil property --matching '{"ProductID":0x1b07,"VendorID":0x1b1c}' --get "UserKeyMapping"
# RegistryID  Key                   Value
# 1000007aa   UserKeyMapping   (null)
# 100000783   UserKeyMapping   (null)
# 10000074b   UserKeyMapping   (null)

# VendorID ProductID ... Product
# 0x1b1c   0x1b07    ... Corsair K65 Gaming Keyboard
MATCH='{"ProductID":0x1b07,"VendorID":0x1b1c}'

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

#    {
#      "HIDKeyboardModifierMappingSrc": 0x7000000E7,
#      "HIDKeyboardModifierMappingDst": 0x7000000E3
#    }

#    {
#     "HIDKeyboardModifierMappingSrc": 0x700000031,
#     "HIDKeyboardModifierMappingDst": 0x700000032
#   }
#    {
#     "HIDKeyboardModifierMappingSrc": 0x700000031,
#      "HIDKeyboardModifierMappingDst": 0x700000064
#    }
#  ]
#}
#EOT
#)

SHORTMAPPING=$(echo "$MAPPING" | perl -ne 's/\s//g; print;')
#echo "$MAPPING"
#echo "$SHORTMAPPING"

#exit 0

echo
echo "Setting mapping:"
sudo hidutil property --matching "$MATCH" --set "$SHORTMAPPING"
#sudo hidutil property --set "$SHORTMAPPING"
