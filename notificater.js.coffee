(($) ->
  $container = null
  messages = []
  defaultOptions =
    duration:   5000
    sticky:     false   # don't automatically close if true
    closeable:  true    # show close button or not on sticky notifications
    offset:     [6, 0]  # offset [top, left]

  add = (message, options={}) ->
    messages.push($.extend {}, {message: message}, defaultOptions, options)
    createContainer() unless $container
    render()

  createContainer = ->
    $(document.body).append """
      <div id="notifications" style="display:none;position:fixed;top:0;left:50%">
        <div class="message-container" style="position:relative;color:#444;padding:3px 8px;background-color:#fee9cc">
          <span class="message"></span>
          <a href="#" class="notification-close" style="display:none;padding-left:0.5em">x</a>
        </div>
      </div>
      """
    $container = $("#notifications")
    $container.find(".notification-close").click(-> $container.fadeOut(render); false)

  width = ->
    # need to turn display attribute on so width can be calculated but
    # we set it's visibility to be hidden so nothing is actually displayed
    $container.css({visibility: "hidden", display: ""})
    w = $container.find(".message-container").width()
    $container.css({visibility: "", display: "none"})
    w

  render = ->
    return if $container.is(":visible") || messages.length <= 0

    renderNotification(msg = messages.shift())
    $container.fadeIn()
    $container.delay(msg.duration).fadeOut(render) unless msg.sticky

  renderNotification = (msg) ->
    $container.find(".message").html(msg.message)
    $container.find(".message-container").css
      left: -(width() / 2.0) + msg.offset[1]
      top:  msg.offset[0]

    $close = $container.find(".notification-close")
    if msg.sticky && msg.closeable then $close.show() else $close.hide()

  $.notificate = (message, options={}) -> add(message, options)
)(jQuery)