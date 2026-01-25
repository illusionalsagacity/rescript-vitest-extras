open Vitest
module A = VitestAssert

describe("VitestMock", _ => {
  describe("fn0 - zero-arity mock functions", _ => {
    test("creates a mock function that can be called", t => {
      let mock = VitestMock.fn0()
      let f = mock->VitestMock.MockFn0.toFunction
      let _ = f()
      t->expect(mock)->VitestMockExpect.toHaveBeenCalled
    })

    test("fnWithImpl0 creates a mock with implementation", t => {
      let mock = VitestMock.fnWithImpl0(() => 42)
      let f = mock->VitestMock.MockFn0.toFunction
      let result = f()
      t->expect(result)->Expect.toBe(42)
      t->expect(mock)->VitestMockExpect.toHaveBeenCalledOnce
    })

    test("mockReturnValue sets the return value", t => {
      let mock: VitestMock.mockFn0<int> = VitestMock.fn0()
      let _ = mock->VitestMock.MockFn0.mockReturnValue(100)
      let f = mock->VitestMock.MockFn0.toFunction
      let result = f()
      t->expect(result)->Expect.toBe(100)
    })

    test("mockReturnValueOnce sets return value for one call", t => {
      let mock: VitestMock.mockFn0<int> = VitestMock.fn0()
      let _ = mock->VitestMock.MockFn0.mockReturnValue(1)
      let _ = mock->VitestMock.MockFn0.mockReturnValueOnce(99)

      let f = mock->VitestMock.MockFn0.toFunction
      let first = f()
      let second = f()

      t->expect(first)->Expect.toBe(99)
      t->expect(second)->Expect.toBe(1)
    })

    test("mock context tracks calls", t => {
      let mock = VitestMock.fn0()
      let f = mock->VitestMock.MockFn0.toFunction
      let _ = f()
      let _ = f()

      let ctx = mock->VitestMock.MockFn0.mock
      t->expect(ctx.calls->Array.length)->Expect.toBe(2)
    })

    test("mockClear clears call history", t => {
      let mock = VitestMock.fn0()
      let f = mock->VitestMock.MockFn0.toFunction
      let _ = f()
      let _ = mock->VitestMock.MockFn0.mockClear

      let ctx = mock->VitestMock.MockFn0.mock
      t->expect(ctx.calls->Array.length)->Expect.toBe(0)
    })

    test("mockImplementation changes behavior", t => {
      let mock: VitestMock.mockFn0<string> = VitestMock.fn0()
      let _ = mock->VitestMock.MockFn0.mockImplementation(() => "hello")
      let f = mock->VitestMock.MockFn0.toFunction
      let result = f()
      t->expect(result)->Expect.toBe("hello")
    })

    test("mockName and getMockName work", t => {
      let mock = VitestMock.fn0()
      let _ = mock->VitestMock.MockFn0.mockName("myMock")
      let name = mock->VitestMock.MockFn0.getMockName
      t->expect(name)->Expect.toBe("myMock")
    })
  })

  describe("fn1 - single-argument mock functions", _ => {
    test("creates a mock that accepts one argument", t => {
      let mock = VitestMock.fn1()
      let f = mock->VitestMock.MockFn1.toFunction
      let _ = f("test")
      t->expect(mock)->VitestMockExpect.toHaveBeenCalled
      t->expect(mock)->VitestMockExpect.toHaveBeenCalledWith1("test")
    })

    test("fnWithImpl1 creates a mock with implementation", t => {
      let mock = VitestMock.fnWithImpl1(x => x * 2)
      let f = mock->VitestMock.MockFn1.toFunction
      let result = f(21)
      t->expect(result)->Expect.toBe(42)
    })

    test("tracks call arguments in context", t => {
      let mock = VitestMock.fn1()
      let f = mock->VitestMock.MockFn1.toFunction
      let _ = f("first")
      let _ = f("second")

      let ctx = mock->VitestMock.MockFn1.mock
      t->expect(ctx.calls->Array.length)->Expect.toBe(2)

      // Check that lastCall is tracked (1-arity calls are stored as [arg] arrays)
      switch ctx.lastCall {
      | Some([arg]) => t->expect(arg)->Expect.toBe("second")
      | Some(_) => A.fail(~message="unexpected array length")
      | None => A.fail(~message="expected lastCall to be Some")
      }
    })

    test("toHaveBeenLastCalledWith works", t => {
      let mock = VitestMock.fn1()
      let f = mock->VitestMock.MockFn1.toFunction
      let _ = f(1)
      let _ = f(2)
      let _ = f(3)
      t->expect(mock)->VitestMockExpect.toHaveBeenLastCalledWith1(3)
    })

    test("toHaveBeenNthCalledWith works", t => {
      let mock = VitestMock.fn1()
      let f = mock->VitestMock.MockFn1.toFunction
      let _ = f("a")
      let _ = f("b")
      let _ = f("c")
      t->expect(mock)->VitestMockExpect.toHaveBeenNthCalledWith1(2, "b")
    })
  })

  describe("fn2 - two-argument mock functions", _ => {
    test("creates a mock that accepts two arguments", t => {
      let mock = VitestMock.fn2()
      let f = mock->VitestMock.MockFn2.toFunction
      let _ = f("hello", 42)
      t->expect(mock)->VitestMockExpect.toHaveBeenCalledWith2("hello", 42)
    })

    test("fnWithImpl2 creates a mock with implementation", t => {
      let mock = VitestMock.fnWithImpl2((a, b) => a + b)
      let f = mock->VitestMock.MockFn2.toFunction
      let result = f(10, 32)
      t->expect(result)->Expect.toBe(42)
    })

    test("tracks call arguments in context", t => {
      let mock = VitestMock.fn2()
      let f = mock->VitestMock.MockFn2.toFunction
      let _ = f("x", 1)
      let _ = f("y", 2)

      let ctx = mock->VitestMock.MockFn2.mock
      t->expect(ctx.calls->Array.length)->Expect.toBe(2)
    })

    test("mockName and getMockName work", t => {
      let mock = VitestMock.fn2()
      let _ = mock->VitestMock.MockFn2.mockName("mock2")
      t->expect(mock->VitestMock.MockFn2.getMockName)->Expect.toBe("mock2")
    })

    test("mockClear clears call history", t => {
      let mock = VitestMock.fn2()
      let f = mock->VitestMock.MockFn2.toFunction
      let _ = f("a", 1)
      let _ = mock->VitestMock.MockFn2.mockClear
      let ctx = mock->VitestMock.MockFn2.mock
      t->expect(ctx.calls->Array.length)->Expect.toBe(0)
    })

    test("mockReset resets the mock", t => {
      let mock: VitestMock.mockFn2<string, int, int> = VitestMock.fn2()
      let _ = mock->VitestMock.MockFn2.mockReturnValue(42)
      let _ = mock->VitestMock.MockFn2.mockReset
      // After reset, mock returns undefined
      t->expect(mock)->VitestMockExpect.not->VitestMockExpect.toHaveBeenCalled
    })

    test("mockImplementation changes behavior", t => {
      let mock: VitestMock.mockFn2<int, int, int> = VitestMock.fn2()
      let _ = mock->VitestMock.MockFn2.mockImplementation((a, b) => a * b)
      let f = mock->VitestMock.MockFn2.toFunction
      let result = f(6, 7)
      t->expect(result)->Expect.toBe(42)
    })

    test("mockImplementationOnce sets implementation for one call", t => {
      let mock: VitestMock.mockFn2<int, int, int> = VitestMock.fn2()
      let _ = mock->VitestMock.MockFn2.mockReturnValue(0)
      let _ = mock->VitestMock.MockFn2.mockImplementationOnce((a, b) => a + b)
      let f = mock->VitestMock.MockFn2.toFunction
      let first = f(1, 2)
      let second = f(1, 2)
      t->expect(first)->Expect.toBe(3)
      t->expect(second)->Expect.toBe(0)
    })

    test("mockReturnValue sets return value", t => {
      let mock: VitestMock.mockFn2<string, int, string> = VitestMock.fn2()
      let _ = mock->VitestMock.MockFn2.mockReturnValue("result")
      let f = mock->VitestMock.MockFn2.toFunction
      t->expect(f("a", 1))->Expect.toBe("result")
    })

    test("mockReturnValueOnce sets return value for one call", t => {
      let mock: VitestMock.mockFn2<int, int, int> = VitestMock.fn2()
      let _ = mock->VitestMock.MockFn2.mockReturnValue(0)
      let _ = mock->VitestMock.MockFn2.mockReturnValueOnce(99)
      let f = mock->VitestMock.MockFn2.toFunction
      t->expect(f(1, 2))->Expect.toBe(99)
      t->expect(f(1, 2))->Expect.toBe(0)
    })

    test("getMockImplementation returns implementation", _ => {
      let impl = (a, b) => a + b
      let mock = VitestMock.fnWithImpl2(impl)
      let retrieved = mock->VitestMock.MockFn2.getMockImplementation
      A.Option.isSome(retrieved)
    })
  })

  describe("fn3 - three-argument mock functions", _ => {
    test("fn3 creates a mock without implementation", t => {
      let mock = VitestMock.fn3()
      let f = mock->VitestMock.MockFn3.toFunction
      let _ = f("a", "b", "c")
      t->expect(mock)->VitestMockExpect.toHaveBeenCalled
    })

    test("creates and calls a 3-argument mock", t => {
      let mock = VitestMock.fnWithImpl3((a, b, c) => a ++ b ++ c)
      let f = mock->VitestMock.MockFn3.toFunction
      let result = f("a", "b", "c")
      t->expect(result)->Expect.toBe("abc")
      t->expect(mock)->VitestMockExpect.toHaveBeenCalledWith3("a", "b", "c")
    })

    test("tracks call arguments in context", t => {
      let mock = VitestMock.fn3()
      let f = mock->VitestMock.MockFn3.toFunction
      let _ = f(1, 2, 3)
      let _ = f(4, 5, 6)
      let ctx = mock->VitestMock.MockFn3.mock
      t->expect(ctx.calls->Array.length)->Expect.toBe(2)
    })

    test("mockName and getMockName work", t => {
      let mock = VitestMock.fn3()
      let _ = mock->VitestMock.MockFn3.mockName("mock3")
      t->expect(mock->VitestMock.MockFn3.getMockName)->Expect.toBe("mock3")
    })

    test("mockClear clears call history", t => {
      let mock = VitestMock.fn3()
      let f = mock->VitestMock.MockFn3.toFunction
      let _ = f("a", "b", "c")
      let _ = mock->VitestMock.MockFn3.mockClear
      let ctx = mock->VitestMock.MockFn3.mock
      t->expect(ctx.calls->Array.length)->Expect.toBe(0)
    })

    test("mockReset resets the mock", t => {
      let mock: VitestMock.mockFn3<int, int, int, int> = VitestMock.fn3()
      let _ = mock->VitestMock.MockFn3.mockReturnValue(42)
      let _ = mock->VitestMock.MockFn3.mockReset
      t->expect(mock)->VitestMockExpect.not->VitestMockExpect.toHaveBeenCalled
    })

    test("mockImplementation changes behavior", t => {
      let mock: VitestMock.mockFn3<int, int, int, int> = VitestMock.fn3()
      let _ = mock->VitestMock.MockFn3.mockImplementation((a, b, c) => a + b + c)
      let f = mock->VitestMock.MockFn3.toFunction
      t->expect(f(1, 2, 3))->Expect.toBe(6)
    })

    test("mockImplementationOnce sets implementation for one call", t => {
      let mock: VitestMock.mockFn3<int, int, int, int> = VitestMock.fn3()
      let _ = mock->VitestMock.MockFn3.mockReturnValue(0)
      let _ = mock->VitestMock.MockFn3.mockImplementationOnce((a, b, c) => a * b * c)
      let f = mock->VitestMock.MockFn3.toFunction
      t->expect(f(2, 3, 4))->Expect.toBe(24)
      t->expect(f(2, 3, 4))->Expect.toBe(0)
    })

    test("mockReturnValue sets return value", t => {
      let mock: VitestMock.mockFn3<int, int, int, string> = VitestMock.fn3()
      let _ = mock->VitestMock.MockFn3.mockReturnValue("result")
      let f = mock->VitestMock.MockFn3.toFunction
      t->expect(f(1, 2, 3))->Expect.toBe("result")
    })

    test("mockReturnValueOnce sets return value for one call", t => {
      let mock: VitestMock.mockFn3<int, int, int, int> = VitestMock.fn3()
      let _ = mock->VitestMock.MockFn3.mockReturnValue(0)
      let _ = mock->VitestMock.MockFn3.mockReturnValueOnce(99)
      let f = mock->VitestMock.MockFn3.toFunction
      t->expect(f(1, 2, 3))->Expect.toBe(99)
      t->expect(f(1, 2, 3))->Expect.toBe(0)
    })

    test("getMockImplementation returns implementation", _ => {
      let mock = VitestMock.fnWithImpl3((a, b, c) => a + b + c)
      A.Option.isSome(mock->VitestMock.MockFn3.getMockImplementation)
    })
  })

  describe("fn4 - four-argument mock functions", _ => {
    test("fn4 creates a mock without implementation", t => {
      let mock = VitestMock.fn4()
      let f = mock->VitestMock.MockFn4.toFunction
      let _ = f(1, 2, 3, 4)
      t->expect(mock)->VitestMockExpect.toHaveBeenCalled
    })

    test("creates and calls a 4-argument mock", t => {
      let mock = VitestMock.fnWithImpl4((a, b, c, d) => a + b + c + d)
      let f = mock->VitestMock.MockFn4.toFunction
      let result = f(1, 2, 3, 4)
      t->expect(result)->Expect.toBe(10)
      t->expect(mock)->VitestMockExpect.toHaveBeenCalledWith4(1, 2, 3, 4)
    })

    test("tracks call arguments in context", t => {
      let mock = VitestMock.fn4()
      let f = mock->VitestMock.MockFn4.toFunction
      let _ = f(1, 2, 3, 4)
      let _ = f(5, 6, 7, 8)
      let ctx = mock->VitestMock.MockFn4.mock
      t->expect(ctx.calls->Array.length)->Expect.toBe(2)
    })

    test("mockName and getMockName work", t => {
      let mock = VitestMock.fn4()
      let _ = mock->VitestMock.MockFn4.mockName("mock4")
      t->expect(mock->VitestMock.MockFn4.getMockName)->Expect.toBe("mock4")
    })

    test("mockClear clears call history", t => {
      let mock = VitestMock.fn4()
      let f = mock->VitestMock.MockFn4.toFunction
      let _ = f(1, 2, 3, 4)
      let _ = mock->VitestMock.MockFn4.mockClear
      let ctx = mock->VitestMock.MockFn4.mock
      t->expect(ctx.calls->Array.length)->Expect.toBe(0)
    })

    test("mockReset resets the mock", t => {
      let mock: VitestMock.mockFn4<int, int, int, int, int> = VitestMock.fn4()
      let _ = mock->VitestMock.MockFn4.mockReturnValue(42)
      let _ = mock->VitestMock.MockFn4.mockReset
      t->expect(mock)->VitestMockExpect.not->VitestMockExpect.toHaveBeenCalled
    })

    test("mockImplementation changes behavior", t => {
      let mock: VitestMock.mockFn4<int, int, int, int, int> = VitestMock.fn4()
      let _ = mock->VitestMock.MockFn4.mockImplementation((a, b, c, d) => a + b + c + d)
      let f = mock->VitestMock.MockFn4.toFunction
      t->expect(f(1, 2, 3, 4))->Expect.toBe(10)
    })

    test("mockImplementationOnce sets implementation for one call", t => {
      let mock: VitestMock.mockFn4<int, int, int, int, int> = VitestMock.fn4()
      let _ = mock->VitestMock.MockFn4.mockReturnValue(0)
      let _ = mock->VitestMock.MockFn4.mockImplementationOnce((a, b, c, d) => a * b * c * d)
      let f = mock->VitestMock.MockFn4.toFunction
      t->expect(f(1, 2, 3, 4))->Expect.toBe(24)
      t->expect(f(1, 2, 3, 4))->Expect.toBe(0)
    })

    test("mockReturnValue sets return value", t => {
      let mock: VitestMock.mockFn4<int, int, int, int, string> = VitestMock.fn4()
      let _ = mock->VitestMock.MockFn4.mockReturnValue("result")
      let f = mock->VitestMock.MockFn4.toFunction
      t->expect(f(1, 2, 3, 4))->Expect.toBe("result")
    })

    test("mockReturnValueOnce sets return value for one call", t => {
      let mock: VitestMock.mockFn4<int, int, int, int, int> = VitestMock.fn4()
      let _ = mock->VitestMock.MockFn4.mockReturnValue(0)
      let _ = mock->VitestMock.MockFn4.mockReturnValueOnce(99)
      let f = mock->VitestMock.MockFn4.toFunction
      t->expect(f(1, 2, 3, 4))->Expect.toBe(99)
      t->expect(f(1, 2, 3, 4))->Expect.toBe(0)
    })

    test("getMockImplementation returns implementation", _ => {
      let mock = VitestMock.fnWithImpl4((a, b, c, d) => a + b + c + d)
      A.Option.isSome(mock->VitestMock.MockFn4.getMockImplementation)
    })
  })

  describe("fn5 - five-argument mock functions", _ => {
    test("fn5 creates a mock without implementation", t => {
      let mock = VitestMock.fn5()
      let f = mock->VitestMock.MockFn5.toFunction
      let _ = f(1, 2, 3, 4, 5)
      t->expect(mock)->VitestMockExpect.toHaveBeenCalled
    })

    test("creates and calls a 5-argument mock", t => {
      let mock = VitestMock.fnWithImpl5((a, b, c, d, e) => a + b + c + d + e)
      let f = mock->VitestMock.MockFn5.toFunction
      let result = f(1, 2, 3, 4, 5)
      t->expect(result)->Expect.toBe(15)
      t->expect(mock)->VitestMockExpect.toHaveBeenCalledWith5(1, 2, 3, 4, 5)
    })

    test("tracks call arguments in context", t => {
      let mock = VitestMock.fn5()
      let f = mock->VitestMock.MockFn5.toFunction
      let _ = f(1, 2, 3, 4, 5)
      let _ = f(6, 7, 8, 9, 10)
      let ctx = mock->VitestMock.MockFn5.mock
      t->expect(ctx.calls->Array.length)->Expect.toBe(2)
    })

    test("mockName and getMockName work", t => {
      let mock = VitestMock.fn5()
      let _ = mock->VitestMock.MockFn5.mockName("mock5")
      t->expect(mock->VitestMock.MockFn5.getMockName)->Expect.toBe("mock5")
    })

    test("mockClear clears call history", t => {
      let mock = VitestMock.fn5()
      let f = mock->VitestMock.MockFn5.toFunction
      let _ = f(1, 2, 3, 4, 5)
      let _ = mock->VitestMock.MockFn5.mockClear
      let ctx = mock->VitestMock.MockFn5.mock
      t->expect(ctx.calls->Array.length)->Expect.toBe(0)
    })

    test("mockReset resets the mock", t => {
      let mock: VitestMock.mockFn5<int, int, int, int, int, int> = VitestMock.fn5()
      let _ = mock->VitestMock.MockFn5.mockReturnValue(42)
      let _ = mock->VitestMock.MockFn5.mockReset
      t->expect(mock)->VitestMockExpect.not->VitestMockExpect.toHaveBeenCalled
    })

    test("mockImplementation changes behavior", t => {
      let mock: VitestMock.mockFn5<int, int, int, int, int, int> = VitestMock.fn5()
      let _ = mock->VitestMock.MockFn5.mockImplementation((a, b, c, d, e) => a + b + c + d + e)
      let f = mock->VitestMock.MockFn5.toFunction
      t->expect(f(1, 2, 3, 4, 5))->Expect.toBe(15)
    })

    test("mockImplementationOnce sets implementation for one call", t => {
      let mock: VitestMock.mockFn5<int, int, int, int, int, int> = VitestMock.fn5()
      let _ = mock->VitestMock.MockFn5.mockReturnValue(0)
      let _ = mock->VitestMock.MockFn5.mockImplementationOnce((a, b, c, d, e) => a * b * c * d * e)
      let f = mock->VitestMock.MockFn5.toFunction
      t->expect(f(1, 2, 3, 4, 5))->Expect.toBe(120)
      t->expect(f(1, 2, 3, 4, 5))->Expect.toBe(0)
    })

    test("mockReturnValue sets return value", t => {
      let mock: VitestMock.mockFn5<int, int, int, int, int, string> = VitestMock.fn5()
      let _ = mock->VitestMock.MockFn5.mockReturnValue("result")
      let f = mock->VitestMock.MockFn5.toFunction
      t->expect(f(1, 2, 3, 4, 5))->Expect.toBe("result")
    })

    test("mockReturnValueOnce sets return value for one call", t => {
      let mock: VitestMock.mockFn5<int, int, int, int, int, int> = VitestMock.fn5()
      let _ = mock->VitestMock.MockFn5.mockReturnValue(0)
      let _ = mock->VitestMock.MockFn5.mockReturnValueOnce(99)
      let f = mock->VitestMock.MockFn5.toFunction
      t->expect(f(1, 2, 3, 4, 5))->Expect.toBe(99)
      t->expect(f(1, 2, 3, 4, 5))->Expect.toBe(0)
    })

    test("getMockImplementation returns implementation", _ => {
      let mock = VitestMock.fnWithImpl5((a, b, c, d, e) => a + b + c + d + e)
      A.Option.isSome(mock->VitestMock.MockFn5.getMockImplementation)
    })
  })

  describe("return value matchers", _ => {
    test("toHaveReturned works", t => {
      let mock = VitestMock.fnWithImpl0(() => 42)
      let f = mock->VitestMock.MockFn0.toFunction
      let _ = f()
      t->expect(mock)->VitestMockExpect.toHaveReturned
    })

    test("toHaveReturnedTimes works", t => {
      let mock = VitestMock.fnWithImpl0(() => 42)
      let f = mock->VitestMock.MockFn0.toFunction
      let _ = f()
      let _ = f()
      let _ = f()
      t->expect(mock)->VitestMockExpect.toHaveReturnedTimes(3)
    })

    test("toHaveReturnedWith works", t => {
      let mock = VitestMock.fnWithImpl1(x => x * 2)
      let f = mock->VitestMock.MockFn1.toFunction
      let _ = f(21)
      t->expect(mock)->VitestMockExpect.toHaveReturnedWith(42)
    })

    test("toHaveLastReturnedWith works", t => {
      let mock = VitestMock.fnWithImpl1(x => x)
      let f = mock->VitestMock.MockFn1.toFunction
      let _ = f(1)
      let _ = f(2)
      let _ = f(3)
      t->expect(mock)->VitestMockExpect.toHaveLastReturnedWith(3)
    })

    test("toHaveNthReturnedWith works", t => {
      let mock = VitestMock.fnWithImpl1(x => x * 10)
      let f = mock->VitestMock.MockFn1.toFunction
      let _ = f(1)
      let _ = f(2)
      let _ = f(3)
      t->expect(mock)->VitestMockExpect.toHaveNthReturnedWith(2, 20)
    })
  })

  describe("mock results tracking", _ => {
    test("tracks return results", t => {
      let mock = VitestMock.fnWithImpl0(() => 42)
      let f = mock->VitestMock.MockFn0.toFunction
      let _ = f()

      let ctx = mock->VitestMock.MockFn0.mock
      t->expect(ctx.results->Array.length)->Expect.toBe(1)

      switch ctx.results[0] {
      | Some({type_: #return, value}) => t->expect(value)->Expect.toBe(42)
      | _ => A.fail(~message="expected return result")
      }
    })
  })

  describe("async mock functions", _ => {
    testAsync("mockResolvedValue works for fn0", async t => {
      let mock: VitestMock.mockFn0<promise<int>> = VitestMock.fn0()
      let _ = mock->VitestMock.MockFn0.mockResolvedValue(42)

      let f = mock->VitestMock.MockFn0.toFunction
      let result = await f()
      t->expect(result)->Expect.toBe(42)
    })

    testAsync("mockResolvedValueOnce works for fn0", async t => {
      let mock: VitestMock.mockFn0<promise<string>> = VitestMock.fn0()
      let _ = mock->VitestMock.MockFn0.mockResolvedValue("default")
      let _ = mock->VitestMock.MockFn0.mockResolvedValueOnce("first")

      let f = mock->VitestMock.MockFn0.toFunction
      let first = await f()
      let second = await f()

      t->expect(first)->Expect.toBe("first")
      t->expect(second)->Expect.toBe("default")
    })

    testAsync("mockResolvedValue works for fn1", async t => {
      let mock: VitestMock.mockFn1<int, promise<int>> = VitestMock.fn1()
      let _ = mock->VitestMock.MockFn1.mockResolvedValue(42)
      let f = mock->VitestMock.MockFn1.toFunction
      let result = await f(1)
      t->expect(result)->Expect.toBe(42)
    })

    testAsync("mockResolvedValueOnce works for fn1", async t => {
      let mock: VitestMock.mockFn1<int, promise<int>> = VitestMock.fn1()
      let _ = mock->VitestMock.MockFn1.mockResolvedValue(0)
      let _ = mock->VitestMock.MockFn1.mockResolvedValueOnce(99)
      let f = mock->VitestMock.MockFn1.toFunction
      t->expect(await f(1))->Expect.toBe(99)
      t->expect(await f(1))->Expect.toBe(0)
    })

    testAsync("mockResolvedValue works for fn2", async t => {
      let mock: VitestMock.mockFn2<int, int, promise<int>> = VitestMock.fn2()
      let _ = mock->VitestMock.MockFn2.mockResolvedValue(42)
      let f = mock->VitestMock.MockFn2.toFunction
      let result = await f(1, 2)
      t->expect(result)->Expect.toBe(42)
    })

    testAsync("mockResolvedValueOnce works for fn2", async t => {
      let mock: VitestMock.mockFn2<int, int, promise<int>> = VitestMock.fn2()
      let _ = mock->VitestMock.MockFn2.mockResolvedValue(0)
      let _ = mock->VitestMock.MockFn2.mockResolvedValueOnce(99)
      let f = mock->VitestMock.MockFn2.toFunction
      t->expect(await f(1, 2))->Expect.toBe(99)
      t->expect(await f(1, 2))->Expect.toBe(0)
    })

    testAsync("mockResolvedValue works for fn3", async t => {
      let mock: VitestMock.mockFn3<int, int, int, promise<int>> = VitestMock.fn3()
      let _ = mock->VitestMock.MockFn3.mockResolvedValue(42)
      let f = mock->VitestMock.MockFn3.toFunction
      let result = await f(1, 2, 3)
      t->expect(result)->Expect.toBe(42)
    })

    testAsync("mockResolvedValueOnce works for fn3", async t => {
      let mock: VitestMock.mockFn3<int, int, int, promise<int>> = VitestMock.fn3()
      let _ = mock->VitestMock.MockFn3.mockResolvedValue(0)
      let _ = mock->VitestMock.MockFn3.mockResolvedValueOnce(99)
      let f = mock->VitestMock.MockFn3.toFunction
      t->expect(await f(1, 2, 3))->Expect.toBe(99)
      t->expect(await f(1, 2, 3))->Expect.toBe(0)
    })

    testAsync("mockResolvedValue works for fn4", async t => {
      let mock: VitestMock.mockFn4<int, int, int, int, promise<int>> = VitestMock.fn4()
      let _ = mock->VitestMock.MockFn4.mockResolvedValue(42)
      let f = mock->VitestMock.MockFn4.toFunction
      let result = await f(1, 2, 3, 4)
      t->expect(result)->Expect.toBe(42)
    })

    testAsync("mockResolvedValueOnce works for fn4", async t => {
      let mock: VitestMock.mockFn4<int, int, int, int, promise<int>> = VitestMock.fn4()
      let _ = mock->VitestMock.MockFn4.mockResolvedValue(0)
      let _ = mock->VitestMock.MockFn4.mockResolvedValueOnce(99)
      let f = mock->VitestMock.MockFn4.toFunction
      t->expect(await f(1, 2, 3, 4))->Expect.toBe(99)
      t->expect(await f(1, 2, 3, 4))->Expect.toBe(0)
    })

    testAsync("mockResolvedValue works for fn5", async t => {
      let mock: VitestMock.mockFn5<int, int, int, int, int, promise<int>> = VitestMock.fn5()
      let _ = mock->VitestMock.MockFn5.mockResolvedValue(42)
      let f = mock->VitestMock.MockFn5.toFunction
      let result = await f(1, 2, 3, 4, 5)
      t->expect(result)->Expect.toBe(42)
    })

    testAsync("mockResolvedValueOnce works for fn5", async t => {
      let mock: VitestMock.mockFn5<int, int, int, int, int, promise<int>> = VitestMock.fn5()
      let _ = mock->VitestMock.MockFn5.mockResolvedValue(0)
      let _ = mock->VitestMock.MockFn5.mockResolvedValueOnce(99)
      let f = mock->VitestMock.MockFn5.toFunction
      t->expect(await f(1, 2, 3, 4, 5))->Expect.toBe(99)
      t->expect(await f(1, 2, 3, 4, 5))->Expect.toBe(0)
    })
  })

  describe("mockRestore", _ => {
    test("mockRestore for fn0", _ => {
      let mock = VitestMock.fn0()
      // Just verify it doesn't throw
      mock->VitestMock.MockFn0.mockRestore
    })

    test("mockRestore for fn1", _ => {
      let mock = VitestMock.fn1()
      mock->VitestMock.MockFn1.mockRestore
    })

    test("mockRestore for fn2", _ => {
      let mock = VitestMock.fn2()
      mock->VitestMock.MockFn2.mockRestore
    })

    test("mockRestore for fn3", _ => {
      let mock = VitestMock.fn3()
      mock->VitestMock.MockFn3.mockRestore
    })

    test("mockRestore for fn4", _ => {
      let mock = VitestMock.fn4()
      mock->VitestMock.MockFn4.mockRestore
    })

    test("mockRestore for fn5", _ => {
      let mock = VitestMock.fn5()
      mock->VitestMock.MockFn5.mockRestore
    })
  })

  describe("mockReturnThis", _ => {
    test("mockReturnThis for fn0", t => {
      let mock = VitestMock.fn0()
      let returned = mock->VitestMock.MockFn0.mockReturnThis
      // mockReturnThis returns the mock itself for chaining
      t->expect(VitestMock.isMockFunction(returned))->Expect.toBe(true)
    })

    test("mockReturnThis for fn1", t => {
      let mock = VitestMock.fn1()
      let returned = mock->VitestMock.MockFn1.mockReturnThis
      t->expect(VitestMock.isMockFunction(returned))->Expect.toBe(true)
    })

    test("mockReturnThis for fn2", t => {
      let mock = VitestMock.fn2()
      let returned = mock->VitestMock.MockFn2.mockReturnThis
      t->expect(VitestMock.isMockFunction(returned))->Expect.toBe(true)
    })

    test("mockReturnThis for fn3", t => {
      let mock = VitestMock.fn3()
      let returned = mock->VitestMock.MockFn3.mockReturnThis
      t->expect(VitestMock.isMockFunction(returned))->Expect.toBe(true)
    })

    test("mockReturnThis for fn4", t => {
      let mock = VitestMock.fn4()
      let returned = mock->VitestMock.MockFn4.mockReturnThis
      t->expect(VitestMock.isMockFunction(returned))->Expect.toBe(true)
    })

    test("mockReturnThis for fn5", t => {
      let mock = VitestMock.fn5()
      let returned = mock->VitestMock.MockFn5.mockReturnThis
      t->expect(VitestMock.isMockFunction(returned))->Expect.toBe(true)
    })
  })

  describe("negation with not", _ => {
    test("not.toHaveBeenCalled works", t => {
      let mock = VitestMock.fn0()
      t->expect(mock)->VitestMockExpect.not->VitestMockExpect.toHaveBeenCalled
    })

    test("not.toHaveBeenCalledWith works", t => {
      let mock = VitestMock.fn1()
      let f = mock->VitestMock.MockFn1.toFunction
      let _ = f("hello")
      t->expect(mock)->VitestMockExpect.not->VitestMockExpect.toHaveBeenCalledWith1("goodbye")
    })
  })

  describe("toFunction conversion", _ => {
    test("can convert mock to regular function", t => {
      let mock = VitestMock.fnWithImpl1(x => x * 2)
      let fn = mock->VitestMock.MockFn1.toFunction

      // Use the function normally
      let result = fn(21)
      t->expect(result)->Expect.toBe(42)

      // Mock still tracks the call
      t->expect(mock)->VitestMockExpect.toHaveBeenCalledWith1(21)
    })
  })

  describe("global mock utilities", _ => {
    test("isMockFunction returns true for mocks", t => {
      let mock = VitestMock.fn0()
      t->expect(VitestMock.isMockFunction(mock))->Expect.toBe(true)
    })

    test("isMockFunction returns false for regular functions", t => {
      let fn = () => 42
      t->expect(VitestMock.isMockFunction(fn))->Expect.toBe(false)
    })

    test("clearAllMocks clears all mock call history", t => {
      let mock1 = VitestMock.fn0()
      let mock2 = VitestMock.fn0()
      let f1 = mock1->VitestMock.MockFn0.toFunction
      let f2 = mock2->VitestMock.MockFn0.toFunction
      let _ = f1()
      let _ = f2()

      let _ = VitestMock.clearAllMocks()

      let ctx1 = mock1->VitestMock.MockFn0.mock
      let ctx2 = mock2->VitestMock.MockFn0.mock
      t->expect(ctx1.calls->Array.length)->Expect.toBe(0)
      t->expect(ctx2.calls->Array.length)->Expect.toBe(0)
    })

    test("resetAllMocks resets all mocks", t => {
      let mock: VitestMock.mockFn0<int> = VitestMock.fn0()
      let _ = mock->VitestMock.MockFn0.mockReturnValue(42)
      let f = mock->VitestMock.MockFn0.toFunction
      let _ = f()

      let _ = VitestMock.resetAllMocks()

      // After reset, call history is cleared and implementation is reset
      let ctx = mock->VitestMock.MockFn0.mock
      t->expect(ctx.calls->Array.length)->Expect.toBe(0)
    })

    test("restoreAllMocks restores all mocks", _ => {
      // Just verify it doesn't throw
      let _ = VitestMock.restoreAllMocks()
    })
  })

  describe("call order matchers", _ => {
    test("toHaveBeenCalledBefore works", t => {
      let mock1 = VitestMock.fn0()
      let mock2 = VitestMock.fn0()

      let f1 = mock1->VitestMock.MockFn0.toFunction
      let f2 = mock2->VitestMock.MockFn0.toFunction
      let _ = f1()
      let _ = f2()

      t
      ->expect(mock1)
      ->VitestMockExpect.toHaveBeenCalledBefore(mock2->VitestMockExpect.toAnyMockInstance)
    })

    test("toHaveBeenCalledAfter works", t => {
      let mock1 = VitestMock.fn0()
      let mock2 = VitestMock.fn0()

      let f1 = mock1->VitestMock.MockFn0.toFunction
      let f2 = mock2->VitestMock.MockFn0.toFunction
      let _ = f1()
      let _ = f2()

      t
      ->expect(mock2)
      ->VitestMockExpect.toHaveBeenCalledAfter(mock1->VitestMockExpect.toAnyMockInstance)
    })
  })

  describe("toHaveBeenCalledExactlyOnceWith", _ => {
    test("works with 1-arity mock", t => {
      let mock = VitestMock.fn1()
      let f = mock->VitestMock.MockFn1.toFunction
      let _ = f("hello")
      t->expect(mock)->VitestMockExpect.toHaveBeenCalledExactlyOnceWith1("hello")
    })

    test("works with 2-arity mock", t => {
      let mock = VitestMock.fn2()
      let f = mock->VitestMock.MockFn2.toFunction
      let _ = f(1, 2)
      t->expect(mock)->VitestMockExpect.toHaveBeenCalledExactlyOnceWith2(1, 2)
    })
  })

  describe("chaining mock methods", _ => {
    test("methods can be chained", t => {
      let mock =
        VitestMock.fn0()
        ->VitestMock.MockFn0.mockName("chainedMock")
        ->VitestMock.MockFn0.mockReturnValue(42)

      let f = mock->VitestMock.MockFn0.toFunction
      let result = f()
      t->expect(result)->Expect.toBe(42)
      t->expect(mock->VitestMock.MockFn0.getMockName)->Expect.toBe("chainedMock")
    })
  })
})
