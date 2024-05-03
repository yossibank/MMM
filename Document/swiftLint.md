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
// #waring 50
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
// #waring 1

// function_level
// #waring 2


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
### Accessibility Trait for Button
### Anonymous Argument in Multiline Closure
### AnyObject Protocol
### Array Init
### Attributes
### Balanced XCTest Life Cycle
### Closure Body Length
### Closure End Indentation
### Closure Spacing
### Collection Element Alignment
### Comma Inheritance Rule
### Conditional Returns on Newline
### Contains over Filter Count
### Contains over Filter is Empty
### Contains over First not Nil
### Contains over Range Comparison to Nil
### Convenience Type
### Direct Return
### Discarded Notification Center Observer
### Discouraged Assert
### Discouraged None Name
### Discouraged Object Literal
### Discouraged Optional Boolean
### Discouraged Optional Collection
### Empty Collection Literal
### Empty Count
### Empty String
### Empty XCTest Method
### Enum Case Associated Values Count
### Expiring Todo
### Explicit ACL
### Explicit Enum Raw Value
### Explicit Init
### Explicit Top Level ACL
### Explicit Type Interface
### Extension Access Modifier
### Fallthrough
### Fatal Error Message
### File Header
### File Name
### File Name no Space
### File Types Order
### Final Test Case
### First Where
### Flat Map over Map Reduce
### Force Unwrapping
### Function Default Parameter at End
### IBInspectable in Extension
### Identical Operands
### Implicit Return
### Implicitly Unwrapped Optional
### Indentation Width
### Inert Defer
### Joined Default Parameter
### Last Where
### Legacy Multiple
### Legacy Objective-C Reference Type
### Variable Declaration Whitespace
### Literal Expression End Indentation
### Local Doc Comment
### Lower ACL than Parent
### Missing Docs
### Modifier Order
### Multiline Arguments
### Multiline Arguments Brackets
### Multiline Function Chains
### Multiline Literal Brackets
### Multiline Parameters
### Multiline Parameters Brackets
### Nimble Operator
### No Extension Access Modifier
### No Grouping Extension
### No Magic Numbers
### Class Declaration in Final Class
### NSLocalizedString Key
### NSLocalizedString Require Bundle
### Number Separator
### Object Literal
### One Declaration per File
### Operator Usage Whitespace
### Optional Enum Case Match
### Overridden Method Calls Super
### Override in Extension
### Pattern Matching Keywords
### Period Spacing
### Prefer Nimble
### Prefer Self in Static References
### Prefer Self Type Over Type of Self
### Prefer Zero Over Explicit Init
### Prefixed Top-Level Constant
### Private Actions
### Private Outlets
### Private Combine Subject
### Private SwiftUI State Properties
### Prohibited Interface Builder
### Prohibited Calls to Super
### Quick Discouraged Call
### Quick Discouraged Focused Test
### Quick Discouraged Pending Test
### Raw Value for Camel Cased Codable Enum
### Reduce into
### Redundant Nil Coalescing
### Redundant Self in Closure
### Redundant Type Annotation
### Required Deinit
### Required Enum Case
### Return Value from Void Function
### Self Binding
### Shorthand Argument
### Shorthand Optional Binding
### Single Test Class
### Sorted Enum Cases
### Min or Max over Sorted First or Last
### Sorted Imports
### Static Operator
### Strict Fileprivate
### Strong IBOutlet
### Superfluous Else
### Cases on Newline
### Test Case Accessibility
### Toggle Bool
### Trailing Closure
### Type Contents Order
### Unavailable Function
### Unhandled Throwing Task
### Unneeded Parentheses in Closure Argument
### Unowned Variable Capture
### Untyped Error in Catch
### Unused Capture List
### Vertical Parameter Alignment on Call
### Vertical Whitespace between Cases
### Vertical Whitespace before Closing Braces
### Vertical Whitespace after Opening Braces
### Weak Delegate
### XCTest Specific Matcher
### Yoda Condition

## Analyzer Rules

### Capture Variable
### Explicit Self
### Type-safe Array Init
### Unused Declaration
### Unused Import