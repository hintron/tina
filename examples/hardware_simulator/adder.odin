// Binary adder simulator
package hardware_simulator

// import tina "../../src"

import "core:fmt"
import "core:testing"

// struct Adder8Bit {

// }

// struct Adder1Bit {

// }


// TODO:
// Need a "register" type to hold an incoming value when clocked
// Need a way to connect the output of one module to the input register of another module
// Need a way to move "ownership" of a fat struct from one module to another without duplication. Possibly have an intrusive list for each type of struct? And each movement keeps it in place in memory, just changes a handle to change ownership?


main :: proc() {
    fmt.println("Binary Adder Simulator")

    MAX_CLOCKS := 10000
    clocks := 0
    // Each loop is a clock cycle
    // TODO: Eventually try using Tina to schedule different update tasks for different groups of modules
    for {
        // Increment the clock
        clocks += 1

        ////////////////////////////////////////////////////////////////////////
        // "Clock" all modules. This copies or moves items from outputs to input registers
        ////////////////////////////////////////////////////////////////////////

        ////////////////////////////////////////////////////////////////////////
        // "Update" all modules - compute new output values based on current input register values
        ////////////////////////////////////////////////////////////////////////


        // Check for end condition
        if clocks >= MAX_CLOCKS {
            fmt.printfln("Reached max clock cycles (%v), ending simulation.", MAX_CLOCKS)
            break
        }

        // repeat
    }
}


// Truth table:
// A = bit 1, B = bit 2,
// Ci = Carry in, Co = Carry out, S = Sum
// | A | B | Ci || S | Co
// |------------+-----------------
// | 0 | 0 | 0  || 0 | 0
// | 0 | 0 | 1  || 1 | 0
// | 0 | 1 | 0  || 1 | 0
// | 0 | 1 | 1  || 0 | 1
// | 1 | 0 | 0  || 1 | 0
// | 1 | 0 | 1  || 0 | 1
// | 1 | 1 | 0  || 0 | 1
// | 1 | 1 | 1  || 1 | 1
binary_add :: proc(a: u8, b: u8, carry_in: u8 = 0) -> (u8, u8) {
    assert(a == 0 || a == 1)
    assert(b == 0 || b == 1)
    assert(carry_in == 0 || carry_in == 1)
    sum := (a + b + carry_in)
    sum_bit := sum % 2  // The sum bit is 1 if there is an odd number of input 1s
    carry_out_bit := sum / 2  // A carry out only occurs if sum > 1
    return sum_bit, carry_out_bit
}


// // Test the truth table for binary_add()
@(test)
test_binary_add_all :: proc(t: ^testing.T) {
    sum, carry: u8
    sum, carry = binary_add(0, 0, 0)
    testing.expect(t, sum == 0 && carry == 0, "a:0 + b:0 + carry_in:0 should be sum:0, carry_out:0")
    sum, carry = binary_add(0, 0, 1)
    testing.expect(t, sum == 1 && carry == 0, "a:0 + b:0 + carry_in:1 should be sum:1, carry_out:0")
    sum, carry = binary_add(0, 1, 0)
    testing.expect(t, sum == 1 && carry == 0, "a:0 + b:1 + carry_in:0 should be sum:1, carry_out:0")
    sum, carry = binary_add(0, 1, 1)
    testing.expect(t, sum == 0 && carry == 1, "a:0 + b:1 + carry_in:1 should be sum:0, carry_out:1")
    sum, carry = binary_add(1, 0, 0)
    testing.expect(t, sum == 1 && carry == 0, "a:1 + b:0 + carry_in:0 should be sum:1, carry_out:0")
    sum, carry = binary_add(1, 0, 1)
    testing.expect(t, sum == 0 && carry == 1, "a:1 + b:0 + carry_in:1 should be sum:0, carry_out:1")
    sum, carry = binary_add(1, 1, 0)
    testing.expect(t, sum == 0 && carry == 1, "a:1 + b:1 + carry_in:0 should be sum:0, carry_out:1")
    sum, carry = binary_add(1, 1, 1)
    testing.expect(t, sum == 1 && carry == 1, "a:1 + b:1 + carry_in:1 should be sum:1, carry_out:1")

    // Test with default carry_in = 0
    sum, carry = binary_add(0, 0)
    testing.expect(t, sum == 0 && carry == 0, "a:0 + b:0 + carry_in:0 should be sum:0, carry_out:0")
    sum, carry = binary_add(0, 1)
    testing.expect(t, sum == 1 && carry == 0, "a:0 + b:1 + carry_in:0 should be sum:1, carry_out:0")
    sum, carry = binary_add(1, 0)
    testing.expect(t, sum == 1 && carry == 0, "a:1 + b:0 + carry_in:0 should be sum:1, carry_out:0")
    sum, carry = binary_add(1, 1)
    testing.expect(t, sum == 0 && carry == 1, "a:1 + b:1 + carry_in:0 should be sum:0, carry_out:1")
}
