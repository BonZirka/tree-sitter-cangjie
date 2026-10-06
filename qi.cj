main(): Int64 {
    let b = 1
    let q = quote(
        var a = $(
            b + 1
        )
    )
    return 0
}
