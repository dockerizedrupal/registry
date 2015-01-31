(function($) {
  function convert_timestamp_to_datetime() {
    function format_datetime(timestamp) {
      function pad(s) {
        return (s < 10) ? '0' + s : s;
      }

      var d = new Date(timestamp * 1000);

      return [pad(d.getDate()), pad(d.getMonth() + 1), d.getFullYear()].join('.') + ' ' + [d.getHours(), d.getMinutes(), d.getSeconds()].join(':');
    }

    $('.tag-last-updated').each(function() {
      $(this).html(format_datetime($(this).html()));
    });
  }

  $(function() {
    setInterval(function() {
      $('#page').load(location.href + ' #page > *', function() {
        convert_timestamp_to_datetime();
      });
    }, 1000);

    convert_timestamp_to_datetime();
  });
})(jQuery);
