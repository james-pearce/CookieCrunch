/// Copyright (c) 2019 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SpriteKit

// MARK – CookieType
enum CookieType: Int {
  case unknown = 0, croissant, cupcake, danish, donut, macaroon, sugarCookie
  
  var spriteName: String {
    let spriteNames = [
      "Croissant",
      "Cupcake",
      "Danish",
      "Donut",
      "Macaroon",
      "SugarCookie"
    ]
    return spriteNames[rawValue - 1] // convert the enum's value to an integer
  } // returns the filename of the corresponding sprite image in the texture atlas
  
  var highlightedSpriteName: String {
    return spriteName + "-Highlighted"
  } // a highlighted version that appears when the player taps on the cookie
  
  static func random() -> CookieType {
    return CookieType(rawValue: Int(arc4random_uniform(6)) + 1)!
  }
}
// type of the cookie; will not use 0 – unknown

// MARK – Cookie
class Cookie: CustomStringConvertible, Hashable {
  // CustomStringConvertible makes print statements easier to leave
  // Hashable Uses cookies in a Set; objects in a Set must be Hashable –
  // this is a requirement from Swift
  // Contains the data for the cookie to keep data models and view separate
//  var hashValue: Int {
//    return row*10 + column
//  }
// I rewrote this
  func hash(into hasher: inout Hasher) {
    hasher.combine(row*10 + column)
  }
  
  static func ==(lhs: Cookie, rhs: Cookie) -> Bool {
    return lhs.column == rhs.column && lhs.row == rhs.row
  }
  // allows Cookie to keep track of its position in the 2D grid
  
  var description: String {
    return "type:\(cookieType) square:((column),\(row))"
  }
  
  var column: Int
  var row: Int
  let cookieType: CookieType
  var sprite: SKSpriteNode? // optional, may not always be set (?)
  
  init(column: Int, row: Int, cookieType: CookieType) {
    self.column = column
    self.row = row
    self.cookieType = cookieType
  }
}
