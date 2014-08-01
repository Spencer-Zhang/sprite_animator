var frameDelay = 100;

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

$(window).load(function() {
  var img_width = $('#sprite-image').width()

  $('.csv-frame').hide();

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
      animating = setInterval(function() {loadNextFrame()}, frameDelay);
      $('#animate-button').text('Stop');
    }
  })

  $('.parameters').on('change', 'input', function() {
    parameter = $(this).attr('id');
    frameList[currentFrame][parameter] = parseInt($(this).val());
    loadFrame(frameList[currentFrame]);
  })

  $('#csv-button').click(function(){ 
    $('.csv-frame textarea').val(writeCSV());
    $('.csv-frame').show();
  })

  $('.csv-frame button').click(function() {
    $('.csv-frame').hide();
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
  $('#frame-list li').eq(currentFrame).css('background-color', 'white');

  $('#sprite-movable').css('left', 0-frame.x);
  $('#sprite-movable').css('top', 0-frame.y);
  $('.sprite').css('width', frame.width);
  $('.sprite').css('height', frame.height);
  $('.sprite').css('left', frame.offX);
  $('.sprite').css('top', frame.offY);

  currentFrame = frameList.indexOf(frame);

  $('input#x').val(frame.x);
  $('input#y').val(frame.y);
  $('input#width').val(frame.width);
  $('input#height').val(frame.height);
  $('input#offX').val(frame.offX);
  $('input#offY').val(frame.offY);


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



function writeCSV() {
  var text = ""
  for(frame in frameList) {
    text += frameList[frame].x + ", " + frameList[frame].y + ", "
    text += frameList[frame].width + ", " + frameList[frame].height + ", "
    text += frameList[frame].offX + ", " + frameList[frame].offY + "\n"
  }
  return text
}