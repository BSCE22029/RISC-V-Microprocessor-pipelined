# RISC-V pipelined processor using Verilog HDL
This project implements a 5-stage pipelined RISC-V processor using Verilog HDL. The processor supports basic RISC-V instructions and demonstrates instruction-level parallelism with pipelining.

📌 Features
✅ 5-stage pipeline: IF, ID, EX, MEM, WB

✅ Instruction memory and register file

✅ ALU with R-type and I-type operation support

✅ Hazard detection and forwarding

✅ Pipeline registers: IF/ID, ID/EX, EX/MEM, MEM/WB

✅ Basic branching and jump (optional)

✅ Fully synthesizable

📖 Pipeline Stages
Instruction Fetch (IF): Fetches instruction from memory

Instruction Decode (ID): Decodes instruction and reads registers

Execute (EX): ALU operations, branch decision

Memory Access (MEM): Data memory read/write

Write Back (WB): Writes result back to register file

🧪 Supported Instructions
R-type: add, sub, and, or, slt

I-type: addi, andi, ori, lw

S-type: sw

B-type: beq, bne

(Add more as needed)

⚙️ How to Run
Prerequisites
Vivado Software by Xilix or
Icarus Verilog (for simulation)
Install: sudo apt install iverilog gtkwave

GTKWave (for waveform viewing)

Step-by-step Execution
Compile the design and testbench:


iverilog -o riscv_pipeline testbench/testbench.v src/**/*.v
Run the simulation:

vvp riscv_pipeline
View waveform (optional):


gtkwave waveform/pipeline.vcd
🧠 Design Highlights
Hazard Handling:
Implements stalling for load-use hazards and data forwarding from EX/MEM and MEM/WB.

Control Unit:
Generates control signals based on opcode and function codes.

Modular Design:
All components are separated in modules for reusability and testing.

🧪 Test Program
The file test_program.mem includes a set of RISC-V instructions in hexadecimal format loaded into the instruction memory at runtime.

Example:


00000013  // nop
00400093  // li x1, 4
00108133  // add x2, x1, x1
📚 References
RISC-V Instruction Set Manual

[Computer Organization and Design - Patterson & Hennessy]

GitHub Pipelined CPU Projects

🛠️ Future Work
⏳ Support for JAL, JALR

⏳ Support for more ALU operations

⏳ Cache integration

⏳ Exception handling and CSR

👨‍💻 Author
Muhammad Moiz Ahmad
Computer Engineer | Digital Design | Verilog | RISC-V Architecture
