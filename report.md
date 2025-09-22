# Report

## Feature-4: Dynamic Library

### Q1. What is Position-Independent Code (-fPIC)?
Position-Independent Code allows a shared library to be loaded at any memory address without modification.  
The compiler generates relative addressing instructions, which makes the code reusable by multiple processes.  
It is fundamental because a `.so` file is loaded dynamically and cannot assume fixed addresses.

### Q2. Difference in file size between static and dynamic clients
- The **static client** includes the actual implementation of all library functions, making the binary larger.  
- The **dynamic client** only stores references to the shared library, so it is smaller.  
- At runtime, the OS loads the shared `.so` once and multiple programs can share it, saving memory.

### Q3. What is the LD_LIBRARY_PATH environment variable?
`LD_LIBRARY_PATH` tells the dynamic loader where to look for shared libraries at runtime.  
It was necessary to set this variable because our `libmyutils.so` was not installed in system library paths (like `/usr/lib`).  
This demonstrates that the OS loader resolves library paths at runtime and must know where to find custom `.so` files.
# Feature-3 Report

## Q1. Compare the Makefile from Part 2 and Part 3.
In Part 2, all `.o` files were directly linked into the final executable (`bin/client`).  
In Part 3, utility `.o` files are first archived into a static library (`lib/libmyutils.a`) using `ar`.  
Then only `main.o` is compiled separately and linked with this library to create `bin/client_static`.  
This introduces new rules and variables like `AR` and `LIB`.

## Q2. What is the purpose of the ar command? Why is ranlib often used after it?
- `ar` combines multiple `.o` files into a single archive (`.a`) called a static library.  
- `ranlib` creates an index of the library contents, so the linker can quickly resolve symbols.  

## Q3. When you run nm on client_static, are functions like mystrlen present? What does this tell you about static linking?
Functions like `mystrlen` do not appear as external symbols in `client_static`.  
This shows that static linking copies the function implementations directly into the executable, instead of keeping them separate like in dynamic linking.
