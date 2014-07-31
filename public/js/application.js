var FRAME_DELAY = 100;

var frameList = [];
var currentFrame = 0;
var animating = false;

var Frame = function(x, y, width, height, offX, offY) {
  this.x = x;
  this.y = y;
  this.width = width;
  this.height = height;
  this.offX = offX;
  this.offY = offY;

  frameList.splice(currentFrame+1, 0, this);
}

$(function() {
  var img_width = $('#sprite-image').width()
  if(img_width > 600) {
    $('.main').css('width', img_width)
  }

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

    $.get('/image/bounds', data, function(response) {
      console.log(response);
      frame = new Frame(response.x, response.y, response.width, response.height, 0, 0)
      refreshFrameList();
      loadFrame(frame);
      
      if(frameList.length > 8) {
        $('#frame-list li').css('display', 'inline-block');
      }
    })
  });

  $('#frame-list').on('click', 'li', function() {
    stopAnimation();
    loadFrame(frameList[$(this).index()]);
  });

  $('#animate-button').click(function() {
    console.log(animating);
    if(animating) {
      stopAnimation();
    }
    else {
      animating = setInterval(function() {loadNextFrame()}, FRAME_DELAY);
      $('#animate-button').text('Stop');
    }
  })
});

function stopAnimation() {
  if(animating) {
    clearInterval(animating);
    animating = false;
    $('#animate-button').text('Animate');
  }
}


function loadFrame(frame) {
  $('#frame-list li').eq(currentFrame).css('background-color', 'white')

  $('#sprite-movable').css('left', 0-frame.x)
  $('#sprite-movable').css('top', 0-frame.y)
  $('.sprite').css('width', frame.width)
  $('.sprite').css('height', frame.height)

  currentFrame = frameList.indexOf(frame);

  $('#frame-list li').eq(currentFrame).css('background-color', '#ccccff')
}

function refreshFrameList() {
  var index;

  $('#frame-list').text('')

  for(index=0; index<frameList.length; index++) {
    $('#frame-list').append('<li>' + (index+1) + '</li>');
  }
}

function loadNextFrame() {
  var nextFrame = currentFrame + 1;
  if(nextFrame >= frameList.length) {
    nextFrame = 0;
  }
  loadFrame(frameList[nextFrame]);
}