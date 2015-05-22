function search() {
  var doSearch = function() {
    console.log('...');
    $.ajax({
      url: '/search',
      data: {
        query: $('#search-query').val()
      }
    }).done(function(data) {
      $('#search-results').replaceWith(data);
    });
  };

  $('#search-query').on('input', doSearch).focus();
}
