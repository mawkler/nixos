---
name: rust
description: Personal preferences for writing Rust. Use when writing, editing, reviewing or debugging Rust code (`.rs` files, `Cargo.toml`).
---

# Rust preferences

When possible, prefer structs to be one-lined using field init shorthand. For example, prefer this:

```rust
let x = Coordinate::new(10);
let y = Coordinate::new(20);
let z = Coordinate::new(30);
let p = Point { x, y, z };
```

over this:

```rust
let p = Point {
    x: Coordinate::new(10),
    y: Coordinate::new(20),
    z: Coordinate::new(30),
};
```

However, if `rustfmt` would have multi-lined the struct anyway because it's too wide, prefer the second version.
