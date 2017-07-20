# App.notifications = App.cable.subscriptions.create "NotificationsChannel",
#   connected: ->
#     console.log("connected")
#     # Called when the subscription is ready for use on the server

#   disconnected: ->
#     console.log("disconnected")
#     # Called when the subscription has been terminated by the server

#   received: (data) ->
#     # console.log("received #{data.notification}")
#     debugger;
#     for notif in data['notifications']
#         do (notif) ->
#         console.log(notif[0]+"-> has notif "+notif[1])
#         $("#notifLink_"+notif[0]+"").click()        
#         $("#notifList_"+notif[0]+"").prepend(""+notif[1]+"")
#         $("#ntf_"+notif[0]+"").html('<i class="fa fa-bell faa-bounce animated"></i>')
            
#     for count in data['counters']
#         do (count) ->
#         console.log(count[0]+"-> has counter"+count[1])
#         $("#notifCounter_"+count[0]+"").html(""+count[1]+"")
