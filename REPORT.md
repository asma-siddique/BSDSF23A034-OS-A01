# Report

## Q1. Explain the linking rule in this part's Makefile: $(TARGET): $(OBJECTS)
This rule specifies that the final executable `$(TARGET)` depends on all object files `$(OBJECTS)`.  
When any `.o` file changes, Make will re-link the program.  
It differs from linking against a library because here we directly link multiple `.o` files together, while in a library-based Makefile, we would link the program against a precompiled `.a` or `.so` file.

## Q2. What is a git tag and why is it useful in a project? 
A git tag is a marker that points to a specific commit. It is used to mark releases or important milestones.  
- A **lightweight tag** is just a pointer to a commit.  
- An **annotated tag** stores additional metadata (author, date, message) and is preferred for official releases.

## Q3. What is the purpose of creating a "Release" on GitHub? 
A GitHub Release is a packaged, shareable version of the project. It signals a stable point in development.  
Attaching binaries (like `bin/client`) is useful because users can download and run the executable directly without compiling the source code themselves.
