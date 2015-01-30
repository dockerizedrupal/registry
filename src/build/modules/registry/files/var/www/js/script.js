(function($) {
  function convert_timestamp_to_local_time() {
    $('.tag-last-updated').each(function() {
      var timestamp = $(this).html();

      console.log(timestamp);
      var time = new Date(timestamp * 1000);

      $(this).html(time);
    });
  }

  $(function() {
    setInterval(function() {
      $('#page').load(location.href + ' #page > *', function() {
        convert_timestamp_to_local_time();
      });
    }, 1000);

    convert_timestamp_to_local_time();
  });
})(jQuery);
