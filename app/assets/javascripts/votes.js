// app/assets/javascripts/votes.js

$(document).ready(function() {
  $('[data-link="up"]').on('click', function(event) {
    event.preventDefault();

    $link = $(event.currentTarget);

    $.ajax({
      type: 'PUT',
      url: $link.attr('href'),
      dataType: 'json',
      success: function(data) {
        $span = $('#' + data.id + '-upvotes')
        $span.html(data.size)
      },
      error: function() {
        alert('An error occurred')
      }
    });
  })
  $('[data-link="down"]').on('click', function(event) {
    event.preventDefault();

    $link = $(event.currentTarget);

    $.ajax({
      type: 'PUT',
      url: $link.attr('href'),
      dataType: 'json',
      success: function(data) {
        $span = $('#' + data.id + '-downvotes')
        $span.html(data.size)
      },
      error: function() {
        alert('An error occurred')
      }
    });
  })
});
