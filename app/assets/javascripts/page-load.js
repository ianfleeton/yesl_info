function pageLoad() {
  search();
}

$(function() {
  pageLoad();
});

$(document).bind('page:load', function() {
  pageLoad();
});
