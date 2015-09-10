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
let messageContainer = $(".list-group")

chan.join().receive("ok", chan => {
  console.log("Welcome to Jira Activity")
})

//TESTING
var rec = function() {
  //chan.push("test:message", {content: "test"});
  chan.push("activity:update", {type: 'complete', content: "UPDATE", name: "Peter", item: "BE-999"});
  //console.log("Sending Test message")
  setTimeout(rec, (Math.random() * 10000) + 1);
}

var rec2 = function() {
  //chan.push("test:message", {content: "test"});
  chan.push("activity:update", {type: 'start', content: "UPDATE", name: "Alex", item: "ST-999"});
  //console.log("Sending Test message")
  setTimeout(rec2, (Math.random() * 10000) + 1);
}

var rec3 = function() {
  //chan.push("test:message", {content: "test"});
  chan.push("activity:update", {type: 'update', content: "UPDATE", name: "Marcel", item: "BL-999"});
  //console.log("Sending Test message")
  setTimeout(rec3, (Math.random() * 10000) + 1);
}

var rec4 = function() {
  //chan.push("test:message", {content: "test"});
  chan.push("activity:update", {type: 'new', content: "UPDATE", name: "Koop", item: "BL-999"});
  //console.log("Sending Test message")
  setTimeout(rec4, (Math.random() * 10000) + 1);
}

chan.on("test:message", payload => {
  messageContainer.prepend(
    $(`<a href='#' style='display: block' class='list-group-item list-group-item-success'><abbr class='timeago' title='${Date()}'></abbr> &nbsp; ${payload.content}</a>`).fadeIn('slow').removeClass('list-group-item-success', 1000)
  )
  $("abbr.timeago").timeago();
  messageContainer.children('a').slice(18).remove();
})

chan.on("acvitity:update", payload => {messageContainer.append(`<br/>[${Date()}] ${payload.content}`)})

rec()
rec2()
rec3()
rec4()
