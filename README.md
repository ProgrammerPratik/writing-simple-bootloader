## Writing A Simple Bootloader

In this project i write a simple low level bootloader and print stuff in it. This bootloader is a minimal program that gets loaded into memory by BIOS and prints assembly instructions on screen i.e. "Hello World". This project is from this cool [article](http://3zanders.co.uk/2017/10/13/writing-a-bootloader/) very cool and simple work!

## Files:
- **boot1.asm**: printing in 16-bit Real mode.
- **boot2.asm**: printing in 32-bit protected mode.

## Prerequisites!!!
You don't wanna destroy your harware so you need these

- **NASM**: The Netwide Assembler, used to assemble the bootloader code into binary format.
- **QEMU**: A hardware emulator that is used to test the bootloader.

install both by (linux commands):
```
sudo apt-get install nasm qemu-system
```

## Usage

1. Clone the repository and navigate to the project directory:
```
git clone https://github.com/ProgrammerPratik/writing-simple-bootloader.git
cd writing-simple-bootloader
```

2. Assemble the assembly code using NASM:
```
nasm -f bin boot1.asm -o boot1.bin
```

3. Test the bootloader using QEMU:
```
qemu-system-x86_64 -fda boot1.bin
```

OR

step 2 and 3 at once:
```
nasm -f bin boot3.asm -o boot.bin && qemu-system-x86_64 -fda boot.bin
```

## Outputs
boot1.asm (16-bit mode) output:
![boot1](https://github.com/user-attachments/assets/7e29e027-388b-492f-9253-962e54b46151)

boot2.asm (32-bit mode) output:
![boot2](https://github.com/user-attachments/assets/a2ac0b88-0e4d-4f01-9b25-a9144300cde0)

