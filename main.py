# R4 instruction opcodes
r4_opcodes = {
    "simal": "000",  # Signed Integer Multiply-Add Low with Saturation
    "simah": "001",  # Signed Integer Multiply-Add High with Saturation
    "simsl": "010",  # Signed Integer Multiply-Subtract Low with Saturation
    "simsh": "011",  # Signed Integer Multiply-Subtract High with Saturation
    "simlal": "100", # Signed Long Integer Multiply-Add Low with Saturation
    "simlah": "101", # Signed Long Integer Multiply-Add High with Saturation
    "simlsl": "110", # Signed Long Integer Multiply-Subtract Low with Saturation
    "simlsh": "111", # Signed Long Integer Multiply-Subtract High with Saturation
}

# R3 instruction opcodes
r3_opcodes = {
    "nop": "00000000",   # No Operation
    "slhi": "00000001",  # Shift left halfword immediate
    "au": "00000010",    # Add word unsigned
    "cnt1h": "00000011", # Count 1s in halfwords         
    "ahs": "00000100",   # add halfword saturated 
    "and": "00000101",   # Bitwise logical AND 
    "bcw": "00000110",   # Broadcast word
    "maxws": "00000111", # Max signed word
    "minws": "00001000", # Min signed word
    "mlhu": "00001001",  # Multiply low unsigned
    "mlhcu": "00001010", # Multiply low by constant unsigned
    "or": "00001011",    # Bitwise logical or
    "clzh": "00001100",  # Count leading zeroes in halfwords
    "rlh": "00001101",   # Rotate left bits in halfwords
    "sfwu": "00001110",  # Subtract from word unsigned
    "sfhs": "00001111",  # Subtract from halfword saturated
}

# parses the register to know which register number it is
def parse_register(register):
    register = register.rstrip(",")
    if not register.startswith("$r"):
        raise ValueError(f"Invalid register name: {register}")
    try:
        reg_num = int(register[2:])
        if reg_num < 0 or reg_num > 31:
            raise ValueError(f"Register number out of range: {register}")
        return f"{reg_num:05b}"  # Convert to 5-bit binary
    except ValueError:
        raise ValueError(f"Invalid register name: {register}")

# Read the immediate values
def parse_immediate(immediate):
    try:
        # Dont read commas
        immediate = immediate.strip().rstrip(",")
        imm = int(immediate)  # Convert the decimal value to integer
        if imm < -32768 or imm > 32767:  # Checks if immediate is within 16-bit range
            raise ValueError(f"Immediate value out of range: {immediate}")
        return f"{imm & 0xFFFF:016b}"  # hhandle negative numbers 
    except ValueError as e:
        raise ValueError(f"Invalid immediate value: {immediate}") from e

# parses the load index 
def parse_load_index(load_index):
    try:
        idx = int(load_index)
        if idx < 0 or idx > 7:  
            raise ValueError(f"Load index out of range: {load_index}")
        return f"{idx:03b}"  
    except ValueError:
        raise ValueError(f"Invalid load index: {load_index}")

# Assembles the instruction
def assemble_instruction(line, line_number):
    parts = line.split()
    if not parts:
        return None, f"Error on line {line_number}: Blank or invalid line"
    instruction = parts[0].lower()
    operands = [operand.strip() for operand in parts[1:]]  
    try:
        if instruction == "li":  # Load Immediate
            if len(operands) != 3:
                return None, f"Error on line {line_number}: LI requires 3 operands: {operands}"
            rd = parse_register(operands[0]) 
            immediate = parse_immediate(operands[1])  
            load_index = parse_load_index(operands[2]) 
            binary = f"0{load_index}{immediate}{rd}"
            if len(binary) != 25:
                return None, f"Error on line {line_number}"

            return binary, None  
        elif instruction == "nop":  # No Operation
            if len(operands) != 0:
                return None, f"Error on line {line_number}: NOP"
            binary = "1100000000000000000000000"  # Fill instructions with zeros
            return binary, None  

        elif instruction in r4_opcodes: 
            if len(operands) != 4:
                return None, f"Error on line {line_number}: R4 instructions require 4 operands: {operands}"
            rd = parse_register(operands[0])
            rs1 = parse_register(operands[1])
            rs2 = parse_register(operands[2])
            rs3 = parse_register(operands[3])
            opcode = r4_opcodes[instruction]
            binary = f"10{opcode}{rs3}{rs2}{rs1}{rd}"
            return binary, None  

        elif instruction in r3_opcodes: 
            if len(operands) != 3:
                return None, f"Error on line {line_number}: R3 instructions require 3 operands: {operands}"
            rd = parse_register(operands[0])
            rs1 = parse_register(operands[1])
            rs2 = parse_register(operands[2])
            opcode = r3_opcodes[instruction]
            binary = f"11{opcode}{rs2}{rs1}{rd}"
            return binary, None 

        else:
            return None, f"Error on line {line_number}: Unknown instruction: {instruction}"

    except ValueError as e:
        return None, f"Error on line {line_number}: {str(e)}"

# Main function
def assemble_file(input_file, output_file):
    try:
        with open(input_file, "r") as infile, open(output_file, "w") as outfile:
            lines = infile.readlines()
            errors = []
            for line_number, line in enumerate(lines, start=1):
                line = line.strip()
                if not line:  # Skip blank lines
                    continue
                binary, comment = assemble_instruction(line, line_number)
                if binary:
                    outfile.write(binary + "\n")  # Write only the binary instruction
                else:
                    errors.append(comment)
            if errors:
                print("\n".join(errors))
            print("Output written to", output_file)
    except FileNotFoundError:
        print(f"Error: File '{input_file}' not found.")

# Run assembler
assemble_file("/Users/dongyunlee/Documents/SBU_2024_Fall/ESE345/ese345_project/instructions.txt", "/Users/dongyunlee/Documents/SBU_2024_Fall/ESE345/ese345_project/output.txt")
