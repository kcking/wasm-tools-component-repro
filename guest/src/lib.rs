wit_bindgen_guest_rust::generate!("../test.wit");

struct Test;

export_test!(Test);

impl test::Test for Test {
    fn a() -> String {
        "Hello wit!".into()
    }
}
