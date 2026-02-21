open Vitest
// Use our Assert module, not Vitest.Assert
module Assert = VitestExtras.Assert

describe("Assert", () => {
  describe("Core assertions", () => {
    test(
      "assert_",
      _ => {
        Assert.assert_(true)
        Assert.assert_(1)
        Assert.assert_("non-empty")
      },
    )
  })

  describe("Equality assertions", () => {
    test(
      "equal",
      _ => {
        Assert.equal(1, 1)
      },
    )

    test(
      "notEqual",
      _ => {
        Assert.notEqual(1, 2)
      },
    )

    test(
      "strictEqual",
      _ => {
        Assert.strictEqual("hello", "hello")
      },
    )

    test(
      "notStrictEqual",
      _ => {
        Assert.notStrictEqual("hello", "world")
      },
    )

    test(
      "deepEqual",
      _ => {
        Assert.deepEqual([1, 2, 3], [1, 2, 3])
      },
    )

    test(
      "notDeepEqual",
      _ => {
        Assert.notDeepEqual([1, 2, 3], [1, 2, 4])
      },
    )
  })

  describe("Numeric comparisons", () => {
    test(
      "isAbove",
      _ => {
        Assert.isAbove(10.0, 5.0)
      },
    )

    test(
      "isAtLeast",
      _ => {
        Assert.isAtLeast(5.0, 5.0)
      },
    )

    test(
      "isBelow",
      _ => {
        Assert.isBelow(3.0, 5.0)
      },
    )

    test(
      "isAtMost",
      _ => {
        Assert.isAtMost(5.0, 5.0)
      },
    )

    test(
      "closeTo",
      _ => {
        Assert.closeTo(1.5, 1.0, ~delta=1.0)
      },
    )

    test(
      "approximately (alias for closeTo)",
      _ => {
        Assert.approximately(1.5, 1.0, ~delta=1.0)
      },
    )
  })

  describe("Boolean assertions", () => {
    test(
      "isTrue",
      _ => {
        Assert.isTrue(true)
      },
    )

    test(
      "isNotTrue",
      _ => {
        Assert.isNotTrue(false)
      },
    )

    test(
      "isFalse",
      _ => {
        Assert.isFalse(false)
      },
    )

    test(
      "isNotFalse",
      _ => {
        Assert.isNotFalse(true)
      },
    )
  })

  describe("NaN and Finite assertions", () => {
    test(
      "isNaN",
      _ => {
        Assert.isNaN(Float.Constants.nan)
      },
    )

    test(
      "isNotNaN",
      _ => {
        Assert.isNotNaN(42.0)
      },
    )

    test(
      "isFinite",
      _ => {
        Assert.isFinite(42.0)
      },
    )
  })

  describe("Null assertions", () => {
    test(
      "Null.isNull confirms null",
      _ => {
        let nullValue: Null.t<int> = Null.null
        Assert.Null.isNull(nullValue)
      },
    )

    test(
      "Null.isNotNull confirms not null",
      _ => {
        let value: Null.t<int> = Null.make(42)
        Assert.Null.isNotNull(value)
      },
    )
  })

  describe("Undefined assertions", () => {
    test(
      "Undefined.isUndefined confirms undefined",
      _ => {
        let value: undefined<int> = Obj.magic(Nullable.undefined)
        Assert.Undefined.isUndefined(value)
      },
    )

    test(
      "Undefined.isDefined confirms defined",
      _ => {
        let value: undefined<int> = Obj.magic(42)
        Assert.Undefined.isDefined(value)
      },
    )
  })

  describe("Nullable assertions", () => {
    test(
      "Nullable.isNull confirms null",
      _ => {
        let value: Nullable.t<int> = Nullable.null
        Assert.Nullable.isNull(value)
      },
    )

    test(
      "Nullable.isNotNull confirms not null",
      _ => {
        let value: Nullable.t<int> = Nullable.make(42)
        Assert.Nullable.isNotNull(value)
      },
    )

    test(
      "Nullable.isUndefined confirms undefined",
      _ => {
        let value: Nullable.t<int> = Nullable.undefined
        Assert.Nullable.isUndefined(value)
      },
    )

    test(
      "Nullable.isDefined confirms defined",
      _ => {
        let value: Nullable.t<int> = Nullable.make(42)
        Assert.Nullable.isDefined(value)
      },
    )

    test(
      "Nullable.exists confirms value exists",
      _ => {
        let value: Nullable.t<string> = Nullable.make("hello")
        Assert.Nullable.exists(value)
      },
    )

    test(
      "Nullable.notExists confirms null",
      _ => {
        let value: Nullable.t<int> = Nullable.null
        Assert.Nullable.notExists(value)
      },
    )

    test(
      "Nullable.notExists confirms undefined",
      _ => {
        let value: Nullable.t<int> = Nullable.undefined
        Assert.Nullable.notExists(value)
      },
    )
  })

  describe("Array assertions", () => {
    test(
      "Array.isEmpty",
      _ => {
        Assert.Array.isEmpty([])
      },
    )

    test(
      "Array.isNotEmpty",
      _ => {
        Assert.Array.isNotEmpty([1])
      },
    )

    test(
      "Array.lengthOf",
      _ => {
        Assert.Array.lengthOf([1, 2, 3], 3)
      },
    )

    test(
      "Array.includes",
      _ => {
        Assert.Array.includes([1, 2, 3], 2)
      },
    )

    test(
      "Array.notIncludes",
      _ => {
        Assert.Array.notIncludes([1, 2, 3], 4)
      },
    )

    test(
      "Array.sameMembers",
      _ => {
        Assert.Array.sameMembers([1, 2, 3], [3, 1, 2])
      },
    )

    test(
      "Array.notSameMembers",
      _ => {
        Assert.Array.notSameMembers([1, 2, 3], [1, 2, 4])
      },
    )

    test(
      "Array.sameDeepMembers",
      _ => {
        Assert.Array.sameDeepMembers([{"a": 1}, {"a": 2}], [{"a": 2}, {"a": 1}])
      },
    )

    test(
      "Array.notSameDeepMembers",
      _ => {
        Assert.Array.notSameDeepMembers([{"a": 1}], [{"a": 2}])
      },
    )

    test(
      "Array.sameOrderedMembers",
      _ => {
        Assert.Array.sameOrderedMembers([1, 2, 3], [1, 2, 3])
      },
    )

    test(
      "Array.notSameOrderedMembers",
      _ => {
        Assert.Array.notSameOrderedMembers([1, 2, 3], [3, 2, 1])
      },
    )

    test(
      "Array.sameDeepOrderedMembers",
      _ => {
        Assert.Array.sameDeepOrderedMembers([{"a": 1}, {"a": 2}], [{"a": 1}, {"a": 2}])
      },
    )

    test(
      "Array.notSameDeepOrderedMembers",
      _ => {
        Assert.Array.notSameDeepOrderedMembers([{"a": 1}, {"a": 2}], [{"a": 2}, {"a": 1}])
      },
    )

    test(
      "Array.includeMembers",
      _ => {
        Assert.Array.includeMembers([1, 2, 3, 4], [2, 3])
      },
    )

    test(
      "Array.notIncludeMembers",
      _ => {
        Assert.Array.notIncludeMembers([1, 2, 3], [4, 5])
      },
    )

    test(
      "Array.includeDeepMembers",
      _ => {
        Assert.Array.includeDeepMembers([{"a": 1}, {"a": 2}, {"a": 3}], [{"a": 2}])
      },
    )

    test(
      "Array.notIncludeDeepMembers",
      _ => {
        Assert.Array.notIncludeDeepMembers([{"a": 1}], [{"a": 2}])
      },
    )

    test(
      "Array.includeOrderedMembers",
      _ => {
        Assert.Array.includeOrderedMembers([1, 2, 3, 4], [1, 2])
      },
    )

    test(
      "Array.notIncludeOrderedMembers",
      _ => {
        Assert.Array.notIncludeOrderedMembers([1, 2, 3, 4], [3, 2])
      },
    )

    test(
      "Array.includeDeepOrderedMembers",
      _ => {
        Assert.Array.includeDeepOrderedMembers([{"a": 1}, {"a": 2}, {"a": 3}], [{"a": 1}, {"a": 2}])
      },
    )

    test(
      "Array.notIncludeDeepOrderedMembers",
      _ => {
        Assert.Array.notIncludeDeepOrderedMembers([{"a": 1}, {"a": 2}], [{"a": 2}, {"a": 1}])
      },
    )
  })

  describe("String assertions", () => {
    test(
      "String.includes",
      _ => {
        Assert.String.includes("hello world", "world")
      },
    )

    test(
      "String.notIncludes",
      _ => {
        Assert.String.notIncludes("hello world", "foo")
      },
    )

    test(
      "String.isEmpty",
      _ => {
        Assert.String.isEmpty("")
      },
    )

    test(
      "String.isNotEmpty",
      _ => {
        Assert.String.isNotEmpty("hello")
      },
    )

    test(
      "String.lengthOf",
      _ => {
        Assert.String.lengthOf("hello", 5)
      },
    )
  })

  describe("Regex matching", () => {
    test(
      "match_",
      _ => {
        Assert.match_("hello123", /\d+/)
      },
    )

    test(
      "notMatch",
      _ => {
        Assert.notMatch("hello", /\d+/)
      },
    )
  })

  describe("oneOf", () => {
    test(
      "value is in list",
      _ => {
        Assert.oneOf(2, [1, 2, 3])
      },
    )
  })

  describe("Exception assertions", () => {
    test(
      "throws",
      _ => {
        Assert.throws(() => JsError.throwWithMessage("test error"))
      },
    )

    test(
      "throwsWithMatch",
      _ => {
        Assert.throwsWithMatch(() => JsError.throwWithMessage("test error 123"), /\d+/)
      },
    )

    test(
      "doesNotThrow",
      _ => {
        Assert.doesNotThrow(() => ())
      },
    )
  })

  describe("Object state assertions", () => {
    test(
      "isExtensible",
      _ => {
        let obj = {"foo": 1}
        Assert.isExtensible(obj)
      },
    )

    test(
      "isNotExtensible",
      _ => {
        let obj = {"foo": 1}
        let frozen = Object.freeze(obj)
        Assert.isNotExtensible(frozen)
      },
    )

    test(
      "isSealed",
      _ => {
        let obj = {"foo": 1}
        let sealed = Object.seal(obj)
        Assert.isSealed(sealed)
      },
    )

    test(
      "isNotSealed",
      _ => {
        let obj = {"foo": 1}
        Assert.isNotSealed(obj)
      },
    )

    test(
      "isFrozen",
      _ => {
        let obj = {"foo": 1}
        let frozen = Object.freeze(obj)
        Assert.isFrozen(frozen)
      },
    )

    test(
      "isNotFrozen",
      _ => {
        let obj = {"foo": 1}
        Assert.isNotFrozen(obj)
      },
    )
  })

  describe("Result assertions", () => {
    test(
      "Result.isOk confirms Ok",
      _ => {
        let result: result<int, string> = Ok(42)
        Assert.Result.isOk(result)
      },
    )

    test(
      "Result.isOk throws on Error",
      _ => {
        Assert.throws(
          () => {
            let result: result<int, string> = Error("fail")
            Assert.Result.isOk(result)
          },
        )
      },
    )

    test(
      "Result.isError confirms Error",
      _ => {
        let result: result<int, string> = Error("fail")
        Assert.Result.isError(result)
      },
    )

    test(
      "Result.isError throws on Ok",
      _ => {
        Assert.throws(
          () => {
            let result: result<int, string> = Ok(42)
            Assert.Result.isError(result)
          },
        )
      },
    )
  })

  describe("Option assertions", () => {
    test(
      "Option.isSome confirms Some",
      _ => {
        let opt: option<int> = Some(42)
        Assert.Option.isSome(opt)
      },
    )

    test(
      "Option.isSome throws on None",
      _ => {
        Assert.throws(
          () => {
            let opt: option<int> = None
            Assert.Option.isSome(opt)
          },
        )
      },
    )

    test(
      "Option.isNone confirms None",
      _ => {
        let opt: option<int> = None
        Assert.Option.isNone(opt)
      },
    )

    test(
      "Option.isNone throws on Some",
      _ => {
        Assert.throws(
          () => {
            let opt: option<int> = Some(42)
            Assert.Option.isNone(opt)
          },
        )
      },
    )
  })

  describe("fail", () => {
    test(
      "fail throws",
      _ => {
        Assert.throws(() => Assert.fail())
      },
    )

    test(
      "fail throws with message",
      _ => {
        Assert.throwsWithMatch(() => Assert.fail(~message="custom message"), /custom message/)
      },
    )
  })
})
