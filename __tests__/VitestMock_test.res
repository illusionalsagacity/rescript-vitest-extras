open Vitest
module Mock = VitestExtras.Mock
module Assert = VitestExtras.Assert
module MockExpect = VitestExtras.MockExpect

describe("Mock", _ => {
  describe("fn0 - zero-arity mock functions", _ => {
    test(
      "creates a mock function that can be called",
      t => {
        let mock = Mock.fn0()
        let f = mock->Mock.MockFn0.toFunction
        let _ = f()
        t->expect(mock)->MockExpect.toHaveBeenCalled
      },
    )

    test(
      "fnWithImpl0 creates a mock with implementation",
      t => {
        let mock = Mock.fnWithImpl0(() => 42)
        let f = mock->Mock.MockFn0.toFunction
        let result = f()
        t->expect(result)->Expect.toBe(42)
        t->expect(mock)->MockExpect.toHaveBeenCalledOnce
      },
    )

    test(
      "mockReturnValue sets the return value",
      t => {
        let mock: Mock.mockFn0<int> = Mock.fn0()
        let _ = mock->Mock.MockFn0.mockReturnValue(100)
        let f = mock->Mock.MockFn0.toFunction
        let result = f()
        t->expect(result)->Expect.toBe(100)
      },
    )

    test(
      "mockReturnValueOnce sets return value for one call",
      t => {
        let mock: Mock.mockFn0<int> = Mock.fn0()
        let _ = mock->Mock.MockFn0.mockReturnValue(1)
        let _ = mock->Mock.MockFn0.mockReturnValueOnce(99)

        let f = mock->Mock.MockFn0.toFunction
        let first = f()
        let second = f()

        t->expect(first)->Expect.toBe(99)
        t->expect(second)->Expect.toBe(1)
      },
    )

    test(
      "mock context tracks calls",
      t => {
        let mock = Mock.fn0()
        let f = mock->Mock.MockFn0.toFunction
        let _ = f()
        let _ = f()

        let ctx = mock->Mock.MockFn0.mock
        t->expect(ctx.calls->Array.length)->Expect.toBe(2)
      },
    )

    test(
      "mockClear clears call history",
      t => {
        let mock = Mock.fn0()
        let f = mock->Mock.MockFn0.toFunction
        let _ = f()
        let _ = mock->Mock.MockFn0.mockClear

        let ctx = mock->Mock.MockFn0.mock
        t->expect(ctx.calls->Array.length)->Expect.toBe(0)
      },
    )

    test(
      "mockImplementation changes behavior",
      t => {
        let mock: Mock.mockFn0<string> = Mock.fn0()
        let _ = mock->Mock.MockFn0.mockImplementation(() => "hello")
        let f = mock->Mock.MockFn0.toFunction
        let result = f()
        t->expect(result)->Expect.toBe("hello")
      },
    )

    test(
      "mockName and getMockName work",
      t => {
        let mock = Mock.fn0()
        let _ = mock->Mock.MockFn0.mockName("myMock")
        let name = mock->Mock.MockFn0.getMockName
        t->expect(name)->Expect.toBe("myMock")
      },
    )
  })

  describe("fn1 - single-argument mock functions", _ => {
    test(
      "creates a mock that accepts one argument",
      t => {
        let mock = Mock.fn1()
        let f = mock->Mock.MockFn1.toFunction
        let _ = f("test")
        t->expect(mock)->MockExpect.toHaveBeenCalled
        t->expect(mock)->MockExpect.toHaveBeenCalledWith1("test")
      },
    )

    test(
      "fnWithImpl1 creates a mock with implementation",
      t => {
        let mock = Mock.fnWithImpl1(x => x * 2)
        let f = mock->Mock.MockFn1.toFunction
        let result = f(21)
        t->expect(result)->Expect.toBe(42)
      },
    )

    test(
      "tracks call arguments in context",
      t => {
        let mock = Mock.fn1()
        let f = mock->Mock.MockFn1.toFunction
        let _ = f("first")
        let _ = f("second")

        let ctx = mock->Mock.MockFn1.mock
        t->expect(ctx.calls->Array.length)->Expect.toBe(2)

        // Check that lastCall is tracked (1-arity calls are stored as [arg] arrays)
        switch ctx.lastCall {
        | Some([arg]) => t->expect(arg)->Expect.toBe("second")
        | Some(_) => Assert.fail(~message="unexpected array length")
        | None => Assert.fail(~message="expected lastCall to be Some")
        }
      },
    )

    test(
      "toHaveBeenLastCalledWith works",
      t => {
        let mock = Mock.fn1()
        let f = mock->Mock.MockFn1.toFunction
        let _ = f(1)
        let _ = f(2)
        let _ = f(3)
        t->expect(mock)->MockExpect.toHaveBeenLastCalledWith1(3)
      },
    )

    test(
      "toHaveBeenNthCalledWith works",
      t => {
        let mock = Mock.fn1()
        let f = mock->Mock.MockFn1.toFunction
        let _ = f("a")
        let _ = f("b")
        let _ = f("c")
        t->expect(mock)->MockExpect.toHaveBeenNthCalledWith1(2, "b")
      },
    )
  })

  describe("fn2 - two-argument mock functions", _ => {
    test(
      "creates a mock that accepts two arguments",
      t => {
        let mock = Mock.fn2()
        let f = mock->Mock.MockFn2.toFunction
        let _ = f("hello", 42)
        t->expect(mock)->MockExpect.toHaveBeenCalledWith2("hello", 42)
      },
    )

    test(
      "fnWithImpl2 creates a mock with implementation",
      t => {
        let mock = Mock.fnWithImpl2((a, b) => a + b)
        let f = mock->Mock.MockFn2.toFunction
        let result = f(10, 32)
        t->expect(result)->Expect.toBe(42)
      },
    )

    test(
      "tracks call arguments in context",
      t => {
        let mock = Mock.fn2()
        let f = mock->Mock.MockFn2.toFunction
        let _ = f("x", 1)
        let _ = f("y", 2)

        let ctx = mock->Mock.MockFn2.mock
        t->expect(ctx.calls->Array.length)->Expect.toBe(2)
      },
    )

    test(
      "mockName and getMockName work",
      t => {
        let mock = Mock.fn2()
        let _ = mock->Mock.MockFn2.mockName("mock2")
        t->expect(mock->Mock.MockFn2.getMockName)->Expect.toBe("mock2")
      },
    )

    test(
      "mockClear clears call history",
      t => {
        let mock = Mock.fn2()
        let f = mock->Mock.MockFn2.toFunction
        let _ = f("a", 1)
        let _ = mock->Mock.MockFn2.mockClear
        let ctx = mock->Mock.MockFn2.mock
        t->expect(ctx.calls->Array.length)->Expect.toBe(0)
      },
    )

    test(
      "mockReset resets the mock",
      t => {
        let mock: Mock.mockFn2<string, int, int> = Mock.fn2()
        let _ = mock->Mock.MockFn2.mockReturnValue(42)
        let _ = mock->Mock.MockFn2.mockReset
        // After reset, mock returns undefined
        t->expect(mock)->MockExpect.not->MockExpect.toHaveBeenCalled
      },
    )

    test(
      "mockImplementation changes behavior",
      t => {
        let mock: Mock.mockFn2<int, int, int> = Mock.fn2()
        let _ = mock->Mock.MockFn2.mockImplementation((a, b) => a * b)
        let f = mock->Mock.MockFn2.toFunction
        let result = f(6, 7)
        t->expect(result)->Expect.toBe(42)
      },
    )

    test(
      "mockImplementationOnce sets implementation for one call",
      t => {
        let mock: Mock.mockFn2<int, int, int> = Mock.fn2()
        let _ = mock->Mock.MockFn2.mockReturnValue(0)
        let _ = mock->Mock.MockFn2.mockImplementationOnce((a, b) => a + b)
        let f = mock->Mock.MockFn2.toFunction
        let first = f(1, 2)
        let second = f(1, 2)
        t->expect(first)->Expect.toBe(3)
        t->expect(second)->Expect.toBe(0)
      },
    )

    test(
      "mockReturnValue sets return value",
      t => {
        let mock: Mock.mockFn2<string, int, string> = Mock.fn2()
        let _ = mock->Mock.MockFn2.mockReturnValue("result")
        let f = mock->Mock.MockFn2.toFunction
        t->expect(f("a", 1))->Expect.toBe("result")
      },
    )

    test(
      "mockReturnValueOnce sets return value for one call",
      t => {
        let mock: Mock.mockFn2<int, int, int> = Mock.fn2()
        let _ = mock->Mock.MockFn2.mockReturnValue(0)
        let _ = mock->Mock.MockFn2.mockReturnValueOnce(99)
        let f = mock->Mock.MockFn2.toFunction
        t->expect(f(1, 2))->Expect.toBe(99)
        t->expect(f(1, 2))->Expect.toBe(0)
      },
    )

    test(
      "getMockImplementation returns implementation",
      _ => {
        let impl = (a, b) => a + b
        let mock = Mock.fnWithImpl2(impl)
        let retrieved = mock->Mock.MockFn2.getMockImplementation
        Assert.Option.isSome(retrieved)
      },
    )
  })

  describe("fn3 - three-argument mock functions", _ => {
    test(
      "fn3 creates a mock without implementation",
      t => {
        let mock = Mock.fn3()
        let f = mock->Mock.MockFn3.toFunction
        let _ = f("a", "b", "c")
        t->expect(mock)->MockExpect.toHaveBeenCalled
      },
    )

    test(
      "creates and calls a 3-argument mock",
      t => {
        let mock = Mock.fnWithImpl3((a, b, c) => a ++ b ++ c)
        let f = mock->Mock.MockFn3.toFunction
        let result = f("a", "b", "c")
        t->expect(result)->Expect.toBe("abc")
        t->expect(mock)->MockExpect.toHaveBeenCalledWith3("a", "b", "c")
      },
    )

    test(
      "tracks call arguments in context",
      t => {
        let mock = Mock.fn3()
        let f = mock->Mock.MockFn3.toFunction
        let _ = f(1, 2, 3)
        let _ = f(4, 5, 6)
        let ctx = mock->Mock.MockFn3.mock
        t->expect(ctx.calls->Array.length)->Expect.toBe(2)
      },
    )

    test(
      "mockName and getMockName work",
      t => {
        let mock = Mock.fn3()
        let _ = mock->Mock.MockFn3.mockName("mock3")
        t->expect(mock->Mock.MockFn3.getMockName)->Expect.toBe("mock3")
      },
    )

    test(
      "mockClear clears call history",
      t => {
        let mock = Mock.fn3()
        let f = mock->Mock.MockFn3.toFunction
        let _ = f("a", "b", "c")
        let _ = mock->Mock.MockFn3.mockClear
        let ctx = mock->Mock.MockFn3.mock
        t->expect(ctx.calls->Array.length)->Expect.toBe(0)
      },
    )

    test(
      "mockReset resets the mock",
      t => {
        let mock: Mock.mockFn3<int, int, int, int> = Mock.fn3()
        let _ = mock->Mock.MockFn3.mockReturnValue(42)
        let _ = mock->Mock.MockFn3.mockReset
        t->expect(mock)->MockExpect.not->MockExpect.toHaveBeenCalled
      },
    )

    test(
      "mockImplementation changes behavior",
      t => {
        let mock: Mock.mockFn3<int, int, int, int> = Mock.fn3()
        let _ = mock->Mock.MockFn3.mockImplementation((a, b, c) => a + b + c)
        let f = mock->Mock.MockFn3.toFunction
        t->expect(f(1, 2, 3))->Expect.toBe(6)
      },
    )

    test(
      "mockImplementationOnce sets implementation for one call",
      t => {
        let mock: Mock.mockFn3<int, int, int, int> = Mock.fn3()
        let _ = mock->Mock.MockFn3.mockReturnValue(0)
        let _ = mock->Mock.MockFn3.mockImplementationOnce((a, b, c) => a * b * c)
        let f = mock->Mock.MockFn3.toFunction
        t->expect(f(2, 3, 4))->Expect.toBe(24)
        t->expect(f(2, 3, 4))->Expect.toBe(0)
      },
    )

    test(
      "mockReturnValue sets return value",
      t => {
        let mock: Mock.mockFn3<int, int, int, string> = Mock.fn3()
        let _ = mock->Mock.MockFn3.mockReturnValue("result")
        let f = mock->Mock.MockFn3.toFunction
        t->expect(f(1, 2, 3))->Expect.toBe("result")
      },
    )

    test(
      "mockReturnValueOnce sets return value for one call",
      t => {
        let mock: Mock.mockFn3<int, int, int, int> = Mock.fn3()
        let _ = mock->Mock.MockFn3.mockReturnValue(0)
        let _ = mock->Mock.MockFn3.mockReturnValueOnce(99)
        let f = mock->Mock.MockFn3.toFunction
        t->expect(f(1, 2, 3))->Expect.toBe(99)
        t->expect(f(1, 2, 3))->Expect.toBe(0)
      },
    )

    test(
      "getMockImplementation returns implementation",
      _ => {
        let mock = Mock.fnWithImpl3((a, b, c) => a + b + c)
        Assert.Option.isSome(mock->Mock.MockFn3.getMockImplementation)
      },
    )
  })

  describe("fn4 - four-argument mock functions", _ => {
    test(
      "fn4 creates a mock without implementation",
      t => {
        let mock = Mock.fn4()
        let f = mock->Mock.MockFn4.toFunction
        let _ = f(1, 2, 3, 4)
        t->expect(mock)->MockExpect.toHaveBeenCalled
      },
    )

    test(
      "creates and calls a 4-argument mock",
      t => {
        let mock = Mock.fnWithImpl4((a, b, c, d) => a + b + c + d)
        let f = mock->Mock.MockFn4.toFunction
        let result = f(1, 2, 3, 4)
        t->expect(result)->Expect.toBe(10)
        t->expect(mock)->MockExpect.toHaveBeenCalledWith4(1, 2, 3, 4)
      },
    )

    test(
      "tracks call arguments in context",
      t => {
        let mock = Mock.fn4()
        let f = mock->Mock.MockFn4.toFunction
        let _ = f(1, 2, 3, 4)
        let _ = f(5, 6, 7, 8)
        let ctx = mock->Mock.MockFn4.mock
        t->expect(ctx.calls->Array.length)->Expect.toBe(2)
      },
    )

    test(
      "mockName and getMockName work",
      t => {
        let mock = Mock.fn4()
        let _ = mock->Mock.MockFn4.mockName("mock4")
        t->expect(mock->Mock.MockFn4.getMockName)->Expect.toBe("mock4")
      },
    )

    test(
      "mockClear clears call history",
      t => {
        let mock = Mock.fn4()
        let f = mock->Mock.MockFn4.toFunction
        let _ = f(1, 2, 3, 4)
        let _ = mock->Mock.MockFn4.mockClear
        let ctx = mock->Mock.MockFn4.mock
        t->expect(ctx.calls->Array.length)->Expect.toBe(0)
      },
    )

    test(
      "mockReset resets the mock",
      t => {
        let mock: Mock.mockFn4<int, int, int, int, int> = Mock.fn4()
        let _ = mock->Mock.MockFn4.mockReturnValue(42)
        let _ = mock->Mock.MockFn4.mockReset
        t->expect(mock)->MockExpect.not->MockExpect.toHaveBeenCalled
      },
    )

    test(
      "mockImplementation changes behavior",
      t => {
        let mock: Mock.mockFn4<int, int, int, int, int> = Mock.fn4()
        let _ = mock->Mock.MockFn4.mockImplementation((a, b, c, d) => a + b + c + d)
        let f = mock->Mock.MockFn4.toFunction
        t->expect(f(1, 2, 3, 4))->Expect.toBe(10)
      },
    )

    test(
      "mockImplementationOnce sets implementation for one call",
      t => {
        let mock: Mock.mockFn4<int, int, int, int, int> = Mock.fn4()
        let _ = mock->Mock.MockFn4.mockReturnValue(0)
        let _ = mock->Mock.MockFn4.mockImplementationOnce((a, b, c, d) => a * b * c * d)
        let f = mock->Mock.MockFn4.toFunction
        t->expect(f(1, 2, 3, 4))->Expect.toBe(24)
        t->expect(f(1, 2, 3, 4))->Expect.toBe(0)
      },
    )

    test(
      "mockReturnValue sets return value",
      t => {
        let mock: Mock.mockFn4<int, int, int, int, string> = Mock.fn4()
        let _ = mock->Mock.MockFn4.mockReturnValue("result")
        let f = mock->Mock.MockFn4.toFunction
        t->expect(f(1, 2, 3, 4))->Expect.toBe("result")
      },
    )

    test(
      "mockReturnValueOnce sets return value for one call",
      t => {
        let mock: Mock.mockFn4<int, int, int, int, int> = Mock.fn4()
        let _ = mock->Mock.MockFn4.mockReturnValue(0)
        let _ = mock->Mock.MockFn4.mockReturnValueOnce(99)
        let f = mock->Mock.MockFn4.toFunction
        t->expect(f(1, 2, 3, 4))->Expect.toBe(99)
        t->expect(f(1, 2, 3, 4))->Expect.toBe(0)
      },
    )

    test(
      "getMockImplementation returns implementation",
      _ => {
        let mock = Mock.fnWithImpl4((a, b, c, d) => a + b + c + d)
        Assert.Option.isSome(mock->Mock.MockFn4.getMockImplementation)
      },
    )
  })

  describe("fn5 - five-argument mock functions", _ => {
    test(
      "fn5 creates a mock without implementation",
      t => {
        let mock = Mock.fn5()
        let f = mock->Mock.MockFn5.toFunction
        let _ = f(1, 2, 3, 4, 5)
        t->expect(mock)->MockExpect.toHaveBeenCalled
      },
    )

    test(
      "creates and calls a 5-argument mock",
      t => {
        let mock = Mock.fnWithImpl5((a, b, c, d, e) => a + b + c + d + e)
        let f = mock->Mock.MockFn5.toFunction
        let result = f(1, 2, 3, 4, 5)
        t->expect(result)->Expect.toBe(15)
        t->expect(mock)->MockExpect.toHaveBeenCalledWith5(1, 2, 3, 4, 5)
      },
    )

    test(
      "tracks call arguments in context",
      t => {
        let mock = Mock.fn5()
        let f = mock->Mock.MockFn5.toFunction
        let _ = f(1, 2, 3, 4, 5)
        let _ = f(6, 7, 8, 9, 10)
        let ctx = mock->Mock.MockFn5.mock
        t->expect(ctx.calls->Array.length)->Expect.toBe(2)
      },
    )

    test(
      "mockName and getMockName work",
      t => {
        let mock = Mock.fn5()
        let _ = mock->Mock.MockFn5.mockName("mock5")
        t->expect(mock->Mock.MockFn5.getMockName)->Expect.toBe("mock5")
      },
    )

    test(
      "mockClear clears call history",
      t => {
        let mock = Mock.fn5()
        let f = mock->Mock.MockFn5.toFunction
        let _ = f(1, 2, 3, 4, 5)
        let _ = mock->Mock.MockFn5.mockClear
        let ctx = mock->Mock.MockFn5.mock
        t->expect(ctx.calls->Array.length)->Expect.toBe(0)
      },
    )

    test(
      "mockReset resets the mock",
      t => {
        let mock: Mock.mockFn5<int, int, int, int, int, int> = Mock.fn5()
        let _ = mock->Mock.MockFn5.mockReturnValue(42)
        let _ = mock->Mock.MockFn5.mockReset
        t->expect(mock)->MockExpect.not->MockExpect.toHaveBeenCalled
      },
    )

    test(
      "mockImplementation changes behavior",
      t => {
        let mock: Mock.mockFn5<int, int, int, int, int, int> = Mock.fn5()
        let _ = mock->Mock.MockFn5.mockImplementation((a, b, c, d, e) => a + b + c + d + e)
        let f = mock->Mock.MockFn5.toFunction
        t->expect(f(1, 2, 3, 4, 5))->Expect.toBe(15)
      },
    )

    test(
      "mockImplementationOnce sets implementation for one call",
      t => {
        let mock: Mock.mockFn5<int, int, int, int, int, int> = Mock.fn5()
        let _ = mock->Mock.MockFn5.mockReturnValue(0)
        let _ = mock->Mock.MockFn5.mockImplementationOnce((a, b, c, d, e) => a * b * c * d * e)
        let f = mock->Mock.MockFn5.toFunction
        t->expect(f(1, 2, 3, 4, 5))->Expect.toBe(120)
        t->expect(f(1, 2, 3, 4, 5))->Expect.toBe(0)
      },
    )

    test(
      "mockReturnValue sets return value",
      t => {
        let mock: Mock.mockFn5<int, int, int, int, int, string> = Mock.fn5()
        let _ = mock->Mock.MockFn5.mockReturnValue("result")
        let f = mock->Mock.MockFn5.toFunction
        t->expect(f(1, 2, 3, 4, 5))->Expect.toBe("result")
      },
    )

    test(
      "mockReturnValueOnce sets return value for one call",
      t => {
        let mock: Mock.mockFn5<int, int, int, int, int, int> = Mock.fn5()
        let _ = mock->Mock.MockFn5.mockReturnValue(0)
        let _ = mock->Mock.MockFn5.mockReturnValueOnce(99)
        let f = mock->Mock.MockFn5.toFunction
        t->expect(f(1, 2, 3, 4, 5))->Expect.toBe(99)
        t->expect(f(1, 2, 3, 4, 5))->Expect.toBe(0)
      },
    )

    test(
      "getMockImplementation returns implementation",
      _ => {
        let mock = Mock.fnWithImpl5((a, b, c, d, e) => a + b + c + d + e)
        Assert.Option.isSome(mock->Mock.MockFn5.getMockImplementation)
      },
    )
  })

  describe("return value matchers", _ => {
    test(
      "toHaveReturned works",
      t => {
        let mock = Mock.fnWithImpl0(() => 42)
        let f = mock->Mock.MockFn0.toFunction
        let _ = f()
        t->expect(mock)->MockExpect.toHaveReturned
      },
    )

    test(
      "toHaveReturnedTimes works",
      t => {
        let mock = Mock.fnWithImpl0(() => 42)
        let f = mock->Mock.MockFn0.toFunction
        let _ = f()
        let _ = f()
        let _ = f()
        t->expect(mock)->MockExpect.toHaveReturnedTimes(3)
      },
    )

    test(
      "toHaveReturnedWith works",
      t => {
        let mock = Mock.fnWithImpl1(x => x * 2)
        let f = mock->Mock.MockFn1.toFunction
        let _ = f(21)
        t->expect(mock)->MockExpect.toHaveReturnedWith(42)
      },
    )

    test(
      "toHaveLastReturnedWith works",
      t => {
        let mock = Mock.fnWithImpl1(x => x)
        let f = mock->Mock.MockFn1.toFunction
        let _ = f(1)
        let _ = f(2)
        let _ = f(3)
        t->expect(mock)->MockExpect.toHaveLastReturnedWith(3)
      },
    )

    test(
      "toHaveNthReturnedWith works",
      t => {
        let mock = Mock.fnWithImpl1(x => x * 10)
        let f = mock->Mock.MockFn1.toFunction
        let _ = f(1)
        let _ = f(2)
        let _ = f(3)
        t->expect(mock)->MockExpect.toHaveNthReturnedWith(2, 20)
      },
    )
  })

  describe("mock results tracking", _ => {
    test(
      "tracks return results",
      t => {
        let mock = Mock.fnWithImpl0(() => 42)
        let f = mock->Mock.MockFn0.toFunction
        let _ = f()

        let ctx = mock->Mock.MockFn0.mock
        t->expect(ctx.results->Array.length)->Expect.toBe(1)

        switch ctx.results[0] {
        | Some({type_: #return, value}) => t->expect(value)->Expect.toBe(42)
        | _ => Assert.fail(~message="expected return result")
        }
      },
    )
  })

  describe("async mock functions", _ => {
    testAsync(
      "mockResolvedValue works for fn0",
      async t => {
        let mock: Mock.mockFn0<promise<int>> = Mock.fn0()
        let _ = mock->Mock.MockFn0.mockResolvedValue(42)

        let f = mock->Mock.MockFn0.toFunction
        let result = await f()
        t->expect(result)->Expect.toBe(42)
      },
    )

    testAsync(
      "mockResolvedValueOnce works for fn0",
      async t => {
        let mock: Mock.mockFn0<promise<string>> = Mock.fn0()
        let _ = mock->Mock.MockFn0.mockResolvedValue("default")
        let _ = mock->Mock.MockFn0.mockResolvedValueOnce("first")

        let f = mock->Mock.MockFn0.toFunction
        let first = await f()
        let second = await f()

        t->expect(first)->Expect.toBe("first")
        t->expect(second)->Expect.toBe("default")
      },
    )

    testAsync(
      "mockResolvedValue works for fn1",
      async t => {
        let mock: Mock.mockFn1<int, promise<int>> = Mock.fn1()
        let _ = mock->Mock.MockFn1.mockResolvedValue(42)
        let f = mock->Mock.MockFn1.toFunction
        let result = await f(1)
        t->expect(result)->Expect.toBe(42)
      },
    )

    testAsync(
      "mockResolvedValueOnce works for fn1",
      async t => {
        let mock: Mock.mockFn1<int, promise<int>> = Mock.fn1()
        let _ = mock->Mock.MockFn1.mockResolvedValue(0)
        let _ = mock->Mock.MockFn1.mockResolvedValueOnce(99)
        let f = mock->Mock.MockFn1.toFunction
        t->expect(await f(1))->Expect.toBe(99)
        t->expect(await f(1))->Expect.toBe(0)
      },
    )

    testAsync(
      "mockResolvedValue works for fn2",
      async t => {
        let mock: Mock.mockFn2<int, int, promise<int>> = Mock.fn2()
        let _ = mock->Mock.MockFn2.mockResolvedValue(42)
        let f = mock->Mock.MockFn2.toFunction
        let result = await f(1, 2)
        t->expect(result)->Expect.toBe(42)
      },
    )

    testAsync(
      "mockResolvedValueOnce works for fn2",
      async t => {
        let mock: Mock.mockFn2<int, int, promise<int>> = Mock.fn2()
        let _ = mock->Mock.MockFn2.mockResolvedValue(0)
        let _ = mock->Mock.MockFn2.mockResolvedValueOnce(99)
        let f = mock->Mock.MockFn2.toFunction
        t->expect(await f(1, 2))->Expect.toBe(99)
        t->expect(await f(1, 2))->Expect.toBe(0)
      },
    )

    testAsync(
      "mockResolvedValue works for fn3",
      async t => {
        let mock: Mock.mockFn3<int, int, int, promise<int>> = Mock.fn3()
        let _ = mock->Mock.MockFn3.mockResolvedValue(42)
        let f = mock->Mock.MockFn3.toFunction
        let result = await f(1, 2, 3)
        t->expect(result)->Expect.toBe(42)
      },
    )

    testAsync(
      "mockResolvedValueOnce works for fn3",
      async t => {
        let mock: Mock.mockFn3<int, int, int, promise<int>> = Mock.fn3()
        let _ = mock->Mock.MockFn3.mockResolvedValue(0)
        let _ = mock->Mock.MockFn3.mockResolvedValueOnce(99)
        let f = mock->Mock.MockFn3.toFunction
        t->expect(await f(1, 2, 3))->Expect.toBe(99)
        t->expect(await f(1, 2, 3))->Expect.toBe(0)
      },
    )

    testAsync(
      "mockResolvedValue works for fn4",
      async t => {
        let mock: Mock.mockFn4<int, int, int, int, promise<int>> = Mock.fn4()
        let _ = mock->Mock.MockFn4.mockResolvedValue(42)
        let f = mock->Mock.MockFn4.toFunction
        let result = await f(1, 2, 3, 4)
        t->expect(result)->Expect.toBe(42)
      },
    )

    testAsync(
      "mockResolvedValueOnce works for fn4",
      async t => {
        let mock: Mock.mockFn4<int, int, int, int, promise<int>> = Mock.fn4()
        let _ = mock->Mock.MockFn4.mockResolvedValue(0)
        let _ = mock->Mock.MockFn4.mockResolvedValueOnce(99)
        let f = mock->Mock.MockFn4.toFunction
        t->expect(await f(1, 2, 3, 4))->Expect.toBe(99)
        t->expect(await f(1, 2, 3, 4))->Expect.toBe(0)
      },
    )

    testAsync(
      "mockResolvedValue works for fn5",
      async t => {
        let mock: Mock.mockFn5<int, int, int, int, int, promise<int>> = Mock.fn5()
        let _ = mock->Mock.MockFn5.mockResolvedValue(42)
        let f = mock->Mock.MockFn5.toFunction
        let result = await f(1, 2, 3, 4, 5)
        t->expect(result)->Expect.toBe(42)
      },
    )

    testAsync(
      "mockResolvedValueOnce works for fn5",
      async t => {
        let mock: Mock.mockFn5<int, int, int, int, int, promise<int>> = Mock.fn5()
        let _ = mock->Mock.MockFn5.mockResolvedValue(0)
        let _ = mock->Mock.MockFn5.mockResolvedValueOnce(99)
        let f = mock->Mock.MockFn5.toFunction
        t->expect(await f(1, 2, 3, 4, 5))->Expect.toBe(99)
        t->expect(await f(1, 2, 3, 4, 5))->Expect.toBe(0)
      },
    )
  })

  describe("mockRestore", _ => {
    test(
      "mockRestore for fn0",
      _ => {
        let mock = Mock.fn0()
        // Just verify it doesn't throw
        mock->Mock.MockFn0.mockRestore
      },
    )

    test(
      "mockRestore for fn1",
      _ => {
        let mock = Mock.fn1()
        mock->Mock.MockFn1.mockRestore
      },
    )

    test(
      "mockRestore for fn2",
      _ => {
        let mock = Mock.fn2()
        mock->Mock.MockFn2.mockRestore
      },
    )

    test(
      "mockRestore for fn3",
      _ => {
        let mock = Mock.fn3()
        mock->Mock.MockFn3.mockRestore
      },
    )

    test(
      "mockRestore for fn4",
      _ => {
        let mock = Mock.fn4()
        mock->Mock.MockFn4.mockRestore
      },
    )

    test(
      "mockRestore for fn5",
      _ => {
        let mock = Mock.fn5()
        mock->Mock.MockFn5.mockRestore
      },
    )
  })

  describe("mockReturnThis", _ => {
    test(
      "mockReturnThis for fn0",
      t => {
        let mock = Mock.fn0()
        let returned = mock->Mock.MockFn0.mockReturnThis
        // mockReturnThis returns the mock itself for chaining
        t->expect(Mock.isMockFunction(returned))->Expect.toBe(true)
      },
    )

    test(
      "mockReturnThis for fn1",
      t => {
        let mock = Mock.fn1()
        let returned = mock->Mock.MockFn1.mockReturnThis
        t->expect(Mock.isMockFunction(returned))->Expect.toBe(true)
      },
    )

    test(
      "mockReturnThis for fn2",
      t => {
        let mock = Mock.fn2()
        let returned = mock->Mock.MockFn2.mockReturnThis
        t->expect(Mock.isMockFunction(returned))->Expect.toBe(true)
      },
    )

    test(
      "mockReturnThis for fn3",
      t => {
        let mock = Mock.fn3()
        let returned = mock->Mock.MockFn3.mockReturnThis
        t->expect(Mock.isMockFunction(returned))->Expect.toBe(true)
      },
    )

    test(
      "mockReturnThis for fn4",
      t => {
        let mock = Mock.fn4()
        let returned = mock->Mock.MockFn4.mockReturnThis
        t->expect(Mock.isMockFunction(returned))->Expect.toBe(true)
      },
    )

    test(
      "mockReturnThis for fn5",
      t => {
        let mock = Mock.fn5()
        let returned = mock->Mock.MockFn5.mockReturnThis
        t->expect(Mock.isMockFunction(returned))->Expect.toBe(true)
      },
    )
  })

  describe("negation with not", _ => {
    test(
      "not.toHaveBeenCalled works",
      t => {
        let mock = Mock.fn0()
        t->expect(mock)->MockExpect.not->MockExpect.toHaveBeenCalled
      },
    )

    test(
      "not.toHaveBeenCalledWith works",
      t => {
        let mock = Mock.fn1()
        let f = mock->Mock.MockFn1.toFunction
        let _ = f("hello")
        t
        ->expect(mock)
        ->MockExpect.not
        ->MockExpect.toHaveBeenCalledWith1("goodbye")
      },
    )
  })

  describe("toFunction conversion", _ => {
    test(
      "can convert mock to regular function",
      t => {
        let mock = Mock.fnWithImpl1(x => x * 2)
        let fn = mock->Mock.MockFn1.toFunction

        // Use the function normally
        let result = fn(21)
        t->expect(result)->Expect.toBe(42)

        // Mock still tracks the call
        t->expect(mock)->MockExpect.toHaveBeenCalledWith1(21)
      },
    )
  })

  describe("global mock utilities", _ => {
    test(
      "isMockFunction returns true for mocks",
      t => {
        let mock = Mock.fn0()
        t->expect(Mock.isMockFunction(mock))->Expect.toBe(true)
      },
    )

    test(
      "isMockFunction returns false for regular functions",
      t => {
        let fn = () => 42
        t->expect(Mock.isMockFunction(fn))->Expect.toBe(false)
      },
    )

    test(
      "clearAllMocks clears all mock call history",
      t => {
        let mock1 = Mock.fn0()
        let mock2 = Mock.fn0()
        let f1 = mock1->Mock.MockFn0.toFunction
        let f2 = mock2->Mock.MockFn0.toFunction
        let _ = f1()
        let _ = f2()

        let _ = Mock.clearAllMocks()

        let ctx1 = mock1->Mock.MockFn0.mock
        let ctx2 = mock2->Mock.MockFn0.mock
        t->expect(ctx1.calls->Array.length)->Expect.toBe(0)
        t->expect(ctx2.calls->Array.length)->Expect.toBe(0)
      },
    )

    test(
      "resetAllMocks resets all mocks",
      t => {
        let mock: Mock.mockFn0<int> = Mock.fn0()
        let _ = mock->Mock.MockFn0.mockReturnValue(42)
        let f = mock->Mock.MockFn0.toFunction
        let _ = f()

        let _ = Mock.resetAllMocks()

        // After reset, call history is cleared and implementation is reset
        let ctx = mock->Mock.MockFn0.mock
        t->expect(ctx.calls->Array.length)->Expect.toBe(0)
      },
    )

    test(
      "restoreAllMocks restores all mocks",
      _ => {
        // Just verify it doesn't throw
        let _ = Mock.restoreAllMocks()
      },
    )
  })

  describe("call order matchers", _ => {
    test(
      "toHaveBeenCalledBefore works",
      t => {
        let mock1 = Mock.fn0()
        let mock2 = Mock.fn0()

        let f1 = mock1->Mock.MockFn0.toFunction
        let f2 = mock2->Mock.MockFn0.toFunction
        let _ = f1()
        let _ = f2()

        t
        ->expect(mock1)
        ->MockExpect.toHaveBeenCalledBefore(mock2->MockExpect.toAnyMockInstance)
      },
    )

    test(
      "toHaveBeenCalledAfter works",
      t => {
        let mock1 = Mock.fn0()
        let mock2 = Mock.fn0()

        let f1 = mock1->Mock.MockFn0.toFunction
        let f2 = mock2->Mock.MockFn0.toFunction
        let _ = f1()
        let _ = f2()

        t
        ->expect(mock2)
        ->MockExpect.toHaveBeenCalledAfter(mock1->MockExpect.toAnyMockInstance)
      },
    )
  })

  describe("toHaveBeenCalledExactlyOnceWith", _ => {
    test(
      "works with 1-arity mock",
      t => {
        let mock = Mock.fn1()
        let f = mock->Mock.MockFn1.toFunction
        let _ = f("hello")
        t->expect(mock)->MockExpect.toHaveBeenCalledExactlyOnceWith1("hello")
      },
    )

    test(
      "works with 2-arity mock",
      t => {
        let mock = Mock.fn2()
        let f = mock->Mock.MockFn2.toFunction
        let _ = f(1, 2)
        t->expect(mock)->MockExpect.toHaveBeenCalledExactlyOnceWith2(1, 2)
      },
    )
  })

  describe("chaining mock methods", _ => {
    test(
      "methods can be chained",
      t => {
        let mock =
          Mock.fn0()
          ->Mock.MockFn0.mockName("chainedMock")
          ->Mock.MockFn0.mockReturnValue(42)

        let f = mock->Mock.MockFn0.toFunction
        let result = f()
        t->expect(result)->Expect.toBe(42)
        t->expect(mock->Mock.MockFn0.getMockName)->Expect.toBe("chainedMock")
      },
    )
  })
})
