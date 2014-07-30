$(function() {
  
  $('#sprite-image').click(function(event) {
    var x, y;

    x = Math.floor(event.pageX - $(this).offset().left);
    y = Math.floor(event.pageY - $(this).offset().top);
    url = $(this).attr('src')
    $('#mouseX').text(x);
    $('#mouseY').text(y);

    data = {
      x: x,
      y: y,
      imageURL: url
    }

    $.get('/image/colorpicker', data, function(response) {
      console.log(response.height);
      $('#color').text(response.response);
      $('body').css('background-color', response.bgColor)
    })

  })

});
