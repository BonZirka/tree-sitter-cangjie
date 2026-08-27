/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// DEPENDENCE: ./utils
// EXEC: %compiler %cmp_opt -p utils --mock=on %compile_lib_opt --output p1.%middle
// EXEC: %compiler %cmp_opt p1.%middle %n.cj -o %output %cmp_utest_opt 2>&1
// EXEC-PIPE-0: %run %run_opt %output %run_utest_opt %run_args 2>&1

import utils.*
import std.unittest.*
import std.unittest.mock.*
import std.unittest.testmacro.*
import std.unittest.mock.mockmacro.*

public interface Example {
    mut prop s: String
    mut prop g: Int64
}

public abstract class ExampleClass {
    public mut prop varProp: String
    public prop letProp: Int64
    public var varField: Int64 = 0
    public let letField: Int64 = 11
}

@Test
public class SyntheticFieldsModeTest {
    private let e = mock<Example>(SyntheticFields)

    @TestCase
    func setAndThenGet(): Unit {
        success {
            e.s = "abc"
            @Assert(e.s, "abc")
            e.s = "bca"
            @Assert(e.s, "bca")

            e.g = 0

            @Assert(e.g, 0)
            e.g = 55
            @Assert(e.g, 55)
        }
    }

    @TestCase
    func changesNotVisibleBetweenSessions(): Unit {
        success {
            e.s = "abc"
            @Assert(e.s, "abc")
        }

        runtimeException<UnhandledCallException>(["Trying to read value of property s before it was set."]) {
            e.s
        }
    }

    @TestCase
    func explicitStubsShouldOverride(): Unit {
        success {
            e.s = "abc"
            @Assert(e.s, "abc")
            @On(e.s).returns("foo")
            @Assert(e.s, "foo")
        }

        success {
            @On(e.s).returns("foo")
            @Assert(e.s, "foo")
            e.s = "abc"
            @Assert(e.s, "foo")
        }

        success {
            e.s = "abc"
            @Assert(e.s, "abc")
            @On(e.s = _).doesNothing()
            e.s = "foo"
            @Assert(e.s, "abc")
        }

        success {
            @On(e.s = _).doesNothing()
            e.s = "foo" //should fail
        }
    }

    @TestCase
    func explicitSyntheticFieldIsVeryConfusing(): Unit {
        success {
            let f = SyntheticField.create(initialValue: "synthetic")
            @On(e.s).getsField(f)
            @Assert(e.s, "synthetic")
            e.s = "foo"
            @Assert(e.s, "synthetic")
            @On(e.s = _).setsField(f)
            e.s = "bar"
            @Assert(e.s, "bar")
        }

        success {
            let f = SyntheticField.create(initialValue: "synthetic")
            e.s = "foo"
            @Assert(e.s, "foo")
            @On(e.s).getsField(f)
            @Assert(e.s, "synthetic")
            e.s = "bar"
            @Assert(e.s, "synthetic")
            @On(e.s = _).setsField(f)
            e.s = "baz"
            @Assert(e.s, "baz")
        }
    }

    @TestCase
    func shouldReportFieldNotSet(): Unit {
        runtimeException<UnhandledCallException>(["Trying to read value of property varProp before it was set."]) {
            let e = mock<ExampleClass>(SyntheticFields)
            e.varProp
        }

        runtimeException<UnhandledCallException>(["Trying to read value of field varField before it was set."]) {
            let e = mock<ExampleClass>(SyntheticFields)
            e.varField
        }

        runtimeException<UnhandledCallException>(
            [
                "Trying to read value of readonly property letProp.",
                "Use stubs to define the value."
            ]
        ) {
            let e = mock<ExampleClass>(SyntheticFields)
            e.letProp
        }

        runtimeException<UnhandledCallException>(["Trying to read value of readonly field letField."]) {
            let e = mock<ExampleClass>(SyntheticFields)
            e.letField
        }
    }

    @TestCase
    func verifyingDefaultCalls(): Unit {
        success {
            let e = mock<ExampleClass>(SyntheticFields)
            e.varProp = "foo"
            Verify.that(@Called(e.varProp = _).once())
            e.varProp = "bar"
            Verify.that(@Called(e.varProp = _).times(2))
            e.varProp

            Verify.unordered(
                @Called(e.varProp).once(),
                @Called(e.varProp = _).times(2)
            )
        }

        verificationFailure("TooFewInvocations") {
            let e = mock<ExampleClass>(SyntheticFields)
            e.varProp = "foo"
            e.varProp = "bar"

            Verify.unordered(@Called(e.varProp = _).times(3))
        }
    }
}
