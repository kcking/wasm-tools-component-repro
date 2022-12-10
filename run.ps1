echo 'building wasm-tools' &&
cargo install --path wasm-tools --debug &&
echo 'building guest wasm' &&
cargo build --target wasm32-unknown-unknown -p guest &&
echo 'building guest wasi' &&
cargo build --target wasm32-wasi -p guest &&
echo 'building wasi_snapshot' &&
cargo build --config='build.rustflags = [\"-C\", \"link-args=--import-memory\", \"-C\", \"link-args=-zstack-size=0\"]' --release --target=wasm32-unknown-unknown --manifest-path preview2-prototyping/Cargo.toml &&
echo 'generating component' &&
# fails since wasm-tools@e59094c
#   'cannot import anonymous type across interfaces', crates\wit-component\src\encoding.rs:438:14
# working at wasm-tools@2de95fe
# wasm-tools component new target/wasm32-unknown-unknown/debug/guest.wasm -o target/guest.wasm &&
wasm-tools component new target/wasm32-wasi/debug/guest.wasm -o target/guest.wasm --adapt preview2-prototyping/target/wasm32-unknown-unknown/release/wasi_snapshot_preview1.wasm &&
echo 'running host' &&
# wasm32-u-u works
# wasm32-wasi fails with Error: import `wasi-filesystem` not defined on host (expected since we need to provide host impl)
cargo run -p host
