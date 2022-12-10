# Status

- almost working to the point mentioned in https://bytecodealliance.zulipchat.com/#narrow/stream/206238-general/topic/wasi_snapshot_preview1.20module
- had to downgrade wasm-tools repo (recent commit broke `wasm-tools component new` for converting guest wasi to wasm)
- to get wasi fully working, still have to link host functions (inspiration in `preview2/host` crate)
- can also just try components with pure wasm, no wasi. expose host functionality where needed

- See `run.ps1` for repro steps
