open Vitest

// Use our Assert module, not Vitest.Assert
module A = VitestAssert

describe("Assert", () => {
  describe("Core assertions", () => {
    test("assert_", _ => {
      A.assert_(true)
      A.assert_(1)
      A.assert_("non-empty")
    })
  })

  describe("Equality assertions", () => {
    test("equal", _ => {
      A.equal(1, 1)
    })

    test("notEqual", _ => {
      A.notEqual(1, 2)
    })

    test("strictEqual", _ => {
      A.strictEqual("hello", "hello")
    })

    test("notStrictEqual", _ => {
      A.notStrictEqual("hello", "world")
    })

    test("deepEqual", _ => {
      A.deepEqual([1, 2, 3], [1, 2, 3])
    })

    test("notDeepEqual", _ => {
      A.notDeepEqual([1, 2, 3], [1, 2, 4])
    })
  })

  describe("Numeric comparisons", () => {
    test("isAbove", _ => {
      A.isAbove(10.0, 5.0)
    })

    test("isAtLeast", _ => {
      A.isAtLeast(5.0, 5.0)
    })

    test("isBelow", _ => {
      A.isBelow(3.0, 5.0)
    })

    test("isAtMost", _ => {
      A.isAtMost(5.0, 5.0)
    })

    test("closeTo", _ => {
      A.closeTo(1.5, 1.0, ~delta=1.0)
    })

    test("approximately (alias for closeTo)", _ => {
      A.approximately(1.5, 1.0, ~delta=1.0)
    })
  })

  describe("Boolean assertions", () => {
    test("isTrue", _ => {
      A.isTrue(true)
    })

    test("isNotTrue", _ => {
      A.isNotTrue(false)
    })

    test("isFalse", _ => {
      A.isFalse(false)
    })

    test("isNotFalse", _ => {
      A.isNotFalse(true)
    })
  })

  describe("NaN and Finite assertions", () => {
    test("isNaN", _ => {
      A.isNaN(Float.Constants.nan)
    })

    test("isNotNaN", _ => {
      A.isNotNaN(42.0)
    })

    test("isFinite", _ => {
      A.isFinite(42.0)
    })
  })

  describe("Null assertions", () => {
    test("Null.isNull confirms null", _ => {
      let nullValue: Null.t<int> = Null.null
      A.Null.isNull(nullValue)
    })

    test("Null.isNotNull confirms not null", _ => {
      let value: Null.t<int> = Null.make(42)
      A.Null.isNotNull(value)
    })
  })

  describe("Undefined assertions", () => {
    test("Undefined.isUndefined confirms undefined", _ => {
      let value: undefined<int> = Obj.magic(Nullable.undefined)
      A.Undefined.isUndefined(value)
    })

    test("Undefined.isDefined confirms defined", _ => {
      let value: undefined<int> = Obj.magic(42)
      A.Undefined.isDefined(value)
    })
  })

  describe("Nullable assertions", () => {
    test("Nullable.isNull confirms null", _ => {
      let value: Nullable.t<int> = Nullable.null
      A.Nullable.isNull(value)
    })

    test("Nullable.isNotNull confirms not null", _ => {
      let value: Nullable.t<int> = Nullable.make(42)
      A.Nullable.isNotNull(value)
    })

    test("Nullable.isUndefined confirms undefined", _ => {
      let value: Nullable.t<int> = Nullable.undefined
      A.Nullable.isUndefined(value)
    })

    test("Nullable.isDefined confirms defined", _ => {
      let value: Nullable.t<int> = Nullable.make(42)
      A.Nullable.isDefined(value)
    })

    test("Nullable.exists confirms value exists", _ => {
      let value: Nullable.t<string> = Nullable.make("hello")
      A.Nullable.exists(value)
    })

    test("Nullable.notExists confirms null", _ => {
      let value: Nullable.t<int> = Nullable.null
      A.Nullable.notExists(value)
    })

    test("Nullable.notExists confirms undefined", _ => {
      let value: Nullable.t<int> = Nullable.undefined
      A.Nullable.notExists(value)
    })
  })

  describe("Array assertions", () => {
    test("Array.isEmpty", _ => {
      A.Array.isEmpty([])
    })

    test("Array.isNotEmpty", _ => {
      A.Array.isNotEmpty([1])
    })

    test("Array.lengthOf", _ => {
      A.Array.lengthOf([1, 2, 3], 3)
    })

    test("Array.includes", _ => {
      A.Array.includes([1, 2, 3], 2)
    })

    test("Array.notIncludes", _ => {
      A.Array.notIncludes([1, 2, 3], 4)
    })

    test("Array.sameMembers", _ => {
      A.Array.sameMembers([1, 2, 3], [3, 1, 2])
    })

    test("Array.notSameMembers", _ => {
      A.Array.notSameMembers([1, 2, 3], [1, 2, 4])
    })

    test("Array.sameDeepMembers", _ => {
      A.Array.sameDeepMembers([{"a": 1}, {"a": 2}], [{"a": 2}, {"a": 1}])
    })

    test("Array.notSameDeepMembers", _ => {
      A.Array.notSameDeepMembers([{"a": 1}], [{"a": 2}])
    })

    test("Array.sameOrderedMembers", _ => {
      A.Array.sameOrderedMembers([1, 2, 3], [1, 2, 3])
    })

    test("Array.notSameOrderedMembers", _ => {
      A.Array.notSameOrderedMembers([1, 2, 3], [3, 2, 1])
    })

    test("Array.sameDeepOrderedMembers", _ => {
      A.Array.sameDeepOrderedMembers([{"a": 1}, {"a": 2}], [{"a": 1}, {"a": 2}])
    })

    test("Array.notSameDeepOrderedMembers", _ => {
      A.Array.notSameDeepOrderedMembers([{"a": 1}, {"a": 2}], [{"a": 2}, {"a": 1}])
    })

    test("Array.includeMembers", _ => {
      A.Array.includeMembers([1, 2, 3, 4], [2, 3])
    })

    test("Array.notIncludeMembers", _ => {
      A.Array.notIncludeMembers([1, 2, 3], [4, 5])
    })

    test("Array.includeDeepMembers", _ => {
      A.Array.includeDeepMembers([{"a": 1}, {"a": 2}, {"a": 3}], [{"a": 2}])
    })

    test("Array.notIncludeDeepMembers", _ => {
      A.Array.notIncludeDeepMembers([{"a": 1}], [{"a": 2}])
    })

    test("Array.includeOrderedMembers", _ => {
      A.Array.includeOrderedMembers([1, 2, 3, 4], [1, 2])
    })

    test("Array.notIncludeOrderedMembers", _ => {
      A.Array.notIncludeOrderedMembers([1, 2, 3, 4], [3, 2])
    })

    test("Array.includeDeepOrderedMembers", _ => {
      A.Array.includeDeepOrderedMembers([{"a": 1}, {"a": 2}, {"a": 3}], [{"a": 1}, {"a": 2}])
    })

    test("Array.notIncludeDeepOrderedMembers", _ => {
      A.Array.notIncludeDeepOrderedMembers([{"a": 1}, {"a": 2}], [{"a": 2}, {"a": 1}])
    })
  })

  describe("String assertions", () => {
    test("String.includes", _ => {
      A.String.includes("hello world", "world")
    })

    test("String.notIncludes", _ => {
      A.String.notIncludes("hello world", "foo")
    })

    test("String.isEmpty", _ => {
      A.String.isEmpty("")
    })

    test("String.isNotEmpty", _ => {
      A.String.isNotEmpty("hello")
    })

    test("String.lengthOf", _ => {
      A.String.lengthOf("hello", 5)
    })
  })

  describe("Regex matching", () => {
    test("match_", _ => {
      A.match_("hello123", /\d+/)
    })

    test("notMatch", _ => {
      A.notMatch("hello", /\d+/)
    })
  })

  describe("oneOf", () => {
    test("value is in list", _ => {
      A.oneOf(2, [1, 2, 3])
    })
  })

  describe("Exception assertions", () => {
    test("throws", _ => {
      A.throws(() => JsError.throwWithMessage("test error"))
    })

    test("throwsWithMatch", _ => {
      A.throwsWithMatch(() => JsError.throwWithMessage("test error 123"), /\d+/)
    })

    test("doesNotThrow", _ => {
      A.doesNotThrow(() => ())
    })
  })

  describe("Object state assertions", () => {
    test("isExtensible", _ => {
      let obj = {"foo": 1}
      A.isExtensible(obj)
    })

    test("isNotExtensible", _ => {
      let obj = {"foo": 1}
      let frozen = Object.freeze(obj)
      A.isNotExtensible(frozen)
    })

    test("isSealed", _ => {
      let obj = {"foo": 1}
      let sealed = Object.seal(obj)
      A.isSealed(sealed)
    })

    test("isNotSealed", _ => {
      let obj = {"foo": 1}
      A.isNotSealed(obj)
    })

    test("isFrozen", _ => {
      let obj = {"foo": 1}
      let frozen = Object.freeze(obj)
      A.isFrozen(frozen)
    })

    test("isNotFrozen", _ => {
      let obj = {"foo": 1}
      A.isNotFrozen(obj)
    })
  })

  describe("Result assertions", () => {
    test("Result.isOk confirms Ok", _ => {
      let result: result<int, string> = Ok(42)
      A.Result.isOk(result)
    })

    test("Result.isOk throws on Error", _ => {
      A.throws(() => {
        let result: result<int, string> = Error("fail")
        A.Result.isOk(result)
      })
    })

    test("Result.isError confirms Error", _ => {
      let result: result<int, string> = Error("fail")
      A.Result.isError(result)
    })

    test("Result.isError throws on Ok", _ => {
      A.throws(() => {
        let result: result<int, string> = Ok(42)
        A.Result.isError(result)
      })
    })
  })

  describe("Option assertions", () => {
    test("Option.isSome confirms Some", _ => {
      let opt: option<int> = Some(42)
      A.Option.isSome(opt)
    })

    test("Option.isSome throws on None", _ => {
      A.throws(() => {
        let opt: option<int> = None
        A.Option.isSome(opt)
      })
    })

    test("Option.isNone confirms None", _ => {
      let opt: option<int> = None
      A.Option.isNone(opt)
    })

    test("Option.isNone throws on Some", _ => {
      A.throws(() => {
        let opt: option<int> = Some(42)
        A.Option.isNone(opt)
      })
    })
  })

  describe("fail", () => {
    test("fail throws", _ => {
      A.throws(() => A.fail())
    })

    test("fail throws with message", _ => {
      A.throwsWithMatch(() => A.fail(~message="custom message"), /custom message/)
    })
  })
})
