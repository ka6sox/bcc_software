#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#include "string.h"
#include "stdint.h"
#include "stdio.h"
#include "unistd.h"

typedef uint8_t byte;


struct eeprom_data {
	byte header[4];
	char revision[2];
	char board_name[32];
	char version[4];
	char manufacturer[16];
	char part_number[16];
	uint16_t num_pins;
	char serial_number[12];
	uint16_t pinmux[74];
	uint16_t current3v3;
	uint16_t currentVdd;
	uint16_t currentSys;
	uint16_t dcSupplied;
};

void main(int argc, char **argv) {
	int i;

	struct eeprom_data data;

	data.header[0] = 0xAA;
	data.header[1] = 0x55;
	data.header[2] = 0x33;
	data.header[3] = 0xEE;
	strncpy((data.revision), 			"A1", 2);
	strncpy((data.board_name),	 		"BCC", 32);
	strncpy((data.version), 			"00A0", 4);
	strncpy((data.manufacturer),		"bcc folks", 16);
	strncpy((data.part_number), 		"BB-SPI0-SPIDEV", 16);
	strncpy((data.serial_number), 	"0001", 12);
	data.num_pins = 92;

	for(i=0; i<74; i++) {
		data.pinmux[i] = 0x0000;
	}

	data.current3v3 = 0x0000;
	data.currentVdd = 0x0000;
	data.currentSys = 0x0000;
	data.dcSupplied = 0x0000;

	int fd = open("data.bin", O_WRONLY | O_CREAT, 0644);

	byte *byteptr = (byte *)&data;

	write(fd, byteptr, sizeof(struct eeprom_data));

	close(fd);
	
}
