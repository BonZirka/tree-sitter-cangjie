/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2025. All rights reserved.
 * This source file is part of the Cangjie project, licensed under Apache-2.0
 * with Runtime Library Exception.
 *
 * See https://cangjie-lang.cn/pages/LICENSE for license information.
 */
// DEPENDENCE: ./utils
// DEPENDENCE: ./line_number_utils
// EXEC: %compiler %cmp_opt -p utils --mock=on %compile_lib_opt --output p1.%middle
// EXEC: %compiler %cmp_opt -p line_number_utils --mock=on %compile_lib_opt --output p2.%middle
// EXEC: %compiler %cmp_opt p1.%middle p2.%middle %n.cj -o %output %cmp_utest_opt 2>&1
// EXEC-PIPE-0: %run %run_opt %output %run_utest_opt %run_args 2>&1

import utils.*
import line_number_utils.*
import std.unittest.*
import std.unittest.mock.*
import std.unittest.testmacro.*
import std.unittest.mock.mockmacro.*

class A {
    func a(): String {
        return "original"
    }

    func b(): String {
        return "original"
    }

    var c: Int = 0
}

@Test
public class LifetimeTest {
    func callOutsideLifetime(): Unit {
        testSessions {
            MockFramework.openSession("a", Stateless)
            MockFramework.openSession("b", Verifiable)
            let a = mock<A>()
            @On(a.a()).returns("a").anyTimes()
            MockFramework.closeSession()
            let e = assertThrows<MockFrameworkException> {
                a.a()
            }
            @Assert(e.message.contains("Mock object is no longer accessible"))
            MockFramework.closeSession()
        }

        testSessions {
            MockFramework.openSession("a", Stateless)
            MockFramework.openSession("123", Verifiable)
            let a = mock<A>()
            @On(a.a()).returns("a").anyTimes()
            MockFramework.closeSession()
            MockFramework.openSession("321", Verifiable)
            MockFramework.closeSession()
            MockFramework.openSession("", Verifiable)
            let e = assertThrows<MockFrameworkException> {
                a.a()
            }
            @Assert(e.message.contains("Mock object created in session 123 is no longer accessible"))
            MockFramework.closeSession()
            MockFramework.closeSession()
        }

        testSessions {
            MockFramework.openSession("321", Stateless)
            MockFramework.openSession("", Stateless)
            MockFramework.openSession("123", Verifiable)
            let a = mock<A>()
            @On(a.a()).returns("a").anyTimes()
            MockFramework.closeSession()
            MockFramework.closeSession()
            let e = assertThrows<MockFrameworkException> {
                a.a()
            }
            @Assert(e.message.contains("Mock object created in session 123 is no longer accessible during session 321"))
            MockFramework.closeSession()
        }
    }

    func configureOutsideLifetime(): Unit {
        testSessions {
            MockFramework.openSession("a", Stateless)
            MockFramework.openSession("b", Verifiable)
            let a = mock<A>()
            @On(a.a()).returns("a").anyTimes()
            MockFramework.closeSession()
            let e = assertThrows<MockFrameworkException> {
                @On(a.a())
            }
            @Assert(e.message.contains("Mock object created in session 123 is no longer accessible during session 321"))
            MockFramework.closeSession()
        }

        testSessions {
            MockFramework.openSession("", Stateless)
            MockFramework.openSession("123", Verifiable)
            let a = spy<A>(A())
            MockFramework.closeSession()
            MockFramework.openSession("321", Verifiable)
            MockFramework.closeSession()
            MockFramework.openSession("", Verifiable)
            let e = assertThrows<MockFrameworkException> {
                @On(a.a())
            }
            @Assert(e.message.contains("Mock object created in session 123 is no longer accessible"))
            MockFramework.closeSession()
            MockFramework.closeSession()
        }

        testSessions {
            MockFramework.openSession("321", Stateless)
            MockFramework.openSession("", Stateless)
            MockFramework.openSession("123", Verifiable)
            let a = mock<A>()
            MockFramework.closeSession()
            MockFramework.closeSession()
            let e = assertThrows<MockFrameworkException> {
                @On(a.a())
            }
            @Assert(e.message.contains("Mock object created in session 123 is no longer accessible during session 321"))
            MockFramework.closeSession()
        }
    }

    @TestCase
    func sharedSessionAllowsStatelessStub(): Unit {
        testSessions {
            MockFramework.openSession("shared", Stateless)
            let shared = mock<A>()
            @On(shared.a()).returns("a")
            @Assert(shared.a(), "a")
            @On(shared.b()).returns("b")
            @On(shared.b()).throws(Exception())
            @On(shared.b()).fails()

            @On(shared.a()).returns("b").anyTimes()
            @On(shared.a()).throws(Exception()).anyTimes()
            @On(shared.a()).throws(Exception()).anyTimes()

            MockFramework.closeSession()
        }
    }

    @TestCase
    func stubForbidden(): Unit {
        testSessions {
            MockFramework.openSession("forbidden", Forbidden)
            let a = mock<A>()
            let e = assertThrows<MockFrameworkException> {
                @On(a.a())
            }
            @PowerAssert(e.message.contains("stub a.a()"))
            @PowerAssert(e.message.contains("is not allowed in forbidden"))
            MockFramework.closeSession()
        }
    }

    @TestCase
    func statefulActionInStatelessSession(): Unit {
        testSessions {
            let a = mock<A>()
            actionNotAllowed("returnsConsecutively") {
                @On(a.a()).returnsConsecutively("a", "b")
            }
            actionNotAllowed("returns") {
                @On(a.a()).returns {"a"}
            }
            actionNotAllowed("throws") {
                @On(a.a()).throws {Exception()}
            }
        }
    }

    @TestCase
    func statelessActionInStatelessSession(): Unit {
        testSessions {
            try {
                MockFramework.openSession("stateless", Stateless)
                let a = mock<A>()
                @On(a.a()).returns("a")
                @On(a.a()).throws(Exception())
                let f = SyntheticField.create(initialValue: 0)
                @On(a.c).getsField(f)
                @On(a.c = _).setsField(f)
                @On(a.c = _).doesNothing()
                @On(a.c = _).fails()
                @On(a.c).returns(10)

                let b = spy(A())
                @On(b.a()).callsOriginal()
                @On(b.c).getsOriginal()
                @On(b.c = _).setsOriginal()
            } finally {
                MockFramework.closeSession()
            }
        }
    }

    @TestCase
    func settingCardinalityInStatelessSession(): Unit {
        testSessions {
            let a = mock<A>()

            cardinalityNotAllowed {
                @On(a.a()).returns("a").once()
            }
            cardinalityNotAllowed {
                @On(a.a()).returns("a").atLeastOnce()
            }
            cardinalityNotAllowed {
                @On(a.a()).returns("a").times(2)
            }
            cardinalityNotAllowed {
                @On(a.a()).throws(Exception()).times(min: 2, max: 5)
            }
        }
    }

    @TestCase
    func anytimesCardinalityAllowedInStatelessSession(): Unit {
        testSessions {
            let a = mock<A>()
            MockFramework.openSession("stateless", Stateless)
            @On(a.a()).returns("a").anyTimes()
            @On(a.a()).returns("a").atLeastTimes(0)
            MockFramework.closeSession()
        }
    }
}

func actionNotAllowed(actionName: String, configure: () -> Unit) {
    try {
        MockFramework.openSession("stateless", Stateless)
        let e = assertThrows<MockFrameworkException> {
            configure()
        }
        @PowerAssert(e.message.contains(actionName))
        @PowerAssert(e.message.contains("not allowed"))
        @PowerAssert(e.message.contains("in stateless"))
    } finally {
        assertThrows<MockFrameworkException> {
            MockFramework.closeSession()
        }
    }
}

func cardinalityNotAllowed(configure: () -> Unit) {
    try {
        MockFramework.openSession("stateless", Stateless)
        let e = assertThrows<MockFrameworkException> {
            configure()
        }
        @PowerAssert(e.message.contains("not allowed"))
        @PowerAssert(e.message.contains("in stateless"))
    } finally {
        MockFramework.closeSession()
    }
}
