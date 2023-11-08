# Compiler and flags
CC=gcc
CFLAGS=-Wall -Wextra -g
FORMAT=clang-format -i

# Name of the executable
TARGET=db

# Directory for object files
OBJDIR=object

# All .c files in the src directory
SOURCES=$(wildcard src/*.c)

# Corresponding .o files within the object directory
OBJECTS=$(patsubst src/%.c,$(OBJDIR)/%.o,$(SOURCES))

# Header files
HEADERS=$(wildcard src/*.h)

# Default make target
all: $(TARGET)

# Rule to create the object directory if it doesn't exist
$(OBJDIR):
	mkdir -p $(OBJDIR)

# Rule to create the executable
$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) -o $@ $^

# Rule to create .o files from .c files
$(OBJDIR)/%.o: src/%.c $(HEADERS) | $(OBJDIR)
	$(CC) $(CFLAGS) -c $< -o $@

# Rule for 'make run'
run: $(TARGET)
	./$(TARGET)

# Rule for 'make db' (debug - already handled by the all/CFLAGS)
# Rule to create the executable
$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) -o $@ $(OBJECTS)

# Rule for 'make clean'
clean:
	rm -f $(TARGET)
	rm -rf $(OBJDIR)

# Rule for 'make format'
format:
	$(FORMAT) $(SOURCES) $(HEADERS)

.PHONY: all run db clean format
