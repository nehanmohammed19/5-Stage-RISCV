# RISC-V 5-Stage Pipelined Processor

A complete implementation of a 32-bit RISC-V processor featuring a 5-stage pipeline with integrated hazard detection, data forwarding logic, and pipeline stalling mechanisms to handle data and control hazards.

## Architecture Overview

This processor implements the RISC-V RV32I base instruction set with a 5-stage pipeline architecture:

- **Fetch (F)**: Instruction fetch from instruction memory
- **Decode (D)**: Instruction decoding and register file read
- **Execute (E)**: ALU operations and branch resolution
- **Memory (M)**: Data memory access
- **Writeback (W)**: Register file write

##  Key Features

### Core Pipeline Features
- **5-Stage Pipeline**: Optimized for high throughput with balanced stage delays
- **32-bit RISC-V RV32I**: Full support for base integer instruction set
- **Load/Store Architecture**: Separate instruction and data memories

### Advanced Hazard Handling
- **Data Hazard Detection**: Automatic detection of RAW (Read After Write) hazards
- **Data Forwarding**: Forwarding paths from EX/MEM and MEM/WB pipeline registers

### Memory System
- **Instruction Memory**: 4KB instruction cache with hex file loading
- **Data Memory**: 4KB data memory with byte-addressable access
- **Memory-Mapped I/O**: Support for memory-mapped peripheral access

## Project Structure

```
design/code/
├── Fetch_cycle.v          # Instruction fetch stage
├── decode_cycle.v         # Instruction decode stage  
├── execute_cycle.v        # ALU execution stage
├── Memory_Cycle.v         # Memory access stage
├── Control_Unit_Top.v     # Main control unit
├── Main_Decoder.v         # Primary instruction decoder
├── ALU_Decoder.v          # ALU control decoder
├── ALU.v                  # Arithmetic Logic Unit
├── register_file.v        # 32x32 register file
├── Data_Memory.v          # Data memory module
├── imemory.v              # Instruction memory module
├── Program_counter.v      # Program counter with branch support
├── Immediate_Gen.v        # Immediate value generator
├── MUX.v                  # Multiplexer modules
├── Adder.v                # Adder modules
├── fetch_cycle_tb.v       # Testbench for fetch stage

```

## Pipeline Stages

### 1. Fetch Stage (`Fetch_cycle.v`)
- Fetches instructions from instruction memory
- Calculates PC+4 for sequential execution
- Handles branch target selection via PC source multiplexer
- Pipeline register: IF/ID

### 2. Decode Stage (`decode_cycle.v`)
- Decodes instruction opcode and generates control signals
- Reads source registers from register file
- Generates immediate values for different instruction types
- Pipeline register: ID/EX

### 3. Execute Stage (`execute_cycle.v`)
- Performs ALU operations based on instruction type
- Handles branch condition evaluation
- Calculates branch target addresses
- Pipeline register: EX/MEM

### 4. Memory Stage (`Memory_Cycle.v`)
- Accesses data memory for load/store instructions
- Passes through ALU results for R-type instructions
- Pipeline register: MEM/WB

### 5. Writeback Stage
- Writes results back to register file
- Selects between ALU result, memory data, or PC+4


### Data Forwarding Logic
- **EX/MEM Forwarding**: Forwards results from the memory stage
- **MEM/WB Forwarding**: Forwards results from the writeback stage


## Supported Instructions

### R-Type Instructions
- `ADD`, `SUB`, `AND`, `OR`, `XOR`, `SLL`, `SRL`, `SRA`, `SLT`, `SLTU`

### I-Type Instructions  
- `ADDI`, `ANDI`, `ORI`, `XORI`, `SLLI`, `SRLI`, `SRAI`, `SLTI`, `SLTIU`
- `LB`, `LH`, `LW`, `LBU`, `LHU`

### S-Type Instructions
- `SB`, `SH`, `SW`


## Getting Started

### Prerequisites
- Verilog simulator (ModelSim, Vivado, or Icarus Verilog)

### Compilation
```bash
# Compile with Icarus Verilog
iverilog -o processor *.v

# Run simulation
vvp processor

# View waveforms
gtkwave dump.vcd
```

### Running Tests
```bash
# Compile testbench
iverilog -o testbench fetch_cycle_tb.v Fetch_cycle.v *.v

# Run testbench
vvp testbench
```

## Performance Characteristics

### Pipeline Efficiency
- **CPI (Cycles Per Instruction)**: ~1.0 for hazard-free code
- **Branch Penalty**: 1 cycle for taken branches
- **Load-Use Penalty**: 1 cycle stall for dependent loads

### Resource Utilization
- **Registers**: 32 general-purpose registers (x0-x31)
- **Memory**: 4KB instruction + 4KB data memory
- **Pipeline Registers**: Optimized for minimal area overhead

### Timing Analysis
- **Critical Path**: Through ALU in execute stage
- **Clock Frequency**: Optimized for balanced pipeline stages
- **Setup/Hold Times**: Properly constrained for reliable operation

## Future Enhancements

### Planned Features
- [ ] Cache memory system
- [ ] Floating-point unit (RV32F)
- [ ] Multiply/divide unit (RV32M)
- [ ] Advanced branch prediction
- [ ] Out-of-order execution
- [ ] Superscalar architecture

### Optimization Opportunities
- [ ] Pipeline stage balancing
- [ ] Critical path optimization
- [ ] Power consumption reduction
- [ ] Area optimization



##  License

This project is released under the MIT License. See LICENSE file for details.

---
