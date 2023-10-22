# testgen macro
burn has a attribute macro that is used to generate a macro that will generate a module  with the attribut

This seems to be used to place a test module inside another module

For example it is used like so

#[testgen_macro(foo)]
mod test {
    #[test]
    fn test1() {
        let tt = TestType()
}

This will generate a macro called testgen_foo and this macro in turn generates a macro
that will declare the test

This macro will generate the following macro
macro_rules! testgen_foo {
    () => {
        mod foo {
            use super::*;

            mod test {
                #[test]
                fn test1() {...}
            }
        }
    };
}

# Why would you want to generate a macro that generates a macro?
I believe this is due to the fact that where the testgen_foo() is used it will define type aliases some types 
that are pulled into the module via super::*;

For example in another module it will do this:
mod test {
    use super:*;
    pub type TestType = BarModuleType;
    foo::testgen_foo!();
}

This is a way to allow the same tests to be used in multiple modules, where the types that it
instantiate are dependent on the module the test was pulled into. So we don't have pass any
parameters or config in the test to set it up. It can be used as is

