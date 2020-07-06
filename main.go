package main

import (
	"fmt"
)

func main() {
	hello("Russell")
}

// hello will greet whoever enters their name into the function
// it will use the first argument to the function as the name to greet.
func hello(name string) {
	greeting := fmt.Sprintf("Hello %s", name)
	fmt.Println(greeting)
}
