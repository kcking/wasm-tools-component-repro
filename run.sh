cargo build --target wasm32-unknown-unknown -p guest
wasm-tools component new target/wasm32-unknown-unknown/debug/guest.wasm -o target/guest.wasm
cargo run -p host
