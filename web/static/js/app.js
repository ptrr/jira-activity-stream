// Brunch automatically concatenates all files in your
// watched paths. Those paths can be configured at
// config.paths.watched in "brunch-config.js".
//
// However, those files will only be executed if
// explicitly imported. The only exception are files
// in vendor, which are never wrapped in imports and
// therefore are always executed.

// Import dependencies
//
// If you no longer want to use a dependency, remember
// to also remove its path from "config.paths.watched".
import "deps/phoenix_html/web/static/js/phoenix_html"

// Import local files
//
// Local files can be imported directly using relative
// paths "./socket" or full ones "web/static/js/socket".

// import socket from "./socket"
import {Socket} from "deps/phoenix/web/static/js/phoenix"

let socket = new Socket("/jira")
socket.connect()
let chan = socket.channel("activity:test", {})
let messageContainer = $(".jumbotron")

chan.join().receive("ok", chan => {
  console.log("Welcome to Jira Activity")
})

//TESTING
var rec = function() {
	chan.push("test:message", {content: "test"});
	chan.push("activity:update", {type: 'update', content: "UPDATE"});

	console.log("Sending Test message")
	setTimeout(rec, 500);
}

chan.on("test:message", payload => {
  messageContainer.append(`<br/>[${Date()}] ${payload.content}`)
})

chan.on("acvitity:update", payload => {messageContainer.append(`<br/>[${Date()}] ${payload.content}`)})

rec()