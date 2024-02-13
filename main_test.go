package main

import (
	"fmt"
	"testing"

	"github.com/stretchr/testify/require"
	"golang.org/x/net/websocket"
)

func TestWebsocketErrorIsNil(t *testing.T) {
	require := require.New(t)
	//ARRANGE

	origin := "http://localhost/"
	// url := "wss://7m2p4u8v02.execute-api.us-east-1.amazonaws.com/deleteMe/"
	url := "wss://81ehusgwm1.execute-api.us-east-1.amazonaws.com/example-stage/"

	// url := "ws://localhost.localstack.cloud:4510/example-stage" //would get from localstack

	//ACT
	ws, err := websocket.Dial(url, "", origin)

	// on a bad connection, error here has a value
	fmt.Println("Something happened: ", err)
	// added to stop this error: runtime error: invalid memory address or nil pointer dereference
	// ASSERT
	require.Nil(err, "Expected err to be nil")
	require.NotNil(ws, "Expected ws to not be nil")

}
