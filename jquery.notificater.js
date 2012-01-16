
  (function($) {
    var $container, add, createContainer, defaultOptions, messages, render, renderNotification, width;
    $container = null;
    messages = [];
    defaultOptions = {
      duration: 5000,
      sticky: false,
      closeable: true,
      offset: [6, 0]
    };
    add = function(message, options) {
      if (options == null) options = {};
      messages.push($.extend({}, {
        message: message
      }, defaultOptions, options));
      if (!$container) createContainer();
      return render();
    };
    createContainer = function() {
      $(document.body).append("<div id=\"notifications\" style=\"display:none;position:fixed;top:0;left:50%\">\n  <div class=\"message-container\" style=\"position:relative\">\n    <span class=\"message\"></span>\n    <a href=\"#\" class=\"notification-close\" style=\"display:none\">x</a>\n  </div>\n</div>");
      $container = $("#notifications");
      return $container.find(".notification-close").click(function() {
        $container.fadeOut(render);
        return false;
      });
    };
    width = function() {
      var w;
      $container.css({
        visibility: "hidden",
        display: ""
      });
      w = $container.find(".message-container").width();
      $container.css({
        visibility: "",
        display: "none"
      });
      return w;
    };
    render = function() {
      var msg;
      if ($container.is(":visible") || messages.length <= 0) return;
      renderNotification(msg = messages.shift());
      $container.fadeIn();
      if (!msg.sticky) return $container.delay(msg.duration).fadeOut(render);
    };
    renderNotification = function(msg) {
      var $close;
      $container.find(".message").html(msg.message);
      $container.find(".message-container").css({
        left: -(width() / 2.0) + msg.offset[1],
        top: msg.offset[0]
      });
      $close = $container.find(".notification-close");
      if (msg.sticky && msg.closeable) {
        return $close.show();
      } else {
        return $close.hide();
      }
    };
    return $.notificate = function(message, options) {
      if (options == null) options = {};
      return add(message, options);
    };
  })(jQuery);
