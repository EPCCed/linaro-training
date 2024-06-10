CXX?=CC
CFLAGS= -g -O2 -fopenmp # -fsanitize=address -fsanitize=threads
LDFLAGS= -fopenmp #-fsanitize=address  -fsanitize=threads
OBJS= errors.o

all: test

.PHONY: all 

test: $(OBJS)
	$(CXX) -o $@ $^ $(LDFLAGS)

%.o: %.cpp
	$(CXX) $(CFLAGS) -c $< -o $@



clean:
	rm -f *.o test
