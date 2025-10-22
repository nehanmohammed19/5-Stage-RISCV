# RISC-V 5-Stage Pipelined Processor

A complete implementation of a 32-bit RISC-V processor featuring a 5-stage pipeline with integrated hazard detection, data forwarding logic, and pipeline stalling mechanisms to handle data and control hazards.

## Custom Architecture Design

This implementation includes a **custom top-level architecture data path diagram** specifically designed for this RISC-V processor implementation. The diagram illustrates the complete data flow through all five pipeline stages, including:

- **Pipeline Register Connections**: Shows how data flows between IF/ID, ID/EX, EX/MEM, and MEM/WB pipeline registers
- **Data Forwarding Paths**: Visualizes the forwarding multiplexers and control signals for hazard resolution
- **Control Signal Distribution**: Demonstrates how control signals propagate through the pipeline stages
- **Memory System Integration**: Shows the connection between instruction memory, data memory, and the pipeline
- **Branch Resolution Logic**: Illustrates how branch decisions affect the program counter and pipeline flow

The custom architecture diagram provides a comprehensive visual representation of the processor's internal structure, making it easier to understand the complex interactions between pipeline stages and the sophisticated hazard handling mechanisms.

## Architecture Overview

This processor implements the RISC-V RV32I base instruction set with a classic 5-stage pipeline architecture:

- **Fetch (F)**: Instruction fetch from instruction memory
- **Decode (D)**: Instruction decoding and register file read
- **Execute (E)**: ALU operations and branch resolution
- **Memory (M)**: Data memory access
- **Writeback (W)**: Register file write

## Key Features

### Core Pipeline Features
- **5-Stage Pipeline**: Optimized for high throughput with balanced stage delays
- **32-bit RISC-V RV32I**: Full support for base integer instruction set
- **Load/Store Architecture**: Separate instruction and data memories

### Advanced Hazard Handling
- **Data Hazard Detection**: Automatic detection of RAW (Read After Write) hazards
- **Data Forwarding**: Forwarding paths from EX/MEM and MEM/WB pipeline registers
- **Control Hazard Handling**: Pipeline stalling for branch instructions

### Memory System
- **Instruction Memory**: 4KB instruction cache with hex file loading
- **Data Memory**: 4KB data memory with byte-addressable access
- **Memory-Mapped I/O**: Support for memory-mapped peripheral access

## Project Structure

```
src/
├── Pipeline_Top.v          # Top-level pipeline integration
├── Pipeline_tb.v           # Complete pipeline testbench
├── Hazard_unit.v          # Data forwarding and hazard detection
├── Fetch_cycle.v          # Instruction fetch stage
├── decode_cycle.v         # Instruction decode stage  
├── execute_cycle.v        # ALU execution stage
├── Memory_Cycle.v         # Memory access stage
├── writeback_Cycle.v      # Writeback stage
├── Control_Unit_Top.v     # Main control unit
├── Main_Decoder.v         # Primary instruction decoder
├── ALU_Decoder.v          # ALU control decoder
├── ALU.v                  # Arithmetic Logic Unit
├── register_file.v       # 32x32 register file
├── Data_Memory.v          # Data memory module
├── imemory.v              # Instruction memory module
├── Program_counter.v      # Program counter with branch support
├── Immediate_Gen.v        # Immediate value generator
├── MUX.v                  # Multiplexer modules (2:1 and 3:1)
├── Adder.v                # Adder modules
├── fetch_cycle_tb.v       # Testbench for fetch stage
├── memfile.hex            # Instruction memory initialization
├── dump.vcd               # Waveform dump file
└── Pipeline.gtkw          # GTKWave configuration
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
- Extracts source register addresses (Rs1, Rs2) for forwarding
- Pipeline register: ID/EX

### 3. Execute Stage (`execute_cycle.v`)
- Performs ALU operations based on instruction type
- Handles branch condition evaluation
- Calculates branch target addresses
- Implements data forwarding for hazard resolution
- Pipeline register: EX/MEM

### 4. Memory Stage (`Memory_Cycle.v`)
- Accesses data memory for load/store instructions
- Passes through ALU results for R-type instructions
- Pipeline register: MEM/WB

### 5. Writeback Stage (`writeback_Cycle.v`)
- Writes results back to register file
- Selects between ALU result, memory data, or PC+4


### Hazard Unit (`Hazard_unit.v`)
- Detects RAW hazards between pipeline stages
- Generates forwarding control signals
- Handles special cases for register x0 (always zero)

## Supported Instructions

### R-Type Instructions
- `ADD`, `SUB`, `AND`, `OR`, `XOR`, `SLL`, `SRL`, `SRA`, `SLT`, `SLTU`

### I-Type Instructions  
- `ADDI`, `ANDI`, `ORI`, `XORI`, `SLLI`, `SRLI`, `SRAI`, `SLTI`

### S-Type Instructions
- `SB`, `SH`, `SW`

### B-Type Instructions
- `BEQ`, `BNE`, `BLT`, `BGE`, `BLTU`, `BGEU`

## Testing and Simulation

### Testbench Structure
The project includes comprehensive testbenches:

```verilog
// Complete pipeline testbench
module Pipeline_tb();
    reg clk = 0, reset;
    Pipeline_Top dut(.clk(clk), .reset(reset));
    // Clock generation and simulation control
endmodule
```

### Memory Initialization
- Instructions loaded from `memfile.hex`
- Supports standard Intel hex format
- Automatic memory initialization on reset

### Waveform Generation
- VCD file generation for debugging
- Comprehensive signal monitoring
- Pipeline stage visualization with GTKWave

## Getting Started

### Prerequisites
- Verilog simulator (ModelSim, Vivado, or Icarus Verilog)
- GTKWave for waveform viewing

### Compilation
```bash
# Compile complete pipeline
iverilog -o pipeline Pipeline_Top.v Pipeline_tb.v *.v

# Run simulation
vvp pipeline

# View waveforms
gtkwave dump.vcd Pipeline.gtkw
```

### Running Tests
```bash
# Compile and run pipeline testbench
iverilog -o pipeline_test Pipeline_tb.v Pipeline_Top.v *.v
vvp pipeline_test
```
## Advanced Features

### Data Forwarding Implementation
- **EX/MEM Forwarding**: Forwards results from the memory stage
- **MEM/WB Forwarding**: Forwards results from the writeback stage
- **Priority Logic**: MEM stage results take priority over WB stage
## Future Enhancements

### Planned Features
- [ ] Cache memory system
- [ ] Floating-point unit (RV32F)
- [ ] Multiply/divide unit (RV32M)
- [ ] Advanced branch prediction and instructions
- [ ] Control Hazard solution 
- [ ] Out-of-order execution
- [ ] Superscalar architecture


## License

This project is released under the MIT License. See LICENSE file for details.

---
