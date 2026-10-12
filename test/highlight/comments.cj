// line comment
//<- @comment

/* block */
//<- @comment

main() {
//^ @function
    let s = "text // not a comment"
//  ^ @keyword
//           ^ @string
//                ^ @string
}
