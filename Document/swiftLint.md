# SwiftLintルール一覧

## Defaults Rules

### Block Based KVO

`KVO`にキーパスの使用を優先すること

``` swift
// bad
class Foo: NSObject {
    override func observeValue(
        forKeyPath keyPath: String?,
        of object: Any?,
        change: [NSKeyValueChangeKey : Any]?,
        context: UnsafeMutableRawPointer?
    ) {}
}

// good
let observer = foo.observe(\.value, options: [.new]) { (foo, change) in
    print(change.newValue)
}
```

### Class Delegate Protocol

デリゲートプロトコルは弱参照できるようにクラスのみにすること

``` swift
// bad
protocol FooDelegate {}

// good
protocol FooDelegate: class {}
```

### Closing Brace Spacing

閉じ括弧間に空白を作ってはいけないこと

``` swift
// bad
[].map({ } )

// good
[].map({})
```

### Closure Parameter Position

クロージャのパラメータを開き括弧と同じ行にすること

``` swift
// bad
[1, 2].map {
    number in
    number + 1
}

// good
[1, 2].map { number in
    number + 1
}
```

### Colon Spacing

`:`は型の指定時には識別子の後ろ、辞書ではキーの後ろにあること

``` swift
// bad
let abc:Void
let abc :Void
let abc : Void
let abc: [String:Int]
let abc: [String :Int]
let abc: [String : Int]

// good
let abc: Void
let abc: [String: Int]
```

### Comma Spacing

`,`の前にスペースがあるべきではなく、`,`の後ろに1つの半角スペースがあること

``` swift
// bad
func abc(a: String,b: String) {}
func abc(a: String ,b: String) {}
func abc(a: String , b: String) {}

// good
func abc(a: String, b: String) {}
```

### Comment Spacing

`//`の後ろに1つの半角スペースがあること

``` swift
// bad

//Something
//MARK

// good

// This is a comment
/// Triple slash comment
```

### Compiler Protocol Init

`ExpressibleByArrayLiteral`のようなコンパイルプロトコルで定義されているイニシャライザを直接呼び出さないこと

``` swift
// bad
let set = Set(arrayLiteral: 1, 2)
let set = Set.init(arrayLiteral: 1, 2)

// good
let set: Set<Int> = [1, 2]
let set = Set(array)
```

### Computed Accessors Order

`Computed Property`の`getter`, `setter`の順序を統一すること

``` swift
// bad
var foo: Int {
    set { print(newValue) }
    get { return 20 }
}

// good
var foo: Int {
    get { return 20 }
    set { print(newValue) }
}
```

### Control Statement

`if`, `for`, `guard`, `switch`, `while`, `catch`文は条件や引数を不必要に括弧で括らないこと

``` swift
// bad
if (condition) {}

for (item in collection) {}

guard (condition) else {}

switch (foo) {}

while (condition) {}

do {} catch (let error) {}

// good
if condition {}

for item in collection {}

guard condition else {}

switch foo {}

while condition {}

do {} catch let error {}
```

### Custom Rules

正規表現文字列を指定してカスタムルールを作成する、オプションで、マッチさせる構文の種類、重大度レベル、表示するメッセージを指定する

### Cyclomatic Complexity

関数内は複雑にすべきでないこと

``` swift
// bad
func f1() {
    if true {
        if true {
            if false {}
        }
    }

    if false {}

    let i = 0

    switch i {
    case 1: break
    case 2: break
    case 3: break
    case 4: break
    default: break
    }

    for _ in 1...5 {
        guard true else {
            return
        }
    }
}

// good
func f1() {
    if true {
        for _ in 1..5 {}
    }

    if false {}
}
```

### Deployment Target

可用性のチェックまたは属性は、`Deployment Target`が満たす古いバージョンを使うべきでないこと

``` swift
// bad
@available(iOS 6.0, *)
class A {}

if #available(iOS 6.0, *) {}

// good
@available(iOS 12.0, *)
class A {}

if #available(iOS 12.0, *) {}
```

### Discouraged Direct Initialization

有害な可能性がある型を直接初期化すべきでないこと

``` swift
// bad
let foo = UIDevice()
let foo = Bundle()

// good
let foo = UIDevice.current
let foo = Bundle.main
let foo = Bundle(path: "bar")
let foo = Bundle(identifier: "bar")
```

### Duplicate Conditions

同じ分岐命令で条件の重複を避けるべきであること

``` swift
// bad
if x < 5, y == "s" {
    foo()
} else if x < 10 {
    bar()
} else if y == "s", x < 5 {
    baz()
}

// good
if x < 5 {
    foo()
}

if x < 5 {
    bar()
}
```

### Duplicate Enum Cases

`enum`で同じ名前の`case`を複数含むべきではないこと

``` swift
// bad
enum PictureImport {
    case add(image: UIImage)
    case addURL(url: URL)
    case add(data: Data)
}

// good
enum PictureImport {
    case addImage(image: UIImage)
    case addData(data: Data)
}
```

### Duplicate Imports

`import`は一回のみ行うべきであること

``` swift
// bad
import Foundation
import Dispatch
import Foundation

// good
import Foundation
import Dispatch
```

### Duplicated Key in Dictionary Literal

キーが重複する辞書を作成しないこと

``` swift
// bad
[
    1: "1",
    2: "2",
    1: "one"
]

// good
[
    1: "1",
    2: "2"
]
```

### Dynamic Inline

`dynamic`と`@inline(__always)`を同時に使用すること

``` swift
// bad
class C {
    @inline(__always) dynamic func f() {}
}

// good
class C {
    dynamic func f() {}
}

class C {
    @inline(__always) func f() {}
}
```

### Empty Enum Arguments

列挙型が連想型と一致しない場合は引数を省略すること

``` swift
// bad
switch foo {
    case .bar(_): break
}

switch foo {
    case .bar(): break
}

// good
switch foo {
    case .bar: break
}
```

### Empty Parameters

`Void ->`ではなく`() ->`を使用すること

``` swift
// bad
let abc: (Void) -> Void = {}

// good
let abc: () -> Void = {}
```

### Empty Parentheses with Trailing Closure

`Trailing Closure`を使う場合、メソッドの呼び出し後に空の括弧を記述しないこと

``` swift
// bad
[1, 2].map() { $0 + 1 }

// good
[1, 2].map { $0 + 1 }
```

### File Length

ファイル内に大量の行数を記述しないこと

``` swift
// #warning 400
// #error 1000

// bad
400: print("swiftlint")
401: print("swiftlint")
402: print("swiftlint")

// good
200: print("swiftlint")
201: print("swiftlint")
202: print("swiftlint")
```

### Prefer For-Where

`for`文内に`if`文が1つのみ存在する場合に`where`句を使用すること

``` swift
// bad
for user in users {
    if user.id == 1 {
        user.myFunction()
    }
}

// good
for user in users where user.id == 1 {
    user.myFunction()
}
```

### Force Cast

`as!`を使用すべきでないこと

``` swift
// bad
NSNumber() as! Int

// good
NSNumber() as? Int
```

### Force Try

`try!`を使用すべきでないこと

``` swift
func a() throws { }

// bad
try! a()

// good
do {
    try a()
} catch {
    // エラー処理
}
```

### Function Body Length

関数内に大量の行数を記述しないこと

``` swift
// #warning 50
// #error 100
```

### Function Parameter Count

関数の引数の数を少なくすること

``` swift
// #warning 5
// #error 8

// bad
func f(a: Int, b: Int, c: Int, d: Int, e: Int, f: Int) {}

// good
func f(a: Int, b: Int, c: Int, d: Int) {}
```

### Generic Type Name

ジェネリック型は英数のみを含み、大文字で始まり、1~20文字であること

``` swift
// bad
func foo<T, U_Foo>(param: U_Foo) -> T {}
func foo<T, u>(param: u) -> T {}

// good
func foo<T, U>(param: U) -> T {}
```

### Identifier Name

識別子名は英数のみを含み、小文字で始まるか、大文字のみを含むこと。また、変数名は長過ぎたり短過ぎたりしないこと

``` swift
// min_length
// #warning 3
// #error 2

// max_length
// #warning 40
// #error 60

// bad
let MyLet = 0
let _myLet = 0
let id = 0

// good
let myLet = 0
```

### Implicit Getter

読み取り専用の`Computed Property`と`subscript`には`get`キーワードを使わないこと

``` swift
// bad
class Foo {
    var foo: Int {
        get {
            return 20
        }
    }
}

// good
class Foo {
    var foo: Int {
        return 20
    }
}
```

### Inclusive Language

識別子は、人種、性別、社会経済的地位に基づく人々のグループに対する差別を回避する包括的な言語を使用すること

``` swift
// bad
let slave = "abc"

// good
let foo = "abc"
```

### Invalid SwiftLint Command

有効なswiftlintコマンドを記述すること

``` swift

// bad
// swiftlint:disable

// good
// swiftlint:disable unused_import
```

### Is Disjoint

`Set.intersection(_:).isEmpty`より`Set.isDisjoint(with:)`を使うこと

``` swift
// bad
_ = Set(syntaxKinds).intersection(commentAndStringKindsSet).isEmpty

// good
_ = Set(syntaxKinds).isDisjoint(with: commentAndStringKindsSet)
```

### Large Tuple

`Tuple`に多くのメンバーを持たないこと

``` swift
// bad
let foo: (Int, Int, Int)

// good
let foo: (Int, Int)
```

### Leading Whitespace

ファイルの先頭にスペースを含めないこと

``` swift
// bad
 // foo

// good
// foo
```

### Legacy CGGeometry Functions

構造体の`extension`のプロパティ、メソッドは従来の関数より優先すること

``` swift
// bad
CGRectGetWidth(rect)
CGRectGetHeight(rect)
CGRectGetMinX(rect)
CGRectGetMidX(rect)
CGRectGetMaxX(rect)
CGRectGetMinY(rect)
CGRectGetMidY(rect)
CGRectGetMaxY(rect)
CGRectIsNull(rect)
CGRectIsEmpty(rect)
CGRectIsInfinite(rect)
CGRectStandardize(rect)
CGRectIntegral(rect)
CGRectInset(rect, 10, 5)
CGRectOffset(rect, -2, 8.3)
CGRectUnion(rect1, rect2)
CGRectIntersection(rect1, rect2)
CGRectContainsRect(rect1, rect2)
CGRectContainsPoint(rect, point)
CGRectIntersectsRect(rect1, rect2)

// good
rect.width
rect.height
rect.minX
rect.midX
rect.maxX
rect.minY
rect.midY
rect.maxY
rect.isNull
rect.isEmpty
rect.isInfinite
rect.standardized
rect.integral
rect.insetBy(dx: 5.0, dy: -7.0)
rect.offsetBy(dx: 5.0, dy: -7.0)
rect1.union(rect2)
rect1.intersect(rect2)
rect1.contains(rect2)
rect.contains(point)
rect1.intersects(rect2)
```

### Legacy Constant

構造スコープ定数は従来のグローバル定数を優先すること

``` swift
// bad
CGRectInfinite
CGPointZero
CGRectZero
CGSizeZero
NSZeroPoint
NSZeroRect
NSZeroSize
CGRectNull
CGFloat(M_PI)
Float(M_PI)

// good
CGRect.infinite
CGPoint.zero
CGRect.zero
CGSize.zero
NSPoint.zero
NSRect.zero
NSSize.zero
CGRect.null
CGFloat.pi
Float.pi
```

### Legacy Constructor

コンストラクタは従来の`Convenience`関数より優先すること

``` swift
// bad
CGPointMake(10, 10)
CGPointMake(xVal, yVal)
CGPointMake(calculateX(), 10)
CGSizeMake(10, 10)
CGSizeMake(aWidth, aHeight)
CGRectMake(0, 0, 10, 10)
CGRectMake(xVal, yVal, width, height)
CGVectorMake(10, 10)
CGVectorMake(deltaX, deltaY)
NSMakePoint(10, 10)
NSMakePoint(xVal, yVal)
NSMakeSize(10, 10)
NSMakeSize(aWidth, aHeight)
NSMakeRect(0, 0, 10, 10)
NSMakeRect(xVal, yVal, width, height)
NSMakeRange(10, 1)
NSMakeRange(loc, len)
UIEdgeInsetsMake(0, 0, 10, 10)
UIEdgeInsetsMake(top, left, bottom, right)
NSEdgeInsetsMake(0, 0, 10, 10)
NSEdgeInsetsMake(top, left, bottom, right)
CGVectorMake(10, 10)
NSMakeRange(10, 1)
UIOffsetMake(0, 10)
UIOffsetMake(horizontal, vertical)

// good
CGPoint(x: 10, y: 10)
CGPoint(x: xValue, y: yValue)
CGSize(width: 10, height: 10)
CGSize(width: aWidth, height: aHeight)
CGRect(x: 0, y: 0, width: 10, height: 10)
CGRect(x: xVal, y: yVal, width: aWidth, height: aHeight)
CGVector(dx: 10, dy: 10)
CGVector(dx: deltaX, dy: deltaY)
NSPoint(x: 10, y: 10)
NSPoint(x: xValue, y: yValue)
NSSize(width: 10, height: 10)
NSSize(width: aWidth, height: aHeight)
NSRect(x: 0, y: 0, width: 10, height: 10)
NSRect(x: xVal, y: yVal, width: aWidth, height: aHeight)
NSRange(location: 10, length: 1)
NSRange(location: loc, length: len)
UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 10)
UIEdgeInsets(top: aTop, left: aLeft, bottom: aBottom, right: aRight)
NSEdgeInsets(top: 0, left: 0, bottom: 10, right: 10)
NSEdgeInsets(top: aTop, left: aLeft, bottom: aBottom, right: aRight)
UIOffset(horizontal: 0, vertical: 10)
UIOffset(horizontal: horizontal, vertical: vertical)
```

### Legacy Hashing

`hashValue`をオーバーライドせずに`hash(info:)`関数を使用すること

``` swift
// bad
struct Foo: Hashable {
    let bar: Int = 10

    public var hashValue: Int {
        return bar
    }
}

// good
struct Foo: Hashable {
    let bar: Int = 10

    func hash(into hasher: inout Hasher) {
        hasher.combine(bar)
    }
}
```

### Legacy NSGeometry Functions

従来の関数より構造体の`extension`のプロパティとメソッドを使用すること

``` swift
// bad
NSWidth(rect)
NSHeight(rect)
NSMinX(rect)
NSMidX(rect)
NSMaxX(rect)
NSMinY(rect)
NSMidY(rect)
NSMaxY(rect)
NSEqualRects(rect1, rect2)
NSEqualSizes(size1, size2)
NSEqualPoints(point1, point2)
NSEdgeInsetsEqual(insets2, insets2)
NSIsEmptyRect(rect)
NSIntegralRect(rect)
NSInsetRect(rect, 10, 5)
NSOffsetRect(rect, -2, 8.3)
NSUnionRect(rect1, rect2)
NSIntersectionRect(rect1, rect2)
NSContainsRect(rect1, rect2)
NSPointInRect(rect, point)
NSIntersectsRect(rect1, rect2)

// good
rect.width
rect.height
rect.minX
rect.midX
rect.maxX
rect.minY
rect.midY
rect.maxY
rect.isEmpty
rect.integral
rect.insetBy(dx: 5.0, dy: -7.0)
rect.offsetBy(dx: 5.0, dy: -7.0)
rect1.union(rect2)
rect1.intersect(rect2)
rect1.contains(rect2)
rect.contains(point)
rect1.intersects(rect2)
```

### Legacy Random

`type.random(in:)`の使用を優先すること

``` swift
// bad
arc4random()

// good
Int.random(in: 0..<10)
```

### Line Length

1行に多くの文字を含めないこと

``` swift
// #warning 120
// #error 200
```

### Mark

`MARK`コメントが有効な形式であること

``` swift
// bad
//MARK: bad
// MARK:bad
// MARK: -bad
// MARK:- bad
// MARK bad

// good
// MARK: good
// MARK: - good
// MARK: -
```

### Multiple Closures with Trailing Closure

複数のクロージャを引数とする場合に`Trailing Closure`を使用しないこと

``` swift
// bad
foo.something(param1: { $0 }) { $0 + 1 }

// good
foo.something(param1: { $0 }, param2: { $0 + 1 })
```

### Nesting

型は最大1レベル、ステートメントは最大5レベルの深さでネストすること

``` swift
// type_level
// #warning 1

// function_level
// #warning 2


// bad
class A { class B { class C {} } }

// good
class A { class B {} }
```

### No Fallthrough only

`case`に少なくとも1つのステートメントが含まれている場合のみ、`fallthrough`を使うこと

``` swift
// bad
switch myvar {
case 1:
    fallthrough
case 2:
    var a = 2
}

// good
switch myvar {
case 1:
    var a = 1
    fallthrough
case 2:
    var a = 2
}

switch myvar {
case 1, 2:
    var a = 2
}
```

### No Space in Method Call

メソッド名と括弧の間にスペースを入れないこと

``` swift
// bad
foo ()

// good
foo()
```

### Non-Optional String <-> Data Conversion

`String`と`Data`間の変換時に`UTF-8`エンコードされた文字列を優先する

``` swift
// bad
"foo".data(using: .utf8)
String(data: data, encoding: .utf8)

// good
Data("foo".utf8)
String(decoding: data, as: UTF8.self)
```

### Notification Center Detachment

オブジェクトは`deinit`のみ自分自身のオブザーバを削除すること

``` swift
// bad
class Foo {
    func bar() {
        NotificationCenter.default.removeObserver(self)
    }
}

// good
class Foo {
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
```

### NSNumber Init as Function Reference

`NSNumber.init`または`NSDecimalNumber.init`を関数参照として渡さないこと

``` swift
// bad
[0, 0.2].map(NSNumber.init)
[0, 0.2].map(NSDecimalNumber.init)

// good
[0, 0.2].map(NSNumber.init(value:))
[0, 0.2].map(NSDecimalNumber.init(value:))
```

### NSObject Prefer isEqual

`NSObject`のサブクラスは`==`の代わりに`isEqual`を使用すること

``` swift
// bad
class AClass: NSObject {
    static func ==(lhs: AClass, rhs: AClass) -> Bool {
        return false
    }
}

// good
class AClass: NSObject {
    override func isEqual(_ object: Any?) -> Bool {
        return true
    }
}
```

### Operator Function Whitespace

演算子の定義時、1つの半角スペースで囲まれていること

``` swift
// bad
func <|(lhs: Int, rhs: Int) -> Int {}
func <|  (lhs: Int, rhs: Int) -> Int {}

// good
func <| (lhs: Int, rhs: Int) -> Int {}
```

### Orphaned Doc Comment

`doc`コメントは宣言に添付されるべきであること

``` swift
// bad
/// My great property
// Not a doc string
var myGreatProperty: String!

// good
/// My great property
var myGreatProperty: String!
```

### Private over Fileprivate

`fileprivate`より`private`を使用すること

``` swift
// bad
fileprivate enum MyEnum {}

// good
private enum MyEnum {}
```

### Private Unit Test

`private`の単体テストが暗黙的にスキップされるのを防ぐこと

``` swift
// bad
private class FooTests: XCTestCase {
   func test1() {}
}

class FooTests: XCTestCase {
    // bad
    private func test1() {}

    // good
    func test1() {}
 }
```

### Protocol Property Accessors Order

プロトコルでプロパティを定義する時は、順番を`getter -> setter`にすること

``` swift
protocol Foo {
    // bad
    var bar: String { set get }

    // good
    var bar: String { set }
    var bar: String { get }
    var bar: String { get set }
}
```

### Reduce Boolean

`reduce(true)`, `reduce(false)`よりも`.allSatisfy()`, `.contains()`を優先すること

``` swift
// bad
let allNines = nums.reduce(true) { $0.0 && $0.1 == 9 }
let allValid = validators.reduce(true, { $0 && $1(input) })

// good
nums.reduce(0) { $0.0 + $0.1 }
nums.reduce(initial: true) { $0.0 && $0.1 == 3 }
```

### Redundant Discardable Let

関数の戻り値を使わずに実行する場合、`let _ = foo()`より`_ = foo()`を優先すること

``` swift
// bad
let _ = foo()
if let _ = foo() {}
guard let _ = foo() else { return }

// good
_ = foo()
```

### Redundant @objc Attribute

冗長な`@objc`を避けること

``` swift
// bad
@objc @IBAction private func foo(_ sender: Any) {}

// good
@IBAction private func foo(_ sender: Any) {}
```

### Redundant Optional Initialization

オプショナル型の変数を`nil`で初期化するのを避けること

``` swift
// bad
var myVar: Int? = nil

// good
var myVar: Int?
var myVar: Int? = 0
```

### Redundant Access Control for Setter

プロパティの`setter`のアクセスレベルは、変数のアクセスレベルと同じなら明示しないこと

``` swift
// bad
private(set) private var foo: Int
fileprivate(set) fileprivate var foo: Int
internal(set) internal var foo: Int

// good
private(set) public var foo: Int
public let foo: Int
public var foo: Int
```

### Redundant String Enum Value

文字列列の列挙値は、列挙ケース名と等しい場合は省略すること

``` swift
// bad
enum Numbers: String {
  case one = "one"
  case two = "two"
}

// good
enum Numbers: String {
  case one
  case two
}
```

### Redundant Void Return

関数の定義で戻り値が`Void`の場合は省略すること

``` swift
// bad
func foo() -> Void {}
func foo() -> () {}

// good
func foo() {}
let foo: Int -> Void
```

### Returning Whitespace

戻り値の矢印と型は1つの半角スペースまたは別の行で区切ること

``` swift
// bad
func abc()-> Int {}
func abc() ->Int {}
func abc()->Int {}

// good
func abc() -> Int {}
```

### Self in Property Initialization

`Initialization Property`の初期化時に`self`を参照しないこと、参照する場合は`lazy`で定義すること

``` swift
// bad
class View: UIView {
    var button: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
}

// good
class View: UIView {
    lazy var button: UIButton = {
        let button = UIButton()
        button.addTarget(
            self,
            action: #selector(didTapButton),
            for: .touchUpInside
        )
        return button
    }()
}
```

### Shorthand Operator

省略形の演算子を使用すること

``` swift
// bad
foo = foo + 1
foo = foo - 1
foo = foo * 1
foo = foo / 1

// good
foo += 1
foo -= 1
foo *= 1
foo /= 1
```

### Statement Position

`else`と`catch`は前の定義の1つの半角スペースの後ろで同じ行にあること

``` swift
// bad
}else {

}
catch {

// good
} else {

} catch {
```

### Static Over Final Class

オーバーライド不可能な宣言は、`final`クラスよりも`static`を優先すること

``` swift
// bad
class C {
    final class func f() {}
}

final class C {
    class func f() {}
}

// good
class C {
    static func f() {}
}

class C {
    class func f() {}
}
```

### Superfluous Disable Command

無効されたルールが無効された領域で違反を起こさなかった場合、`disable`コマンドが不要であること

### Switch and Case Statement Alignment

`case`文は`switch`文と同じインデントにすること

``` swift
// bad
switch someBool {
    case true:
        print("red")
    case false:
        print("blue")
}

// good
switch someBool {
case true:
    print("red")
case false:
    print("blue")
}
```

### Syntactic Sugar

糖衣構文を優先すること

``` swift
// bad
let x: Array<String>
let x: Dictionary<Int, String>
let x: Optional<Int>
let x: ImplicitlyUnwrappedOptional<Int>

// good
let x: [String]
let x: [Int: String]
let x: Int?
let x: Int!
```

### Todo

`TODO`と`FIXME`は解決すべきものとして警告を出すこと

``` swift
// bad
// TODO:
// FIXME:
```

### Trailing Comma

配列や辞書の末尾の`,`を避けること

``` swift
// bad
let array = [1, 2, 3,]
let dictionary = ["foo": 1, "bar": 2,]

// good
let array = [1, 2, 3]
let dictionary = ["foo": 1, "bar": 2]
```

### Trailing Newline

ファイルの末尾に1つの改行をすること

``` swift
// bad
class {
    var test = ""
}

// good
class {
    var test = ""
}

```

### Trailing Semicolon

行の末尾にセミコロンを付けないこと

``` swift
// bad
let a = 0;

// good
let a = 0
```

### Trailing Whitespace

行の末尾に半角スペースを付けないこと

``` swift
// bad
let a = 1 

// good
let a = 1
```

### Type Body Length

型内に大量の行数を記述しないこと

``` swift
// #wanring 250
// #error 350
```

### Type Name

型名は英数のみを含み、大文字で始まり、3~40文字にすること

``` swift
// bad
class My_Type {}
class myType {}
class aa {}

// good
class MyType {}
```

### Unavailable Condition

処理がない場合は、`#available/#unavailable`の代わりに`#unavailable/#available`を使用すること

``` swift
// bad
if #available(iOS 13, *) {} else {
  loadMainWindow()
}

if #unavailable(iOS 13) {
  // Do nothing
} else if i < 2 {
  loadMainWindow()
}

// good
if #unavailable(iOS 13) {
  loadMainWindow()
}

if #available(iOS 9.0, *) {
  doSomething()
} else {
  legacyDoSomething()
}
```

### Unneeded Break in Switch

不要な`break`を避けること

``` swift
switch a {
// bad
case .foo:
    something()
    break

// good
case .bar:
    something()
case .baz:
    break
case .qux:
    for i in [0, 1, 2] { break }
}
```

### Unneeded Overridden Functions

オーバーライドしただけの関数の場合は削除すること

``` swift
// bad
class Foo {
    override func bar() async {
        await super.bar()
    }
}

// good
class Foo {
    override func bar() async throws {
        // Doing a different variation of 'try' changes behavior
        await try! super.bar()
    }
}
```

### Unneeded Synthesized Initializer

自動で作成されるイニシャライザを手動で定義しないこと

``` swift
// bad
struct Foo {
    let bar: String

    init(bar: String) {
        self.bar = bar
    }
}

// good
struct Foo {
    let bar: String

    // Synthesized initializer would not be private.
    private init(bar: String) {
        self.bar = bar
    }
}
```

### Unused Closure Parameter

クロージャの未使用パラメータは`_`を使用すること

``` swift
// bad
[1, 2].map { number in
    3
}

// good
[1, 2].map { _ in
    3
}

[1, 2].map { number in
    number + 1
}

[1, 2].map { $0 + 1 }
```

### Unused Control Flow Label

未使用の制御フローラベルは削除すること

``` swift
// bad
loop: while true { break }

// good
loop: while true { break loop }
loop: while true { continue loop }
```

### Unused Enumerated

`index`もしくは`element`が使われていない場合、`.enumerated()`を使わないこと

``` swift
// bad
for (_, foo) in bar.enumerated() {}

// good
for (idx, foo) in bar.enumerated() {}
```

### Unused Optional Binding

`let _ =`より`!= nil`を使用すること

``` swift
// bad
if let _ = a {}

// good
if a != nil {}
```

### Unused Setter Value

`setter`の値(`newValue`)を使用すること

``` swift
var aValue: String {
    get {
        return Persister.shared.aValue
    }
    set {
        // bad
        Persister.shared.aValue = aValue
        // good
        Persister.shared.aValue = newValue
    }
    // bad
    set { }
}
```

### Valid IBInspectable

`@IBInspectable`はサポートされている型の変数のみに使い、その型を明示的にすること

``` swift
class Foo {
    // bad
    @IBInspectable private let count: Int
    @IBInspectable private var count = 0
    @IBInspectable private var count: Int?
    @IBInspectable private var count: Int!

    // good
    @IBInspectable private var count: Int
    @IBInspectable private var count: Int = 0
}
```

### Vertical Parameter Alignment

関数の定義時、パラメータが複数行にまたがっている場合に垂直方向で揃えること

``` swift
// bad
func validateFunction(_ file: File, kind: SwiftDeclarationKind,
                    dictionary: [String: SourceKitRepresentable]) {}
func validateFunction(_ file: File, kind: SwiftDeclarationKind,
                       dictionary: [String: SourceKitRepresentable]) {}

// good
func validateFunction(_ file: File, kind: SwiftDeclarationKind,
                      dictionary: [String: SourceKitRepresentable]) {}
```

### Vertical Whitespace

空白行は1行に制限すること

### Void Function in Ternary

`Void`関数の呼び出しに3項演算子の使用を避けること

``` swift
// bad
success ? askQuestion() : exit()

// good
let result = success ? foo() : bar()
```

### Void Return

`-> ()`より`-> Void`を使用すること

``` swift
// bad
let abc: () -> () = {}

// good
let abc: () -> Void = {}
```

### XCTFail Message

`XCTFail`の呼び出しにアサーションの説明を含めること

``` swift
func testFoo() {
    // bad
    XCTFail()

    // good
    XCTFail("bar")
}
```

## Opt-in Rules

### Accessibility Label for Image

コンテキストを提供する画像は、アクセシビリティラベルを付けるか、アクセシビリティから明示的に隠すべきであること

``` swift
// bad
struct MyView: View {
    var body: some View {
        Image(systemName: "circle.plus")
    }
}

// good
struct MyView: View {
    var body: some View {
        Image(decorative: "my-image")
    }
}

struct MyView: View {
    var body: some View {
        Image("my-image")
            .accessibility(label: Text("Alt text for my image"))
    }
}

struct MyView: View {
    var body: some View {
        Image("my-image")
            .accessibilityHidden(true)
    }
}
```

### Accessibility Trait for Button

タップジェスチャーが追加されたすべてのビューに`.isButton`または`.isLink`アクセシビリティ特性を含めること

``` swift
// bad
struct MyView: View {
    var body: some View {
        Text("Learn more")
            .onTapGesture {
                print("tapped")
            }
    }
}

// good
struct MyView: View {
    var body: some View {
        Text("Learn more")
            .onTapGesture {
                print("tapped - open URL")
            }
            .accessibility(addTraits: .isLink)
    }
}
```

### Anonymous Argument in Multiline Closure

複数行のクロージャでは名前付き引数を使用すること

``` swift
// bad
closure {
    print(↓$0)
}

// good
closure { print($0) }

closure { arg in
    print(arg)
}
```

### AnyObject Protocol

クラス専用のプロトコルでは`class`より`AnyObject`を使用すること

``` swift
// bad
protocol SomeClassOnlyProtocol: class {}

// good
protocol SomeClassOnlyProtocol: AnyObject {}
```

### Array Init

`Sequence`を配列に変換する場合、`seq.map { $0 }`より`Array(seq)`を使用すること

``` swift
// bad
seq.map { $0 }

// good
Array(seq)
```

### Attributes

属性や関数や型では別の行にあるべきだが、変数や`import`は同じ行にあること

``` swift
// bad
@available(iOS 9.0, *) func animate(view: UIStackView)

@available(iOS 9.0, *) class UIStackView

@objc
var x: String

@testable
import SourceKittenFramework

// good
@available(iOS 9.0, *)
func animate(view: UIStackView)

@available(iOS 9.0, *)
class UIStackView

@objc var x: String

@testable import SourceKittenFramework
```

### Balanced XCTest Life Cycle

テストクラスでは`setUp`と`tearDown`をペアで作成すること

``` swift
// bad
final class BarTests: XCTestCase {
    override func tearDownWithError() throws {}
}

// good
final class FooTests: XCTestCase {
    override func setUp() {}
    override func tearDown() {}
}
```

### Closure Body

クロージャ内に大量の行数を記述しないこと

``` swift
// #warning 30
// #error 100
```

### Closure End Indentation

クロージャの終了は開始と同様のインデントに揃えること

``` swift
// bad
SignalProducer(values: [1, 2, 3])
    .startWithNext { number in
        print(number)
}

// good
SignalProducer(values: [1, 2, 3])
    .startWithNext { number in
        print(number)
    }

[1, 2].map { $0 + 1 }
```

### Closure Spacing

クロージャ内は各括弧の内側に1つの半角スペースがあること

``` swift
// bad
[].filter {$0.contains(location)}

// good
[].filter { $0.contains(location) }
```

### Collection Element Alignment

コレクション内の全要素が垂直方向に揃っていること

``` swift
// bad
let abc = [
    "alpha": "a",
      "beta": "b",
    "gamma": "g",
    "delta": "d",
   "epsilon": "e"
]

// good
let abc = [
    "alpha": "a",
    "beta": "b",
    "gamma": "g",
    "delta": "d",
    "epsilon": "e"
]

let abc = [1, 2, 3, 4]

let abc = [
    1, 2, 3, 4
]
```

### Comma Inheritance Rule

複数の継承を記述する際には`,`を使用すること

``` swift
// bad
struct A: Codable & Equatable {}
struct A: Codable & Equatable {}
protocol D: Codable & Equatable {}

// good
struct A: Codable, Equatable {}
enum B: Codable, Equatable {}
class C: Codable, Equatable {}
```

### Conditional Returns on Newline

条件文では次の行でリターンすること

``` swift
// bad
guard true else { return }

// good
guard true else {
    return true
}
```

### Contains over Filter Count

`filter(where:).count`を0と比較するよりも、`includes`を優先すること

``` swift
// bad
let result = myList.filter(where: { $0 % 2 == 0 }).count > 0
let result = myList.filter(where: someFunction).count == 0

// good
let result = myList.filter(where: { $0 % 2 == 0 }).count > 1
let result = myList.filter { $0 % 2 == 0 }.count != 1
```

### Contains over Filter is Empty

`filter(where:).isEmpty`よりも`contains`を優先すること

``` swift
// bad
let result = myList.filter(where: { $0 % 2 == 0 }).isEmpty
let result = ↓myList.filter(where: someFunction).isEmpty

// good
let result = myList.filter(where: { $0 % 2 == 0 }).count > 1
let result = myList.contains(10)
```

### Contains over First not Nil

`first(where:) != nil`よりも`contains`を優先すること

``` swift
// bad
myList.first { $0 % 2 == 0 } != nil
myList.first(where: { $0 % 2 == 0 }) != nil

// good
myList.contains { $0 % 2 == 0 }
myList.contains(where: { $0 % 2 == 0 })
```

### Contains over Range Comparison to Nil

範囲`(of:) != nil`, `(of:) == nil`よりも`contains`を優先すること

``` swift
// bad
myString.range(of: "Test") != nil
myString.range(of: "Test") == nil

// good
let range = myString.range(of: "Test")
myString.contains("Test")
```

### Convenience Type

静的メンバーのみをホストするために使われる型は、インスタンス化を回避するために、`case`のない列挙型にすること

``` swift
// bad
struct Math {
    public static let pi = 3.14
}

class Math {
    public static let pi = 3.14
}

// good
enum Math {
    public static let pi = 3.14
}
```

### Direct Return

直接値を返せる場合は変数を定義せずにそのまま返すこと

``` swift
// bad
func f() -> Int {
    let b = 2
    return b
}

// good
func f() -> Int {
    let b = 2
    let a = 1
    return b
}
```

### Discarded Notification Center Observer

ブロックを使用して通知を登録する場合、返される不透明なオブザーバーは、後で削除できるように保存できるようにしておくこと

``` swift
// bad
nc.addObserver(
    forName: .NSSystemTimeZoneDidChange,
    object: nil,
    queue: nil
) {}

// good
let foo = nc.addObserver(
    forName: .NSSystemTimeZoneDidChange,
    object: nil,
    queue: nil
) {}
```

### Discouraged Assert

`assert(false)`よりも`assertionFailure()`や`preconditionFailure()`を優先すること

``` swift
// bad
assert(false)
assert(false, "foobar")

// good
assert(true, "foobar")
assert(true, "foobar", file: "toto", line: 42)
```

### Discouraged None Name

名前衝突可能性のある`none`という名前の静的メンバを使用しないこと

``` swift
// bad
enum MyEnum {
    case none
}

// good
enum MyEnum {
    case nOne
}
```

### Discouraged Object Literal

オブジェクトリテラルよりイニシャライザを使用すること

``` swift
// bad
let image = #imageLiteral(resourceName: "image.jpg")
let color = #colorLiteral(red: value, green: value, blue: value, alpha: 1)

// good
let image = UIImage(named: "image")
let color = UIColor(red: value, green: value, blue: value, alpha: 1)
```

### Discouraged Optional Boolean

オプショナルではない`Bool`型を使用しないこと

``` swift
// bad
var foo: Bool?

// good
var foo: Bool
```

### Discouraged Optional Collection

オプショナルのコレクションより空のコレクションを使用すること

``` swift
// bad
var foo: [Int]?
var foo: [String: Int]?
let foo: [Int]? = nil
let foo: [String: Int]? = nil

// good
var foo: [Int]
var foo: [String: Int]
let foo: [Int] = []
let foo: [String: Int] = [:]
```

### Empty Collection Literal

コレクションを空の配列または辞書リテラルと比較するよりも`isEmpty`の使用を優先すること

``` swift
// bad
myArray == []
myDict != [:]

// good
myArray = []
myArray.isEmpty
!myArray.isEmpty
myDict = [:]
```

### Empty Count

`count`を0と比較するよりも`isEmpty`を使用すること

``` swift
// bad
[Int]().count == 0
[Int]().count > 0
[Int]().count != 0

// good
[Int]().isEmpty
```

### Empty String

空の文字列を比較するよりも`isEmpty`を使用すること

``` swift
// bad
myString == ""
myString != ""

// good
myString.isEmpty
!myString.isEmpty
```

### Empty XCTest Method

空の`XCTest`メソッドを実装しないこと

``` swift
// bad
class TotoTests: XCTestCase {
    override func setUp() {}
    override func tearDown() {}
    func testFoo() {}
}

// good
class TotoTests: XCTestCase {
    var foobar: Foobar?

    override func setUp() {
        super.setUp()
        foobar = Foobar()
    }

    override func tearDown() {
        foobar = nil
        super.tearDown()
    }

    func testFoo() {
        XCTAssertTrue(foobar?.foo)
    }

    func helperFunction() {}
}
```

### Enum Case Associated Values Count

列挙型の場合、関連する値の数を少なくすること

``` swift
// #warning 5
// #error 6

// bad
enum Barcode {
    case upc(Int, Int, Int, Int, Int, Int)
}

// good
enum Barcode {
    case upc(Int, Int, Int, Int)
}
```

### Expiring Todo

`TODO`と`FIXME`は、有効期限が切れる前に解決すること

``` swift
// bad
// FIXME: [10/14/2019]

// good
// TODO: [12/31/9999]
```

### Explicit ACL

すべての定義はアクセス制御レベルのキーワードを明示的に指定すること

``` swift
// bad
enum A { }

// good
internal enum A { }
```

### Explicit Enum Raw Value

列挙型の`rawValue`を明示的に割り当てること

``` swift
// bad
enum Numbers: Int {
    case one
    case two
}

// good
enum Numbers: Int {
    case one = 1
    case two = 2
}
```

### Explicit Init

`.init()`を明示的に呼び出されないこと

``` swift
// bad
[1].flatMap { String.init($0) }
[String.self].map { Type in Type.init(1) }

// good
[1].flatMap(String.init)
[String.self].map { $0.init(1) }
[String.self].map { type in type.init(1) }
```

### Explicit Top Level ACL

トップレベルの宣言では、アクセス制御レベルのキーワードを明示的に指定すること

``` swift
// bad
enum A {
    enum B { }
}

// good
internal enum A {
    enum B { }
}
```

### Explicit Type Interface

プロパティは型インターフェイスを持つこと

``` swift
// bad
class Foo {
  var myVar = 0
}

// good
class Foo {
  var myVar: Int? = 0
}
```

### Extension Access Modifier

`extension`にアクセス修飾子を使用すること

``` swift
// bad
extension Foo {
    public var bar: Int { return 1 }
    public var baz: Int { return 1 }
}

// good
public extension Foo {
    var bar: Int { return 1 }
    var baz: Int { return 1 }
}
```

### Fallthrough

`fallthrough`を使用しないこと

``` swift
// bad
switch foo {
case .bar:
    fallthrough
case .bar2:
    something()
}

// good
switch foo {
case .bar, .bar2:
    something()
}

```

### Fatal Error Message

`fatalError`をメッセージを付けて呼び出すこと

``` swift
// bad
func foo() {
    fatalError()
}

// good
func foo() {
    fatalError("Foo")
}
```

### File Header

ヘッダーコメントをプロジェクトパターンと一致させること

``` swift
// bad
// Copyright

// good
let foo = 2 // Copyright
```

### File Name

ファイル名はファイル内で定義されている型または`extension`と一致させること

### File Name no Space

ファイル名に空白を含めないこと

### File Types Order

ファイル内の型をルールに沿って並べること

### Final Test Case

テストケースのクラスに`final`を付けること

``` swift
// bad
class Test: XCTestCase {}

// good
final class Test: XCTestCase {}
```

### First Where

コレクションでは`.filter {}.first`より`.first(where:)`を使用すること

``` swift
// bad
myList.filter { $0 % 2 == 0 } .first

// good
myList.first(where: { $0 % 2 == 0 })
myList.first { $0 % 2 == 0 }
```

### Flat Map over Map Reduce

`map`よりも`flatMap`を優先し、`reduce([], +)`を使用すること

``` swift
// bad
let foo = bar.map { $0.count }.reduce(0, +)

// good
let foo = bar.map { $0.array }.reduce([], +)
let foo = bar.flatMap { $0.array }
```

### Force Unwrapping

強制アンラップ`!`を使用しないこと

``` swift
// bad
let url = NSURL(string: query)!

// good
if let url = NSURL(string: query) {}
```

### Function Default Parameter at End

関数でデフォルト値を持つ引数を後ろにまとめること

``` swift
// bad
func foo(y: Int = 0, x: String, z: CGFloat = 0) {}

// good
func foo(x: String, y: Int = 0, z: CGFloat = 0) {}
```

### IBInspectable in Extension

`extension`に`@IBInspectable`プロパティを追加しないこと

``` swift
// bad
extension Foo {
    @IBInspectable private var x: Int
}

// good
class Foo {
    @IBInspectable private var x: Int
}
```

### Identical Operands

同一のオペラントを比較しないこと

``` swift
// bad
foo == foo

// good
foo == bar
```

### Implicit Return

クロージャでは暗黙のリターンを優先すること

``` swift
// bad
foo.map {
    return $0 + 1
}

// good
foo.map { $0 + 1 }
```

### Implicitly Unwrapped Optional

暗黙的にアンラップされるオプショナル型を使用しないこと

``` swift
// bad
private var label: UILabel!
let int: Int! = 42

// good
@IBOutlet private var label: UILabel!
let int: Int? = 42
```

### Indentation Width

タブ1つまたは設定されたスペース数でコードをインデントし、前のインデントと同じになるようにインデントを揃えること

``` swift
// bad
firstLine
    secondLine
        thirdLine
  fourthLine

// good
firstLine
    secondLine
        thirdLine
fourthLine
```

### Inert Defer

`defer`が親スコープの末尾に配置しないこと

``` swift
// bad
func example1() {
    defer { /* deferred code */ }
    // comment
}

// good
func example3() {
    defer { /* deferred code */ }

    print("other code")
}
```

### Joined Default Parameter

デフォルトの区切り文字は明示的に使用しないこと

``` swift
// bad
let foo = bar.joined(separator: "")

// good
let foo = bar.joined()
let foo = bar.joined(separator: ",")
```

### Last Where

コレクションでは`.filter {}.last`より`.last(where:)`を使用すること

``` swift
// bad
myList.filter { $0 % 2 == 0 } .last

// good
myList.last(where: { $0 % 2 == 0 })
```

### Legacy Multiple

余り演算子`%`を使用するよりも`isMultiple(of:)`を優先すること

``` swift
// bad
cell.contentView.backgroundColor = indexPath.row.isMultiple(of: 2) ? .gray : .white

// good
cell.contentView.backgroundColor = indexPath.row % 2 == 0 ? .gray : .white
```

### Legacy Objective-C Reference Type

ブリッジされた`Objective-C`の参照型よりも`Swift`の値型を優先すること

``` swift
// bad
var array = NSArray()
_ = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
_ = NSNotification.Name("com.apple.Music.playerInfo")

// good
var array = Array<Int>()
var calendar: Calendar? = nil
var formatter: NSDataDetector
```

### Variable Declaration Whitespace

`let`と`var`は他の記述とは空白行で区切ること

``` swift
// bad
let a = 0
var x = 1
x = 2

// good
let a = 0
var x = 1

x = 2
```

### Literal Expression End Indentation

配列と辞書のリテラルの末尾は、開始行と同様のインデントを持つこと

``` swift
// bad
let x = [
    1,
    2
    ]

// good
[1, 2, 3]

let x = [
    1,
    2
]

let x = [1,
    2
]

let x = [
    1,
    2]
```

### Local Doc Comment

定義が親よりも低いまたは同じアクセス制御レベルを持つこと

``` swift
// bad
struct Foo {
    public func bar() { }
}

// good
public struct Foo {
    public func bar() { }
}
```

### Lower ACL than Parent

定義が親よりも低いアクセス制御レベルであることを保証すること

``` swift
// bad
struct Foo { public func bar() {} }

// good
public struct Foo { public func bar() {} }
```

### Missing Docs

定義をドキュメント化すること

``` swift
// good
/// docs
public class A {
    /// docs
    public func b() { }
}
/// docs
public class B: A {
    // オーバーライドメソッドはOK
    override public func b() { }
}
```

### Modifier Order

修飾子は一貫した順番であること

``` swift
public class Foo {
    // bad
    convenience required public init() { }
    static public let bar = 42

    // good
    public convenience required init() { }
    public static let bar = 42
}
```

### Multiline Arguments

引数は同じ行に入れるか1行に1つずつ入れること

``` swift
// bad
func foo(
    param1: "Param1", param2: "Param2",
    param3: "Param3"
)

// good
func foo(param1: "Param1", param2: "Param2", param3: "Param3")

func foo(
    param1: "Param1",
    param2: "Param2",
    param3: "Param3"
)
```

### Multiline Arguments Brackets

複数行の引数は、それらを括る大括弧を新しい行に持つこと

``` swift
// bad
foo(param1: "Param1",
    param2: "Param2"
)
foo(
    param1: "Param1",
    param2: "Param2")

// good
foo(param1: "Param1", param2: "Param2")

foo(
    param1: "Param1",
    param2: "Param2"
)
```

### Multiline Function Chains

関数を連鎖的に呼び出す際に、同じ行に入れるか1行に1つずつ入れること

``` swift
// bad
let evenSquaresSum = [20, 17, 35, 4]
    .filter { $0 % 2 == 0 } .map { $0 * $0 }
    .reduce(0, +)

// good
let evenSquaresSum = [20, 17, 35, 4].filter { $0 % 2 == 0 } .map { $0 * $0 } .reduce(0, +)

let evenSquaresSum = [20, 17, 35, 4]
    .filter { $0 % 2 == 0 }
    .map { $0 * $0 }
    .reduce(0, +)

```

### Multiline Literal Brackets

複数行のリテラルは新しい行にそれを括る大括弧に入れること

``` swift
// bad
let trio = ["harry",
            "ronald",
            "hermione"
]

let trio = [
    "harry",
    "ronald",
    "hermione"]

// good
let trio = ["harry", "ronald", "hermione"]

let trio = [
    "harry",
    "ronald",
    "hermione"
]
```

### Multiline Parameters

関数のメソッドの引数は、同様の行にあるか1行に1つずつあること

``` swift
// bad
func foo(param1: Int, param2: Bool,
         param3: [String]) {}

// good
func foo(param1: Int, param2: Bool, param3: [String]) {}

func foo(param1: Int,
         param2: Bool,
         param3: [String]) {}
```

### Multiline Parameters Brackets

複数行の引数は新しい行にそれを括る大括弧に入れること

``` swift
// bad
func foo(param1: "Param1",
         param2: "Param2",
         param3: "Param3"
)

func foo(
    param1: "Param1",
    param2: "Param2",
    param3: "Param3")

// good
func foo(param1: "Param1", param2: "Param2", param3: "Param3")

func foo(
    param1: "Param1",
    param2: "Param2",
    param3: "Param3"
)
```

### Nimble Operator

フリーの`matcher`関数より`Nibmle`演算子のオーバーロードを使用すること

``` swift
//bad
expect(seagull.squawk).to(equal("Hi"))
expect(seagull.squawk).toNot(equal("Hi"))
expect(10).to(beGreaterThan(2))

// good
expect(seagull.squawk) == "Hi!"
expect(seagull.squawk) != "Hi!"
expect(10) > 2
```

### No Extension Access Modifier

`extension`にアクセス修飾子を付けないこと

``` swift
// bad
private extension String { }
fileprivate extension String { }
internal extension String { }
public extension String { }
open extension String { }

// good
extension String { }
```

### No Grouping Extension

`extension`は同じソースファイル内のコードをグループ化するために使用しないこと

``` swift
// bad
enum Fruit { }
extension Fruit { }

// good
// プロトコルのデフォルト実装はOK
protocol Food { }
extension Food { }
```

### No Magic Numbers

マジックナンバーを名前付き定数で定義すること

``` swift
// bad
foo(321)
bar(1_000.005_01)
array[42]

// good
var foo = 123
static let bar: Double = 0.123
let a = b + 1.0
```

### Class Declaration in Final Class

親クラスに`final`の場合は子クラスにも`final`キーワードを付けること

``` swift
// bad
final class C {
    class var b: Bool { true }
    class func f() {}
}

// good
final class C {
    final class var b: Bool { true }
    final class func f() {}
}
```

### NSLocalizedString Key

`genstrings`が機能するために、静的文字列を`NSLocalizedString`のキーとして使用すること

``` swift
// bad
NSLocalizedString(method(), comment: nil)

// good
NSLocalizedString("key", comment: nil)
```

### NSLocalizedString Require Bundle

`NSLocalizedString`の呼び出しに、文字列ファイルを含むバンドルを指定すること

``` swift
// bad
NSLocalizedString("someKey", comment: "test")

// good
NSLocalizedString("someKey", bundle: .main, comment: "test")
```

### Number Separator

`_`は十進数で千の区切りの文字として使用すること

``` swift
// bad
let foo = 1000
let foo = 1000_000.000_000_1
let foo = 1_000_000.000000_1
let foo = 1_0_00_000.000_000_1

// good
let foo = 1_000
let foo = 1_000_000.000_000_1
```

### Object Literal

画像や色はイニシャライザよりリテラルを使って生成すること

``` swift
// bad
let image = UIImage(named: "image")
let color = UIColor(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1.0)

// good
let image = #imageLiteral(resourceName: "image.jpg")
let color = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1.0)

```

### One Declaration per File

ファイル内では1つの宣言にすること

``` swift
// bad
class Foo {}
class Bar {}

// good
class Foo {}
```

### Operator Usage Whitespace

演算子を使う時は1つの半角スペースで囲まれていること

``` swift
// bad
let foo = 1+2
let foo=1+2

// good
let foo = 1 + 2
```

### Optional Enum Case Match

オプショナル型の`enum`をサポートすること

``` swift
// bad
switch foo {
    case .bar?: break
    case .baz: break
    default: break
}

// good
switch foo {
    case .bar: break
    case .baz: break
    default: break
}
```

### Overridden Method Calls Super

一部のオーバーライドメソッドは常に親クラスのメソッドを呼び出すこと

``` swift
// bad
class VC: UIViewController {
    override func viewWillAppear(_ animated: Bool) {}
}

// good
class VC: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func loadView() {}
}
```

### Override in Extension

`extension`で定義をオーバーライドしないこと

``` swift
extension Person {
    // bad
    override var age: Int { return 42 }
    override func celebrateBirthday() {}

    // good
    var age: Int { return 42 }
    func celebrateBirthday() {}
}
```

### Pattern Matching Keywords

キーワードをタプルの外に出し、複数のパターンマッチングバインディングを組み合わせること

``` swift
switch foo {
  // bad
  case (let x, let y):

  // good
  case let (x, y):
}
```

### Period Spacing

ピリオドの後にスペースを1つ以上空けないこと

``` swift
// bad
// Single. Double.  End.
///   - code: Identifier of the error. Integer.

// good
let pi = 3.2
let pi = Double.pi
```

### Prefer Nimble

`XCTAssert`関数よりも`Nimble matcher`を優先すること

``` swift
// bad
XCTAssertTrue(foo)
XCTAssertEqual(foo, 2)

// good
expect(foo) == 1
expect(foo).to(equal(1))
```

### Prefer Self in Static References

周囲の型名を参照するには`Self`を同時に使用すること

``` swift
// bad
class C {
    static let i = 1

    var j: Int {
        let ii = C.i
        return ii
    }
}

// good
class C {
    static let primes = [2, 3, 5, 7]

    func isPrime(i: Int) -> Bool { Self.primes.contains(i) }
}
```

### Prefer Self Type Over Type of Self

プロパティへのアクセスやメソッドの呼び出しにおいて、`type(of: self)`よりも`Self`を優先すること

``` swift
// bad
class Foo {
    func bar() {
        type(of: self).baz()
    }
}

// good
class Foo {
    func bar() {
        Self.baz()
    }
}
```

### Prefer Zero Over Explicit Init

パラメータがゼロの明示的な`init`よりも`.zero`を優先すること

``` swift
// bad
CGPoint(x: 0, y: 0)
CGRect(x: 0, y: 0, width: 0, height: 0)

// good
CGRect(x: 0, y: 0, width: 0, height: 1)
CGSize(width: 2, height: 4)
```

### Prefixed Top-Level Constant

最上位の定位数はプレフィックスに`k`を付けること

``` swift
// bad
let bar = 20.0

// good
let kBar = 20.0

struct Foo {
    let bar = 20.0
}
```

### Private Actions

`@IBAction`を`private`にすること

``` swift
// bad
class Foo {
    @IBAction func barButtonTapped(_ sender: UIButton) {}
}

// good
class Foo {
    @IBAction private func barButtonTapped(_ sender: UIButton) {}
}
```

### Private Outlets

`@IBOutlet`を`private`にすること

``` swift
// bad
class Foo {
    @IBOutlet var label: UILabel?
}

// good
class Foo {
    @IBOutlet private var label: UILabel?
}
```

### Private Combine Subject

`Combine Subject`を`private`にすること

``` swift
// bad
final class Foobar {
    let badSubject = PassthroughSubject<Bool, Never>()
}

// good
final class Foobar {
    private let goodSubject = PassthroughSubject<Bool, Never>()
}
```

### Private SwiftUI State Properties

`SwiftUI @State`を`private`にすること

``` swift
// bad
struct MyApp: App {
    @State var isPlaying: Bool = false
}

// good
struct MyApp: App {
    @State private var isPlaying: Bool = false
}
```

### Prohibited Interface Builder

`IB`を使ってビューを生成するのを避けること

``` swift
class ViewController: UIViewController {
    // bad
    @IBOutlet var label: UILabel!
    @IBAction func buttonTapped(_ sender: UIButton) {}

    // good
    var label: UILabel!
    @objc func buttonTapped(_ sender: UIButton) {}
}
```

### Prohibited Calls to Super

一部のメソッドは親クラスのメソッドを呼び出さないこと

``` swift
// bad
class VC: UIViewController {
    override func loadView() {
        super.loadView()
    }
}
```

### Quick Discouraged Call

`describe`や`context`内で処理を呼び出さないこと

``` swift
class TotoTests: QuickSpec {
    override func spec() {
        describe("foo") {
            // bad
            let foo = Foo()
            context("foo") {
                // bad
                foo.bar()
                it("does something") {
                    // good
                    let foo = Foo()
                    foo.bar()
                }
            }
        }
    }
}
```

### Quick Discouraged Focused Test

一部のみ有効となるテストを実行しないこと

``` swift
class TotoTests: QuickSpec {
    override func spec() {
        // bad
        fdescribe("foo") {}
        fcontext("foo") {}
        fit("foo") {}
        fitBehavesLike("foo")

        // good
        describe("foo") {}
        context("foo") {}
        it("foo") {}
        itBehavesLike("foo")
    }
}
```

### Quick Discouraged Pending Test

一部のみ無効となるテストを実行しないこと

``` swift
class TotoTests: QuickSpec {
    override func spec() {
        // bad
        xdescribe("foo") { }
        xcontext("foo") { }
        xit("foo") { }
        pending("foo")
        xitBehavesLike("foo")

        // good
        describe("foo") { }
        context("foo") { }
        it("foo") { }
        itBehavesLike("foo")
    }
}
```

### Raw Value for Camel Cased Codable Enum

`Codable String enum`のキャメルケースの場合は、`rawValue`を設定すること

``` swift
// bad
enum Status: String, Codable {
    case ok
    case notAcceptable
    case maybeAcceptable = "maybe_acceptable"
}

// good
enum Numbers: Codable {
  case int(Int)
  case short(Int16)
}
```

### Reduce into

`copy-on-write`型には`reduce(_:_:)`よりも`reduce(into:_:)`を優先すること

``` swift
// bad
let bar = values.↓reduce("abc") { $0 + "\($1)" }

values.reduce(Array<Int>()) { result, value in
    result += [value]
}

// good
let foo = values.reduce(into: "abc") { $0 += "\($1)" }

values.reduce(into: Array<Int>()) { result, value in
    result.append(value)
}
```

### Redundant Nil Coalescing

`??`演算子で右辺に`nil`を記述しないこと

``` swift
// bad
var myVar: Int? = nil
myVar ?? nil

// good
var myVar: Int?
myVar ?? 0
```

### Redundant Self in Closure

明示的な`self`を記述しないこと

``` swift
// bad
struct S {
    var x = 0

    func f(_ work: @escaping () -> Void) { work() }

    func g() {
        f {
            self.x = 1
            if self.x == 1 { ↓self.g() }
        }
    }
}

// good
struct S {
    var x = 0

    func f(_ work: @escaping () -> Void) { work() }

    func g() {
        f {
            x = 1
            f { x = 1 }
            g()
        }
    }
}
```

### Redundant Type Annotation

変数は冗長な型アノテーションを記述しないこと

``` swift
// bad
var url: URL = URL()

// good
var url = URL()
var url: CustomStringConvertible = URL()
```

### Required Deinit

クラスで明示的な`deinit`メソッドを持つこと

``` swift
// bad
class Apple {}

// good
class Apple {
    deinit {}
}
```

### Required Enum Case

特定のプロトコルに準拠した列挙型は特定のケースを実装すること

``` swift
// bad
enum MyNetworkResponse: String, NetworkResponsable {
  case success
  case error
}

// good
enum MyNetworkResponse: String, NetworkResponsable {
  case success
  case error
  case notConnected
}

enum MyNetworkResponse: String, NetworkResponsable {
  case success
  case error
  case notConnected(error: Error)
}
```

### Return Value from Void Function

`Void`関数から値を返さないこと

``` swift
// bad
func foo() {
    return bar()
}

// good
func foo() {
    return
}
```

### Self Binding

`self`を一貫性のある識別子名にバインドし直すこと

``` swift
// bad
if let `self` = self { return }
guard let `self` = self else { return }
if let this = self { return }

// good
if let self = self { return }
guard let self = self else { return }
if let this = this { return }
```

### Shorthand Argument

クロージャの先頭から離れた場所で省略記法を参照するのを避けること

``` swift
// bad
f {
    $0
    + $1
    + $2

    + $0
}

// good
f { $0 }
f { $0.a + $0.b }
```

### Shorthand Optional Binding

オプションのバインディングには省略記法を使用すること

``` swift
// bad
if let i = i {}
if let self = self {}
if var `self` = `self` {}
guard let i = i else {}
guard let self = self else {}

// good
if let i {}
if let i = a {}
guard let i = f() else {}
if var i = i() {}
if let i = i as? Foo {}
guard let `self` = self else {}
while var i { i = nil }
```

### Single Test Class

テストファイルは単一の`QuickSpec`または`XCTestCase`クラスを含めること

``` swift
// bad
class FooTests: QuickSpec {}
class BarTests: QuickSpec {}

class FooTests: XCTestCase {}
class BarTests: XCTestCase {}

class FooTests: XCTestCase {}
class BarTests: QuickSpec {}

// good
class FooTests: XCTestCase {}

class FooTests: QuickSpec {}
```

### Sorted Enum Cases

`enum`の`case`の順序が統一されていること

``` swift
// bad
enum foo {
    case b
    case a
    case c
}

// good
enum foo {
    case a
    case b
    case c
}
```

### Min or Max over Sorted First or Last

`sorted().first`や`sorted().last`よりも`min()`や`max()`を使用すること

``` swift
// bad
myList.sorted().first
myList.sorted().last
let min = myList.sorted(by: >).first

// good
myList.min()
myList.max()
let min = myList.min(by: >)
```

### Sorted Imports

`import`文は順序が統一されていること

``` swift
// bad
import AAA
import ZZZ
import BBB
import CCC

// good
import AAA
import BBB
import CCC
import DDD
```

### Static Operator

演算子は自由関数でなく静的関数として定義すること

``` swift
// bad
func == (lhs: A, rhs: A) -> Bool {
    return false
}
func == <T>(lhs: A<T>, rhs: A<T>) -> Bool {
    return false
}

// good
class A: Equatable {
    static func == (lhs: A, rhs: A) -> Bool {
        return false
    }
}
class A<T>: Equatable {
    static func == <T>(lhs: A<T>, rhs: A<T>) -> Bool {
        return false
    }
}
```

### Strict Fileprivate

`fileprivate`を避けること

``` swift
// bad
fileprivate extension String {}

extension String {
    fileprivate func Something() {}
}

// good
private extension String {}

extension String {
    func Something() {}
}
```

### Strong IBOutlet

`@IBOutlet`は弱参照で定義しないこと

``` swift
// bad
class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel?
    @IBOutlet unowned var label: UILabel!
}

// good
class ViewController: UIViewController {
    @IBOutlet var label: UILabel?
    weak var label: UILabel!
}
```

### Superfluous Else

`else`分岐は、直前の`if`文が現在のスコープを抜けるときには避けること

``` swift
// bad
if i > 0 {
    return 1
    // comment
} else {
    return 2
}

// good
if i > 0 {
    // comment
} else if i < 12 {
    return 2
} else {
    return 3
}
```

### Cases on Newline

`switch`文内の`case`は改行すること

``` swift
// bad
switch foo {
    case 1: return true
}

// good
switch foo {
    case 1:
        return true
}
```

### Test Case Accessibility

テストケースは、プライベートな非テストメンバーのみを含むこと

``` swift
// bad
final class BarTests: XCTestCase {
    class Nested {}
}

// good
class FooTests: XCTestCase {
    private struct MockSomething: Something {}
}
```

### Toggle Bool

`someBool = !someBool`より`someBool.toggle()`を使用すること

``` swift
// bad
isHidden = !isHidden

// good
isHidden.toggle()
```

### Trailing Closure

できる限り`Trailing Closure`を使用すること

``` swift
// bad
foo.map({ $0 + 1 })
foo.reduce(0, combine: { $0 + 1 })

// good
foo.map { $0 + 1 }
foo.reduce(0) { $0 + 1 }
```

### Type Contents Order

型内のサブタイプ、プロパティ、メソッドなどの順序を指定すること

``` swift
// bad
class TestViewController: UIViewController {
    // Subtypes
    class TestClass {
        // 10 lines
    }

    // Type Aliases
    typealias CompletionHandler = ((TestEnum) -> Void)
}

// good
class TestViewController: UIViewController {
    // Type Aliases
    typealias CompletionHandler = ((TestEnum) -> Void)

    // Subtypes
    class TestClass {
        // 10 lines
    }
}
```

### Unavailable Function

未実装の関数は使用不可としてマークすること

``` swift
// bad
class ViewController: UIViewController {
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// good
class ViewController: UIViewController {
    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
```

### Unhandled Throwing Task

`Task`内のエラー発生関数を処理すること

``` swift
// bad
Task {
    try await myThrowingFunction()
}

Task {
    let text = try myThrowingFunction()
    return text
}


// good
Task<Void, Never> {
    try await myThrowingFunction()
}

Task {
    try? await myThrowingFunction()
}
```

### Unneeded Parentheses in Closure Argument

クロージャ引数の定義時に括弧を記述しないこと

``` swift
// bad
let foo = { (bar) in }
let foo = { (bar, _)  in }

// good
let foo = { (bar: Int) in }
let foo = { bar in }
let foo = { bar, _ in }
```

### Unowned Variable Capture

潜在的なクラッシュを避けるために、弱い参照をキャプチャすること

``` swift
// bad
foo { [unowned self] in _ }
foo { [unowned bar] in _ }

// good
foo { [weak self] in _ }
foo { [weak self] param in _ }
```

### Untyped Error in Catch

`catch`文は型キャストなしでエラー変数で定義しないこと

``` swift
// bad
do {
    try foo()
} catch let error {
    print(error)
}

// good
do {
    try foo()
} catch let error as MyError {
    print(error)
} catch {
    print(error)
}
```

### Unused Capture List

キャプチャリスト内の未使用の参照は削除すること

``` swift
// bad
[1, 2].map { [weak self] num in
    print(num)
}

// good
[1, 2].map { [weak delegate, unowned self] num in
    delegate.handle(num)
}
```

### Vertical Parameter Alignment on Call

関数の呼び出し時、パラメータが複数行にまたがっている場合は垂直方向に揃えること

``` swift
// bad
validateFunction(_ file: File, kind: SwiftDeclarationKind,
               dictionary: [String: SourceKitRepresentable]) {}
validateFunction(_ file: File, kind: SwiftDeclarationKind,
                  dictionary: [String: SourceKitRepresentable]) {}

// good
validateFunction(_ file: File, kind: SwiftDeclarationKind,
                 dictionary: [String: SourceKitRepresentable]) {}
```

### Vertical Whitespace between Cases

`switch`文の`case`間に空白行を1行含めること

``` swift
// bad
switch x {
case .valid:
    print("x is valid")
case .invalid:
    print("x is invalid")
}

// good
switch x {
case .valid:
    print("x is valid")

case .invalid:
    print("x is invalid")
}
```

### Vertical Whitespace before Closing Braces

中括弧を閉じる前に空白行を入れないこと

``` swift
// bad
{
    {
    }

}

// good
{
    {
    }
}
```

### Vertical Whitespace after Opening Braces

中括弧を開いた後に空白行を入れないこと

``` swift
// bad
{

    {
    }
}

// good
{
    {
    }
}
```

### Weak Delegate

`delegate`は弱い参照で定義すること

``` swift
// bad
class Foo {
    var delegate: SomeProtocol?
}

// good
class Foo {
    weak var delegate: SomeProtocol?
}
```

### XCTest Specific Matcher

`XCTAssertEuqal`や`XCTAssertNotEqual`より特定の`XCTest matcher`を使用すること

``` swift
// bad
XCTAssertEqual(foo, true)
XCTAssertEqual(foo, false)
XCTAssertEqual(foo, nil)
XCTAssertNotEqual(foo, true)
XCTAssertNotEqual(foo, false)
XCTAssertNotEqual(foo, nil)

// good
XCTAssertFalse(foo)
XCTAssertTrue(foo)
XCTAssertNil(foo)
XCTAssertNotNil(foo)
XCTAssertEqual(foo, 2)
```

### Yoda Condition

変数は比較演算子の左側、定数は右側に配置すること

``` swift
// bad
if 42 == foo { }

// good
if foo == 42 { }
```
