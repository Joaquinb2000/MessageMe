// Updates the message
substitute_message_with = function (new_message, id) {
    message_preview = $("#cr_".concat(id))
    message_preview.contents()[0].remove();
    message_preview.prepend(new_message)
}

// Updates the timestamp
new_timestamp = function (timestamp){
    old = $(".tiny.msg")
    old.first().text(timestamp)
}

// Gets the message and timestamp from the _message.html.erb view,
// and substitutes it in the chatrooms #show and #index views
chatroom_last_message = function(message, id) {
    display = message.match(/(?<=em>).*/)[0];
    timestamp = message.match(/(?<=msg">)\n.+/)[0];

    chatrooms = $(".chatrooms.menu");
    chatroom = $('a[href="/chatroom/'.concat(id, '"]'));
    chatroom_copy = null;

    if(chatroom.length === 0){
        chatroom = chatrooms.children().first()
        chatroom_copy = chatroom.clone()
        chatroom_copy.find(".chatroom_name").text("Chatroom ".concat(id))
        chatroom_copy.children().last().attr('id', "cr_".concat(id))
    }

    chatroom.remove()
    if (chatroom_copy) chatroom= chatroom_copy

    if(chatrooms.children() >= 10) chatrooms.children().last().remove();

    chatrooms.prepend(chatroom)
    substitute_message_with(display, id)
    new_timestamp(timestamp)
}
