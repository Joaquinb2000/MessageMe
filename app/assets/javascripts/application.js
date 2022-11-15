// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require semantic-ui
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .

scroll_bottom = ()=>{
    if ($('#message-board').length > 0){
        $('#message-board').scrollTop($('#message-board')[0].scrollHeight)
    }
}

chatroom_last_message = (message, id) => {
    display = message.match(/(?<=em>).*/)[0];

    chatrooms = $(".chatrooms.menu");
    chatroom = $(`a[href="/chatroom/${id}"]`);
    chatroom_copy = null;

    if(chatroom.length === 0){
        chatroom = chatrooms.children().first()
        chatroom_copy = chatroom.clone()
        chatroom_copy.find(".chatroom_name").text(`Chatroom ${id}`)
        chatroom_copy.children().last().attr('id', `cr_${id}`)
    }

    chatroom.remove()
    if (chatroom_copy) chatroom= chatroom_copy

    if(chatrooms.children() >= 10) chatrooms.children().last().remove();

    chatrooms.prepend(chatroom)
    message_preview = $(`#cr_${id}`)
    message_preview.contents()[0].remove();
    message_preview.prepend(display)
}

$(document).on('turbolinks:load', ()=> {
    $('.ui.dropdown').dropdown();

    $('.message .close').on('click', function() {
        $(this).closest('.message').transition('fade');
    });

    scroll_bottom();
})


