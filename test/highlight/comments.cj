// line comment
//<- @comment

/* block */
//<- @comment

main() {
//^ @keyword
    let s = "text // not a comment"
//  ^ @keyword
//           ^ @string
//                ^ @string
}
