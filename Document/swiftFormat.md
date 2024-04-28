# SwiftFormat[ルール](https://github.com/nicklockwood/SwiftFormat/blob/master/Rules.md)一覧

## Defaults Rules(enabled by default)

### andOperator

`if`, `guard`, `while`文で`&&`より`,`を優先する

``` swift
- if true && true {
+ if true, true {

- guard true && true else {
+ guard true, true else {

- if functionReturnsBool() && true {
+ if functionReturnsBool(), true {

- if functionReturnsBool() && variable {
+ if functionReturnsBool(), variable {
```

### anyObjectProtocol

プロトコル定義で`class`よりも`AnyObject`を優先する

``` swift
- protocol Foo: class {}
+ protocol Foo: AnyObject {}
```

### applicationMain

廃止された@UIApplicationMainと@NSApplicationMain属性を@mainに置き換える

### assertionFailures

`assert(false, ...)`のインスタンスをすべて`assertionFailure(...)` に、 `precondition(false, ...)`のインスタンスをすべて`preconditionFailure(...)`に変更する

``` swift
- assert(false)
+ assertionFailure()

- assert(false, "message", 2, 1)
+ assertionFailure("message", 2, 1)

- precondition(false, "message", 2, 1)
+ preconditionFailure("message", 2, 1)
```

### blankLineAfterImports

`import`文の後に空行を入れる

``` swift
  import A
  import B
  @testable import D
+
  class Foo {
    // foo
  }
```

### blankLinesAroundMark

`MARK:`コメントの前後に空行を入れる

``` swift
  func foo() {
    // foo
  }
  // MARK: bar
  func bar() {
    // bar
  }

  func foo() {
    // foo
  }
+
  // MARK: bar
+
  func bar() {
    // bar
  }
```

#### Option

* `--lineaftermarks`: `MARK:`コメントの前後に空行を入れるか
  * `true(default)` or `false`

### blankLinesAtEndOfScope

スコープ末尾の空行を削除する

``` swift
  func foo() {
    // foo
-
  }

  func foo() {
    // foo
  }

  array = [
    foo,
    bar,
    baz,
-
  ]

  array = [
    foo,
    bar,
    baz,
  ]
```

### blankLinesAtStartOfScope

スコープの先頭の空行を削除する

``` swift
  func foo() {
-
    // foo
  }

  func foo() {
    // foo
  }

  array = [
-
    foo,
    bar,
    baz,
  ]

  array = [
    foo,
    bar,
    baz,
  ]
```

### blankLinesBetweenScopes

`class`, `struct`, `enum`, `extension`, `protocol`, `関数`の前に空行を入れる

``` swift
  func foo() {
    // foo
  }
  func bar() {
    // bar
  }
  var baz: Bool
  var quux: Int

  func foo() {
    // foo
  }
+
  func bar() {
    // bar
  }
+
  var baz: Bool
  var quux: Int
```

#### Option

* `--typeblanklines`: 空白行の設定
  * `remove(default)` or `preserve`

### blankLinesBetweenChainedFunctions

連鎖する関数間の空行は削除するが、改行は残す

### braces

`{}`の置き位置を統一する

``` swift
- if x
- {
    // foo
  }
- else
- {
    // bar
  }

+ if x {
    // foo
  }
+ else {
    // bar
  }
```

#### Option

* `--allman`: 字下げスタイルの適用
  * `true` or `false(default)`

### conditionalAssignment

`if`, `switch`文を使用してプロパティを適用する

``` swift
- let foo: String
- if condition {
+ let foo = if condition {
-     foo = "foo"
+     "foo"
  } else {
-     bar = "bar"
+     "bar"
  }

- let foo: String
- switch condition {
+ let foo = switch condition {
  case true:
-     foo = "foo"
+     "foo"
  case false:
-     foo = "bar"
+     "bar"
  }
```

### consecutiveBlankLines

連続した空白行を1行の空白行に置き換える

``` swift
  func foo() {
    let x = "bar"
-

    print(x)
  }

  func foo() {
    let x = "bar"

    print(x)
  }
```

### consecutiveSpaces

連続したスペースを1つのスペースに置き換える

``` swift
- let     foo = 5
+ let foo = 5
```

### duplicateImports

重複している`import`文を削除する

``` swift
  import Foo
  import Bar
- import Foo

  import B
  #if os(iOS)
    import A
-   import B
  #endif
```

### elseOnSameLine

`else`, `catch`, `while`キーワードの配置を指定する

``` swift
  if x {
    // foo
- }
- else {
    // bar
  }

  if x {
    // foo
+ } else {
    // bar
  }

  do {
    // try foo
- }
- catch {
    // bar
  }

  do {
    // try foo
+ } catch {
    // bar
  }

  repeat {
    // foo
- }
- while {
    // bar
  }

  repeat {
    // foo
+ } while {
    // bar
  }
```

#### Option

* `--elseposition`: `else/catch`の配置設定
  * `same-line(default)` or `next-line`
* `--guardelse`: `guard`の配置設定
  * `same-line` or `next-line` or `auto(default)`

### emptyBraces

中括弧内の空白を削除する

``` swift
- func foo() {
-
- }

+ func foo() {}
```

#### Option

* `--emptybraces`: 空白の設定
  * `no-space(default)` or `linebreak`

### enumNamespaces

静的な値しか保有していないものを`enum`に変換する

#### Option

* `--enumnamespaces`: `enum`への変更設定
  * `always(default)` or `structs-only`

### extensionAccessControl

`extension`のアクセスキーワードを`extension`側で制御する

``` swift
// --extensionacl on-extension (default)

- extension Foo {
-     public func bar() {}
-     public func baz() {}
  }

+ public extension Foo {
+     func bar() {}
+     func baz() {}
  }

// --extensionacl on-declarations

- public extension Foo {
-     func bar() {}
-     func baz() {}
-     internal func quux() {}
  }

+ extension Foo {
+     public func bar() {}
+     public func baz() {}
+     func quux() {}
  }
```

#### Option

* `--extensionacl`: アクセスキーワードの設定
  * `on-extension(default)` or `on-declarations`

### fileHeader

ファイルのヘッダー部分の表示にテンプレートを使用する

``` swift
// --header \n {file}\n\n Copyright © {created.year} CompanyName.\n

- // SomeFile.swift

+ //
+ //  SomeFile.swift
+ //  Copyright © 2023 CompanyName.
+ //
```

#### Option

* `--header`: ヘッダーのコメント設定
  * `strip` or `ignore` or 使用したいテキスト

### genericExtensions

`Generics`の適用に型制約ではなく、型拡張・角括弧を使用する

``` swift
- extension Array where Element == Foo {}
- extension Optional where Wrapped == Foo {}
- extension Dictionary where Key == Foo, Value == Bar {}
- extension Collection where Element == Foo {}
+ extension Array<Foo> {}
+ extension Optional<Foo> {}
+ extension Dictionary<Key, Value> {}
+ extension Collection<Foo> {}

// With `typeSugar` also enabled:
- extension Array where Element == Foo {}
- extension Optional where Wrapped == Foo {}
- extension Dictionary where Key == Foo, Value == Bar {}
+ extension [Foo] {}
+ extension Foo? {}
+ extension [Key: Value] {}

// Also supports user-defined types!
- extension LinkedList where Element == Foo {}
- extension Reducer where
-     State == FooState,
-     Action == FooAction,
-     Environment == FooEnvironment {}
+ extension LinkedList<Foo> {}
+ extension Reducer<FooState, FooAction, FooEnvironment> {}
```

#### Option

* `--generictypes`: `Generics`への設定リスト

### headerFileName

ヘッダーコメントをファイル名と同一にする

### hoistAwait

インラインの`await`キーワードを先頭に移動する

``` swift
- greet(await forename, await surname)
+ await greet(forename, surname)

- let foo = String(try await getFoo())
+ let foo = await String(try getFoo())
```

#### Option

* `--asynccapturing`: `@autoclosure`の引数を持つ`async`の関数リスト

### hoistPatternLet

インラインの`let`, `var`を再配置する

``` swift
- (let foo, let bar) = baz()
+ let (foo, bar) = baz()

- if case .foo(let bar, let baz) = quux {
    // inner foo
  }

+ if case let .foo(bar, baz) = quux {
    // inner foo
  }
```

#### Option

* `--patternlet`: `let`, `var`の再配置位置
  * `hoist(default)` or `inline`

### hoistTry

インラインの`try`を先頭に移動する

``` swift
- foo(try bar(), try baz())
+ try foo(bar(), baz())

- let foo = String(try await getFoo())
+ let foo = try String(await getFoo())
```

#### Option

* `--throwcapturing`: `@autoclosure`の引数を持つ関数リスト

### indent

スコープのレベルに合わせてコードをインデントする

``` swift
  if x {
-     // foo
  } else {
-     // bar
-       }

  if x {
+   // foo
  } else {
+   // bar
+ }

  let array = [
    foo,
-     bar,
-       baz
-   ]

  let array = [
    foo,
+   bar,
+   baz
+ ]

  switch foo {
-   case bar: break
-   case baz: break
  }

  switch foo {
+ case bar: break
+ case baz: break
  }
```

#### Option

* `--indent`: インデントするスペース数
  * `数値` or タブを使う場合は`tab`
* `--tabWidth`: タブ文字の幅数
  * `数値` or `unspecified(default)`
* `--smarttabs`: タブ幅と無関係にコードを整列する
  *  `enabled(default)`
* `--indentcase`: `switch`文の`case`をインデントする
  * `true` or `false(default)`
* `--ifdef`: `#if`内をインデントする
  * `indent(default)` or `no-indent` or `outdent`
* `--xcodeindentation`: Xcodeのインデントに合わせる
  * `enabled` or `disabled(default)`
* `--indentstrings`: 複数行の文字列をインデントする
  * `false(default)` or `true`

### initCoderUnavailable

`init(coder:)`に`@available(*, unavailable)`属性を追加する

``` swift
+ @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
```

### leadingDelimiters

先頭の区切り文字を前の行の最後に移動する

``` swift
- guard let foo = maybeFoo // first
-     , let bar = maybeBar else { ... }

+ guard let foo = maybeFoo, // first
+      let bar = maybeBar else { ... }
```

### linebreakAtEndOfFile

ファイルの最後に空行を追加する

### linebreaks

全ての改行に指定した改行文字を使用する

#### Option

* `--linebreaks`: 使用する改行文字
  * `cr` or `crlf` or `If(default)`

### modifierOrder

メンバー修飾子の順序を統一する

``` swift
- lazy public weak private(set) var foo: UIView?
+ public private(set) lazy weak var foo: UIView?

- final public override func foo()
+ override public final func foo()

- convenience private init()
+ private convenience init()
```

#### Option

* `--modifierorder`: カンマ区切りで優先順の修飾語リスト

### numberFormatting

数値に対して一貫したグループ分けを使用する

``` swift
- let color = 0xFF77A5
+ let color = 0xff77a5

- let big = 123456.123
+ let big = 123_456.123
```

#### Option

* `--decimalgrouping`: 10進数のグループ化
  * `3,6(default)` or `none` or `ignore`
* `--binarygrouping`: バイナリのグループ化
  * `4,8(default)` or `none` or `ignore`
* `--octalgrouping`: 8進数のグループ化
  * `4, 8(default)` or `none` or `ignore`
* `--hexgrouping`: 16進数のグループ化
  * `4,8(default)` or `none` or `ignore`
* `--fractiongrouping`: 小数点`.`以降のグループ化
  * `enabled` or `disabled(default)`
* `--exponentgrouping`: グループ指数桁
  * `enabled` or `disabled(default)`
* `--hexliteralcase`: 16進数の大文字化
  * `uppercase(default)` or `lowercase`
* `--exponentcase`: 数字の`e`の大文字化
  * `lowercase` or `uppercase(default)`

### opaqueGenericParameters

ジェネリック・パラメーターの代わりに`some`を使用する

``` swift
- func handle<T: Fooable>(_ value: T) {
+ func handle(_ value: some Fooable) {
      print(value)
  }

- func handle<T>(_ value: T) where T: Fooable, T: Barable {
+ func handle(_ value: some Fooable & Barable) {
      print(value)
  }

- func handle<T: Collection>(_ value: T) where T.Element == Foo {
+ func handle(_ value: some Collection<Foo>) {
      print(value)
  }

// With `--someany enabled` (the default)
- func handle<T>(_ value: T) {
+ func handle(_ value: some Any) {
      print(value)
  }
```

#### Option

* `--someany`: `some Any`を使用するか
  * `true(default)` or `false`

### preferForLoop

関数`forEach`を`for`文に変換する

``` swift
  let strings = ["foo", "bar", "baaz"]
- strings.forEach { placeholder in
+ for placeholder in strings {
      print(placeholder)
  }

  // Supports anonymous closures
- strings.forEach {
+ for string in strings {
-     print($0)
+     print(string)
  }

- foo.item().bar[2].baazValues(option: true).forEach {
+ for baazValue in foo.item().bar[2].baazValues(option: true) {
-     print($0)
+     print(baazValue)
  }

  // Doesn't affect long multiline functional chains
  placeholderStrings
      .filter { $0.style == .fooBar }
      .map { $0.uppercased() }
      .forEach { print($0) }
```

#### Option

* `--anonymousforeach`: 引数なしの`forEach`を変換する
  * `convert(default)` or `ignore`
* `--onelineforeach`: 1行の`forEach`を変換する
  * `convert(default)` or `ignore`

### preferKeyPath

クロージャ参照を`KeyPath`に変換する

``` swift
- let barArray = fooArray.map { $0.bar }
+ let barArray = fooArray.map(\.bar)

- let barArray = fooArray.compactMap { $0.optionalBar }
+ let barArray = fooArray.compactMap(\.optionalBar)
```

### redundantBackticks

識別子を含む冗長なバックスティックを削除する

``` swift
- let `infix` = bar
+ let infix = bar

- func foo(with `default`: Int) {}
+ func foo(with default: Int) {}
```

### redundantBreak

`switch`文の`case`での冗長な`break`を削除する

``` swift
  switch foo {
    case bar:
        print("bar")
-       break
    default:
        print("default")
-       break
  }
```

### redundantClosure

即時実行されるクロージャの冗長記述を削除する

``` swift
- let foo = { Foo() }()
+ let foo = Foo()

- lazy var bar = {
-     Bar(baaz: baaz,
-         quux: quux)
- }()
+ lazy var bar = Bar(baaz: baaz,
+                    quux: quux)
```

### redundantExtensionACL

冗長なアクセス修飾子を削除する

``` swift
  public extension URL {
-   public func queryParameter(_ name: String) -> String { ... }
  }

  public extension URL {
+   func queryParameter(_ name: String) -> String { ... }
  }
```

### redundantFileprivate

同等であれば、`fileprivate`より`private`を優先する

``` swift
-  fileprivate let someConstant = "someConstant"
+  private let someConstant = "someConstant"

  class Foo {
-   fileprivate var foo = "foo"
+   private var foo = "foo"
  }

  extension Foo {
    func bar() {
      print(self.foo)
    }
  }
```

### redundantGet

`computed properties`の不要な`get`節削除

``` swift
  var foo: Int {
-   get {
-     return 5
-   }
  }

  var foo: Int {
+   return 5
  }
```

### redundantInit

必要のない明示的な`init`を削除する

``` swift
- String.init("text")
+ String("text")
```

### redundantInternal

冗長な内部アクセス制御を削除する

``` swift
- internal class Foo {
+ class Foo {
-     internal let bar: String
+     let bar: String

-     internal func baaz() {}
+     func baaz() {}

-     internal init() {
+     init() {
          bar = "bar"
      }
  }
```

### redundantLet

不要な`let`, `var`定義を削除する

``` swift
- let _ = foo()
+ _ = foo()
```

### redundantLetError


不要な`catch`文の`let error`を削除する

``` swift
- do { ... } catch let error { log(error) }
+ do { ... } catch { log(error) }
```

### redundantNilInit

冗長な`nil`デフォルト値を削除する

``` swift
- var foo: Int? = nil
+ var foo: Int?

// doesn't apply to `let` properties
let foo: Int? = nil

// doesn't affect non-nil initialization
var foo: Int? = 0
```

### redundantObjc

冗長な`objc`アノテーションを削除する

``` swift
- @objc @IBOutlet var label: UILabel!
+ @IBOutlet var label: UILabel!

- @IBAction @objc func goBack() {}
+ @IBAction func goBack() {}

- @objc @NSManaged private var foo: String?
+ @NSManaged private var foo: String?
```

### redundantOptionalBinding

オプショナルバインディングの冗長な定義を削除する

``` swift
- if let foo = foo {
+ if let foo {
      print(foo)
  }

- guard let self = self else {
+ guard let self else {
      return
  }
```

### redundantParens

冗長な括弧を削除する

``` swift
- if (foo == true) {}
+ if foo == true {}

- while (i < bar.count) {}
+ while i < bar.count {}

- queue.async() { ... }
+ queue.async { ... }

- let foo: Int = ({ ... })()
+ let foo: Int = { ... }()
```

### redundantPattern

冗長なパターンマッチングパラメータを削除する

``` swift
- if case .foo(_, _) = bar {}
+ if case .foo = bar {}

- let (_, _) = bar
+ let _ = bar
```

### redundantRawValues

`enum`の冗長な(`rawValue`)値削除

``` swift
  enum Foo: String {
-   case bar = "bar"
    case baz = "quux"
  }

  enum Foo: String {
+   case bar
    case baz = "quux"
  }
```

### redundantReturn

不要な`return`キーワードを削除する

``` swift
- array.filter { return $0.foo == bar }
+ array.filter { $0.foo == bar }

  // Swift 5.1+ (SE-0255)
  var foo: String {
-     return "foo"
+     "foo"
  }

  // Swift 5.9+ (SE-0380)
  func foo(_ condition: Bool) -> String {
      if condition {
-         return "foo"
+         "foo"
      } else {
-         return "bar"
+         "bar"
      }
  }
```

### redundantSelf

必要に応じて明示的に`self`を挿入・削除する

``` swift
  func foobar(foo: Int, bar: Int) {
    self.foo = foo
    self.bar = bar
-   self.baz = 42
  }

  func foobar(foo: Int, bar: Int) {
    self.foo = foo
    self.bar = bar
+   baz = 42
  }
```

#### Option

* `--self`: 明示的に挿入するか
  * `insert` or `remove(default)` or `init-only`
* `--selfrequired`: `self`を必要とするか
  * `@autoclosure`を引数とする関数リスト

### redundantStaticSelf

適用できる明示的な`Self`を削除する

### redundantType

変数宣言から冗長な型を削除する

``` swift
// inferred
- let view: UIView = UIView()
+ let view = UIView()

// explicit
- let view: UIView = UIView()
+ let view: UIView = .init()

// infer-locals-only
  class Foo {
-     let view: UIView = UIView()
+     let view: UIView = .init()

      func method() {
-         let view: UIView = UIView()
+         let view = UIView()
      }
  }

// Swift 5.9+, inferred (SE-0380)
- let foo: Foo = if condition {
+ let foo = if condition {
      Foo("foo")
  } else {
      Foo("bar")
  }

// Swift 5.9+, explicit (SE-0380)
  let foo: Foo = if condition {
-     Foo("foo")
+     .init("foo")
  } else {
-     Foo("bar")
+     .init("foo")
  }
```

#### Option

* `--redundanttype`: どのような方法で削除するか
  * `inferred` or `explicit` or `infer-locals-only(default)`

### redundantVoidReturnType

明示的な`Void`の戻り値の型を削除する

``` swift
- func foo() -> Void {
    // returns nothing
  }

+ func foo() {
    // returns nothing
  }
```

#### Option

* `--closurevoid`: `Void`を返すかどうか
  * `remove(default)` or `preserve`

### semicolons

セミコロンを削除する

``` swift
- let foo = 5;
+ let foo = 5

- let foo = 5; let bar = 6
+ let foo = 5
+ let bar = 6

// semicolon is not removed if it would affect the behavior of the code
return;
goto(fail)
```

#### Option

* `--semicolons`: セミコロンを許可するかどうか
  * `never` or `inline(default)`

### sortDeclarations

`// swiftformat: sort`で宣言し、`// swiftformat:sort:begin`と`// swiftformat:sort:end`内をソートする

``` swift
  // swiftformat:sort
  enum FeatureFlags {
-     case upsellB
-     case fooFeature
-     case barFeature
-     case upsellA(
-         fooConfiguration: Foo,
-         barConfiguration: Bar)
+     case barFeature
+     case fooFeature
+     case upsellA(
+         fooConfiguration: Foo,
+         barConfiguration: Bar)
+     case upsellB
  }

  enum FeatureFlags {
      // swiftformat:sort:begin
-     case upsellB
-     case fooFeature
-     case barFeature
-     case upsellA(
-         fooConfiguration: Foo,
-         barConfiguration: Bar)
+     case barFeature
+     case fooFeature
+     case upsellA(
+         fooConfiguration: Foo,
+         barConfiguration: Bar)
+     case upsellB
      // swiftformat:sort:end

      var anUnsortedProperty: Foo {
          Foo()
      }
  }
```

### sortImports

`import`文をアルファベット順にソートする

``` swift
- import Foo
- import Bar
+ import Bar
+ import Foo

- import B
- import A
- #if os(iOS)
-   import Foo-iOS
-   import Bar-iOS
- #endif
+ import A
+ import B
+ #if os(iOS)
+   import Bar-iOS
+   import Foo-iOS
+ #endif
```

#### Option

* `--importgrouping`: `import`文のグルーピング
  * `testable-first/last"` or `alpha(default)` or `length`

### sortTypealiases

`typealias`の定義宣言をアルファベット順にソートする

``` swift
- typealias Placeholders = Foo & Bar & Baaz & Quux
+ typealias Placeholders = Baaz & Bar & Foo & Quux

  typealias Dependencies
-     = FooProviding
+     = BaazProviding
      & BarProviding
-     & BaazProviding
+     & FooProviding
      & QuuxProviding
```

### spaceAroundBraces

中括弧周りのスペースを追加・削除する

``` swift
- foo.filter{ return true }.map{ $0 }
+ foo.filter { return true }.map { $0 }

- foo( {} )
+ foo({})
```

### spaceAroundBrackets

角括弧周りのスペースを追加・削除する

``` swift
- foo as[String]
+ foo as [String]

- foo = bar [5]
+ foo = bar[5]
```

### spaceAroundComments

コメントの前後にスペースを追加する

``` swift
- let a = 5// assignment
+ let a = 5 // assignment

- func foo() {/* ... */}
+ func foo() { /* ... */ }
```

### spaceAroundGenerics

角括弧内のスペースを削除する

``` swift
- Foo <Bar> ()
+ Foo<Bar>()
```

### spaceAroundOperators

演算子、区切り文字の周りにスペースを追加・削除する

``` swift
- foo . bar()
+ foo.bar()

- a+b+c
+ a + b + c

- func ==(lhs: Int, rhs: Int) -> Bool
+ func == (lhs: Int, rhs: Int) -> Bool
```

#### Option

* `--operatorfunc`: 関数での設定
  * `spaced(default)` or `no-space`
* `--nospaceoperators`: スペースを追加しない演算子の設定
  * 空白を含まない演算子リスト
* `--ranges	`: スペースの間隔
  * `spaced(default)` or `no-space`

### spaceAroundParens

括弧の周りにスペースを追加・削除する

``` swift
- init (foo)
+ init(foo)

- switch(x){
+ switch (x) {
```

### spaceInsideBraces

中括弧の中にスペースを追加する

``` swift
- foo.filter {return true}
+ foo.filter { return true }
```

### spaceInsideBrackets

角括弧内のスペースを削除する

``` swift
- [ 1, 2, 3 ]
+ [1, 2, 3]
```

### spaceInsideComments

コメント内の先頭・末尾にスペースを追加する

``` swift
- let a = 5 //assignment
+ let a = 5 // assignment

- func foo() { /*...*/ }
+ func foo() { /* ... */ }
```

### spaceInsideGenerics

角括弧内のスペースを削除する

``` swift
- Foo< Bar, Baz >
+ Foo<Bar, Baz>
```

###  spaceInsideParens

括弧内のスペースを削除する

``` swift
- ( a, b)
+ (a, b)
```

### strongOutlets

`IBOutlet`プロパティから`weak`修飾子を削除する

``` swift
- @IBOutlet weak var label: UILabel!
+ @IBOutlet var label: UILabel!
```

### strongifiedSelf

オプショナル型のアンラップで`self`のバックスティックを削除する

``` swift
- guard let `self` = self else { return }
+ guard let self = self else { return }
```

### todos

`TODO:`, `MARK:`, `FIXME:`を正しいフォーマットで使用する

``` swift
- /* TODO fix this properly */
+ /* TODO: fix this properly */

- // MARK - UIScrollViewDelegate
+ // MARK: - UIScrollViewDelegate
```

### trailingClosures

末尾のクロージャ省略記法を使用する

``` swift
- DispatchQueue.main.async(execute: { ... })
+ DispatchQueue.main.async {

- let foo = bar.map({ ... }).joined()
+ let foo = bar.map { ... }.joined()
```

#### Option

* `--trailingclosures`: 省略記法を使用するかどうか
  * カンマ区切りで使用する末尾クロージャのリスト
* `--nevertrailing`: 省略記法を使用するかどうか
  * カンマ区切りで使用しない末尾クロージャのリスト

### trailingCommas

コレクションの最後の要素の後にカンマを追加する

``` swift
  let array = [
    foo,
    bar,
-   baz
  ]

  let array = [
    foo,
    bar,
+   baz,
  ]
```

#### Option

* `--commas`: コレクションにカンマを使用するかどうか
  * `always(default)` or `inline`

### trailingSpace

行末のスペースを削除する

#### Option

* `--trimwhitespace`: スペースを削除するかどうか
  * `always(default)` or `nonblank-lines`

### typeSugar

配列、辞書、オプショナル型の省略構文を優先する

``` swift
- var foo: Array<String>
+ var foo: [String]

- var foo: Dictionary<String, Int>
+ var foo: [String: Int]

- var foo: Optional<(Int) -> Void>
+ var foo: ((Int) -> Void)?
```

#### Option

* `--shortoptionals`: オプショナル型の省略構文を使用するかどうか
  * `always` or `except-properties(default)`

### unusedArguments

未使用の関数の引数を`_`でマークする

``` swift
- func foo(bar: Int, baz: String) {
    print("Hello \(baz)")
  }

+ func foo(bar _: Int, baz: String) {
    print("Hello \(baz)")
  }

- func foo(_ bar: Int) {
    ...
  }

+ func foo(_: Int) {
    ...
  }

- request { response, data in
    self.data += data
  }

+ request { _, data in
    self.data += data
  }
```

#### Option

* `--stripunusedargs`: 何に対して適用するかどうか
  * `closure-only` or `unnamed-only` or `always(default)`

### void

型宣言には`Void`を使用し、値には`()`を使用する

``` swift
- let foo: () -> ()
+ let foo: () -> Void

- let bar: Void -> Void
+ let bar: () -> Void

- let baz: (Void) -> Void
+ let baz: () -> Void

- func quux() -> (Void)
+ func quux() -> Void

- callback = { _ in Void() }
+ callback = { _ in () }
```

#### Option

* `--voidtype`: `void`をどのようの表現するか
  * `void(default)` or `tuple`

### wrap

指定された最大幅を超えた場合に折り返す

#### Option

* `--maxWidth`: 折り返す前の行の最大値
  * `default: none`
* `--nowrapoperators`: 折り返しをしないようにする
  * 折り返ししない演算子リスト
* `--assetliterals`: 色・画像の幅
  * `actual-width` or `visual-width`
* `--wrapternary`: 三項演算子を折り返すかどうか
  * `default` or `before-operators`

### wrapArguments

ラップされた関数引数やコレクション要素を整列する

``` swift
// --wraparguments before-first

- foo(bar: Int,
-     baz: String)

+ foo(
+   bar: Int,
+   baz: String
+ )

- class Foo<Bar,
-           Baz>

+ class Foo<
+   Bar,
+   Baz
+ >

// --wrapparameters after-first

- func foo(
-   bar: Int,
-   baz: String
- ) {
    ...
  }

+ func foo(bar: Int,
+          baz: String)
+ {
    ...
  }

// --wrapcollections before-first:

- let foo = [bar,
             baz,
-            quuz]

+ let foo = [
+   bar,
    baz,
+   quuz
+ ]
```

#### Option

* `--wraparguments`: ラップする引数の設定
  * `before-first` or `after-first` or `preserve`
* `--wrapparameters`: ラップする関数内の引数の設定
  * `before-first` or `after-first` or `preserve`
* `--wrapcollections`: ラップする配列・辞書の設定
  * `before-first` or `after-first` or `preserve`
* `--closingparen`: 閉じ括弧の位置の設定
  * `balanced(default)` or `same-line`
* `--wrapreturntype`: ラップする`return`の設定
  * `if-multiline` or `preserve(default)`
* `--wrapconditions`: ラップする条件の設定
  * `before-first` or `after-first` or `preserve`
* `--wraptypealiases`: ラップする`typealias`の設定
  * `before-first` or `after-first` or `preserve`
* `--wrapeffects`: ラップする影響の設定
  * `if-multiline` or `never` or `preserve`

### wrapAttributes

属性を書く位置を指定する

``` swift
// --funcattributes prev-line

- @objc func foo() {}

+ @objc
+ func foo() { }

// --funcattributes same-line

- @objc
- func foo() { }

+ @objc func foo() {}

// --typeattributes prev-line

- @objc class Foo {}

+ @objc
+ class Foo { }

// --typeattributes same-line

- @objc
- enum Foo { }

+ @objc enum Foo {}
```

#### Option

* `--funcattributes`: 引数の属性の設定
  * `preserve` or `prev-line` or `same-line`
* `--typeattributes`: 型の属性の設定
  * `preserve` or `prev-line` or `same-line`
* `--varattributes`: プロパティの属性の設定
  * `preserve` or `prev-line` or `same-line`

### wrapLoopBodies

ループ内のインラインを改行する

``` swift
- for foo in array { print(foo) }
+ for foo in array {
+     print(foo)
+ }

- while let foo = bar.next() { print(foo) }
+ while let foo = bar.next() {
+     print(foo)
+ }
```

### wrapMultilineStatementBraces

複数行の開始位置をラップする

``` swift
  if foo,
-   bar {
    // ...
  }

  if foo,
+   bar
+ {
    // ...
  }

  guard foo,
-   bar else {
    // ...
  }

  guard foo,
+   bar else
+ {
    // ...
  }

  func foo(
    bar: Int,
-   baz: Int) {
    // ...
  }

  func foo(
    bar: Int,
+   baz: Int)
+ {
    // ...
  }

  class Foo: NSObject,
-   BarProtocol {
    // ...
  }

  class Foo: NSObject,
+   BarProtocol
+ {
    // ...
  }
```

### wrapSingleLineComments

指定した`--maxWidth`を超えるコメント文をラップする

### yodaConditions

定数値を式の右辺に置く

#### Option

* `--yodaswap`: 値を入れ替える設定
  * `always(default)` or `literals-only`

## Opt-in Rules(disabled by default)

### acronyms

頭字語を大文字にする

``` swift
- let destinationUrl: URL
- let urlRouter: UrlRouter
- let screenId: String
- let entityUuid: UUID

+ let destinationURL: URL
+ let urlRouter: URLRouter
+ let screenID: String
+ let entityUUID: UUID
```

### blankLinesBetweenImports

`import`文の間の空行を削除する

``` swift
  import A
-
  import B
  import C
-
-
  @testable import D
  import E
```

### blockComments

ブロックコメントを1行コメントに変換する

``` swift
- /*
-  * foo
-  * bar
-  */

+ // foo
+ // bar

- /**
-  * foo
-  * bar
-  */

+ /// foo
+ /// bar
```

### docComments

API宣言には`doc Documents`を使用して、その他は通常のコメントを使用する

``` swift
- // A placeholder type used to demonstrate syntax rules
+ /// A placeholder type used to demonstrate syntax rules
  class Foo {
-     // This function doesn't really do anything
+     /// This function doesn't really do anything
      func bar() {
-         /// TODO: implement Foo.bar() algorithm
+         // TODO: implement Foo.bar() algorithm
      }
  }
```

#### Option

* `--doccomments`: `Doc comments`の設定
  * `before-declarations(default)` or `preserve`

### isEmpty

数値を0で比較する際に`isEmpty`を使用する

``` swift
- if foo.count == 0 {
+ if foo.isEmpty {

- if foo.count > 0 {
+ if !foo.isEmpty {

- if foo?.count == 0 {
+ if foo?.isEmpty == true {
```

### markTypes

トップレベルの型と`extension`に`MARK`コメントを追加する

``` swift
+ // MARK: - FooViewController
+
 final class FooViewController: UIViewController { }

+ // MARK: UICollectionViewDelegate
+
 extension FooViewController: UICollectionViewDelegate { }

+ // MARK: - String + FooProtocol
+
 extension String: FooProtocol { }
```

#### Option

* `--marktypes`: `MARK`する対象
  * `always(default)` or `never` or `if-not-empty`
* `--typemark`: `MARK`のタイプ
  * `MARK: - %t`
* `--markextensions`: `extension`に`MARK`するか
  * `always(default)` or `never` or `if-not-empty`
* `--extensionmark`: `extension`の`MARK`のタイプ
  * `MARK: - %t + %c`
* `--groupedextension`: `extension`でグループ化された`MARK`のタイプ
  * `MARK: %c`

### noExplicitOwnership

所有権の明示的な修飾子`borrowing`, `consuming`を使用しない

``` swift
- borrowing func foo(_ bar: consuming Bar) { ... }
+ func foo(_ bar: Bar) { ... }
```

### organizeDeclarations

`class`, `struct`, `enum`, `actor`, `extension`内の宣言を整理する

``` swift
  public class Foo {
-     public func c() -> String {}
-
-     public let a: Int = 1
-     private let g: Int = 2
-     let e: Int = 2
-     public let b: Int = 3
-
-     public func d() {}
-     func f() {}
-     init() {}
-     deinit() {}
 }

  public class Foo {
+
+     // MARK: Lifecycle
+
+     init() {}
+     deinit() {}
+
+     // MARK: Public
+
+     public let a: Int = 1
+     public let b: Int = 3
+
+     public func c() -> String {}
+     public func d() {}
+
+     // MARK: Internal
+
+     let e: Int = 2
+
+     func f() {}
+
+     // MARK: Private
+
+     private let g: Int = 2
+
 }
```

#### Option

* `--categorymark`: カテゴリーする`MARK`のテンプレート
  * `MARK: %c`
* `--markcategories`: カテゴリー間に`MARK`を挿入するか
  * `default: true`
* `--beforemarks`: 最初の`MARK`の前に宣言するか
  * `e.g. typealias, struct`
* `--lifecycle`: 追加するライフサイクルのメソッド名
  * `e.g. viewDidLoad`
* `--organizetypes`: 整理する宣言
  * `default: class, actor, struct, enum`
* `--structthreshold`: 構造体を構成するための最小行数
  * `default: 0`
* `--classthreshold`: クラスを構成するための最小行数
  * `default: 0`
* `--enumthreshold`: enumを構成するための最小行数
  * `default: 0`
* `--extensionlength`: extensionを構成するための最小行数
  * `default: 0`

### sortSwitchCases

`switch`文の`case`をアルファベット順にソートする

### wrapConditionalBodies

条件文のインラインをラップする

``` swift
- guard let foo = bar else { return baz }
+ guard let foo = bar else {
+     return baz
+ }

- if foo { return bar }
+ if foo {
+    return bar
+ }
```

### wrapEnumCases

カンマ区切りの`case`を1行毎に分割する

``` swift
  enum Foo {
-   case bar, baz
  }

  enum Foo {
+   case bar
+   case baz
  }
```

#### Option

* `--wrapenumcases`: `enum`の`case`をラップするかどうか
  * `always(default)` or `with-values`

### wrapMultilineConditionalAssignment

複数行の条件付き代入式を演算子の後でラップする

``` swift
- let planetLocation = if let star = planet.star {
-     "The \(star.name) system"
- } else {
-     "Rogue planet"
- }
+ let planetLocation =
+     if let star = planet.star {
+         "The \(star.name) system"
+     } else {
+         "Rogue planet"
+     }
```

### wrapSwitchCases

カンマ区切りの`case`を複数行にまとめる

``` swift
  switch foo {
-   case .bar, .baz:
      break
  }

  switch foo {
+   case .foo,
+        .bar:
      break
  }
```

## Analyzer Rules(do not use)

### sortedImports

`import`文をアルファベット順にソートする

#### 注意点

非推奨なため、`sortImports`を使用する

### sortedSwitchCases

`switch`文の`case`をアルファベット順にソートする

#### 注意点

非推奨なため、`sortSwitchCases`を使用する

### specifiers

メンバー修飾子の順序を統一する

#### 注意点

非推奨なため、`modifierOrder`を使用する
