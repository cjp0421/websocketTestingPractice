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
	url := "wss://7m2p4u8v02.execute-api.us-east-1.amazonaws.com/deleteMe/" //would get from localstack?

	//ACT
	ws, err := websocket.Dial(url, "", origin)
	if err != nil {
		// on a bad connection, error here has a value
		fmt.Println("Something happened: ", err)

		// ASSERT
		require.Nil(err, "Expected err to be nil")
		require.Nil(ws, "Expected ws to be nil")
		return
	}
	defer ws.Close()

}
