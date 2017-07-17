App.notifications = App.cable.subscriptions.create "NotificationsChannel",
  connected: ->
  	console.log("connected")
    # Called when the subscription is ready for use on the server

  disconnected: ->
  	console.log("disconnected")
    # Called when the subscription has been terminated by the server

  received: (data) ->
  	console.log("received #{data.notification}")
  	# $('#notifDropdown').show
   #  $('#notifList').prepend "#{data.notification}"
   #  $('#ntf').html '<i class="fa fa-bell faa-bounce animated"></i>'
    # Called when there's incoming data on the websocket for this channel
