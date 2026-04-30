// Binary adder simulator
package hardware_simulator

// import tina "../../src"

import "core:fmt"
import "core:testing"

// struct Adder8Bit {

// }

// struct Adder1Bit {

// }

main :: proc() {
    fmt.println("Binary Adder Simulator")

    fmt.println("TODO: Need a way to hook inputs to outputs using handles in an intrusive list")

    // Each loop is a clock cycle
    // TODO: Eventually try using Tina to schedule different update tasks for different groups of modules
    // for {}
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
