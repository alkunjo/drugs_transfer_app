# App.notifications = App.cable.subscriptions.create "NotificationsChannel",
#   connected: ->
#     console.log("connected")
#     # Called when the subscription is ready for use on the server

#   disconnected: ->
#     console.log("disconnected")
#     # Called when the subscription has been terminated by the server

#   received: (data) ->
#     # console.log("received #{data.notification}")
#     # debugger;
#     $("#notifLink_#{data.recipients[0]}").click()
#     $("#notifLink_#{data.recipients[1]}").click()
#     $("#notifList_#{data.recipients[0]}").prepend("#{data.notification}")
#     $("#notifList_#{data.recipients[1]}").prepend("#{data.notification}")
#     $("#ntf_#{data.recipients[0]}").html '<i class="fa fa-bell faa-bounce animated"></i>'
#     $("#ntf_#{data.recipients[1]}").html '<i class="fa fa-bell faa-bounce animated"></i>'
#     $("#notifCounter_#{data.recipients[0]}").html "#{data.counter}"
#     $("#notifCounter_#{data.recipients[1]}").html "#{data.counter}"
#     # Called when there's incoming data on the websocket for this channel
