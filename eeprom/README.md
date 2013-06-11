# Blank Canvas Cape eeprom programming

The BeagleBone cape specification in the SRM specifies the details for cape eeprom contents.  The cape eeprom is primarily used to inform the kernel metadata about the hardware for selecting the proper device tree overlay for configuring pinmux and drivers.

-----------

This tool is super simple right now.  Fill in the initialization parameters of the data struct with your desired values.  The only critical value right now is "part number", as this needs to match the part number in the device tree overlay that you wish to have loaded.

Compile the tool with:

	gcc -o eeprom_data eeprom_data.c

and run it.  It will produce a file, "data.bin".

Find the I2C address of your BCC's cape eeprom.  These will be in the range 0x54 - 0x57, and the address is set by the position of the 2-pos DIP switch on the BCC.  Assuming your eeprom is 0x57, you can interact with the eeprom through sysfs, by reading and writing /sys/bus/i2c/devices/1-0057/eeprom.  If you're not sure of the eeprom address, examine the contents of each eeprom file as such: 

	od -x /sys/bus/i2c/devices/1-0057/eeprom
 
A connection timed out means there's nothing connected to that address.  Some data being written to the screen means you have *a* device.  Make sure it's *the* device before writing!

To write, simply: 
	
	cat data.bin > /sys/bus/i2c/devices/1-0057/eeprom
			
(again, substituting the proper I2C address).   

	od -x /sys/bus/i2c/devices/1-0057/eeprom 
	
again to verify the write.
