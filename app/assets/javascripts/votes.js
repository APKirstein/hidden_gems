// app/assets/javascripts/votes.js

$(document).ready(function() {
  $('.upvote').on('click', function(event) {
    event.preventDefault();

    $.ajax({
      type: 'PUT',
      url: $(event.currentTarget).attr('href'),
      dataType: 'json',
      success: function(data) {
        $('#' + data.id + '-upvotes').html(data.upsize);
        $('#' + data.id + '-downvotes').html(data.downsize);
      },
      error: function() {
        alert('An error occurred');
      }
    });
  });

  $('.downvote').on('click', function(event) {
    event.preventDefault();

    $.ajax({
      type: 'PUT',
      url: $(event.currentTarget).attr('href'),
      dataType: 'json',
      success: function(data) {
        $('#' + data.id + '-downvotes').html(data.downsize);
        $('#' + data.id + '-upvotes').html(data.upsize);
      },
      error: function() {
        alert('An error occurred');
      }
    });
  });
});
