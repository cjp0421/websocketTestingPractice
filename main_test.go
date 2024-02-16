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

	// url := "wss://7m2p4u8v02.execute-api.us-east-1.amazonaws.com/deleteMe/" //would get from localstack?
	// url := "ws://localhost.localstack.cloud:4510/example-stage/" //would get from localstack?
	url := "ws://localhost:4510/example-stage/" //would get from localstack?

	//ACT
	ws, err := websocket.Dial(url, "", origin)

	//ASSERT
	require.Nil(err, "Expected websocket connection to succeed")

	fmt.Printf("DEBUG: websocket: %+v\n", ws)
	fmt.Printf("DEBUG: websocket: %+v\n", ws.IsClientConn())

	require.NotNil(ws, "Expected a websocket connection to have been created")

	defer ws.Close()

}
