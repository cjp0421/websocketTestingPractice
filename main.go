package main

import (
	"fmt"

	"golang.org/x/net/websocket"
)

func main() {
	origin := "http://localhost/"
	url := "wss://7m2p4u8v02.execute-api.us-east-1.amazonaws.com/deleteMe/"
	_, err := websocket.Dial(url, "", origin)
	if err != nil {
		// log.Fatal(err)
		//on a bad connection, an error here has a value
		fmt.Println("Something happened: ", err)
	}
	// if _, err := ws.Write([]byte("hello, world!\n")); err != nil {
	// 	log.Fatal(err)
	// }
	// var msg = make([]byte, 512)
	// var n int
	// if n, err = ws.Read(msg); err != nil {
	// 	log.Fatal(err)
	// }
	// fmt.Printf("Received: %s.\n", msg[:n])
}
