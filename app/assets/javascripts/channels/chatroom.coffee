App.chatroom = App.cable.subscriptions.create "ChatroomChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    $('#message-display').append data.mod_message
    $('#message_body').val("")
    scroll_bottom()
    chatroom_last_message(data.mod_message, data.chatroom_id)

