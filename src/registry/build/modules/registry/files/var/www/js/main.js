(function($) {
  $(function() {
    var latest_version = function($context) {
      $context.each(function() {
        var self = this;

        var version_file = $(self).attr('data-version-file');

        if (!version_file) {
          return;
        }

        $.ajax({
          url: version_file,
          success: function(version) {
            version = $.trim(version);

            if (!version) {
              return;
            }

            var $latest_version = $(self);
            var $current_version = $latest_version.prev();

            if (version === $('.version', $current_version).html()) {
              var $label = $('.label', $current_version);

              $label.removeClass('label-info');
              $label.addClass('label-success');
            }
            else {
              $current_version.hide();
              $latest_version.show();
            }
          }
        });
      });
    };

    latest_version($('.latest-version'));

    var last_updated = function($context) {
      function format_datetime(timestamp) {
        function pad(s) {
          return (s < 10) ? '0' + s : s;
        }

        var d = new Date(timestamp * 1000);

        return [pad(d.getDate()), pad(d.getMonth() + 1), d.getFullYear()].join('.') + ' ' + [pad(d.getHours()), pad(d.getMinutes()), pad(d.getSeconds())].join(':');
      }

      $context.each(function() {
        $(this).html(format_datetime($(this).html()));
      });
    };

    last_updated($('.last-updated'));
  });
})(jQuery);
