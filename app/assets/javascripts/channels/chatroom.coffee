App.chatroom = App.cable.subscriptions.create "ChatroomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->

    if ($('#user').contents().first().text().trim() != data.user)
      data.mod_message = data.mod_message.split(" right floated").join(" ")
      data.mod_message = data.mod_message.split("blue ").join("compact ")

    $('#message-display').append data.mod_message
    $('#message_body').val("")
    scroll_bottom()
    chatroom_last_message(data.mod_message, data.chatroom_id)

