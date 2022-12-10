use wasmtime::{
    component::{Component, Linker},
    Config, Engine, Store,
};
use wasmtime_wasi::WasiCtxBuilder;

wasmtime::component::bindgen!("../test.wit");

type Result<T> = std::result::Result<T, Box<dyn std::error::Error>>;

#[tokio::main]
async fn main() -> Result<()> {
    let mut config = Config::new();
    config.wasm_component_model(true);

    let engine = Engine::new(&config)?;
    // let module = Module::from_file(&engine, "target/wasm32-wasi/debug/guest.wasm")?;
    let component = Component::from_file(&engine, "target/guest.wasm")?;
    let linker = Linker::new(&engine);

    let wasi = WasiCtxBuilder::new().build();
    let mut store = Store::new(&engine, wasi);

    let (component, _instance) = Test::instantiate(&mut store, &component, &linker)?;

    let s = component.a(&mut store)?;

    println!("Message from guest: {}", s);

    Ok(())
}
