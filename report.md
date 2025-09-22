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
