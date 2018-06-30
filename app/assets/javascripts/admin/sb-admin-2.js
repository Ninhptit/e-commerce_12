$(function () {
  $('#side-menu').metisMenu()
    
});
$(document).on('turbolinks:load',function() {
  addFields();
  removeFields();
});

addFields = function (){
  $('#add_fields').on('click', function (even) {
    even.preventDefault();
    time = new Date().getTime();
    regexp = new RegExp($('#add_fields').data('id'), 'g');
    $('.new-field').append($('#add_fields')
    .data('fields').replace(regexp, time));
  });
}

removeFields = function() {
  $('.destroy').on('click', function(even){
    $(this).closest('.field').remove();
  });
}

$(function () {
  $(window).bind('load resize', function () {
    var topOffset = 50;
    var width = (this.window.innerWidth > 0) ? this.window.innerWidth : this.screen.width;
    if (width < 768) {
      $('div.navbar-collapse').addClass('collapse');
      topOffset = 100; // 2-row-menu
    } else {
      $('div.navbar-collapse').removeClass('collapse');
    }

    var height = ((this.window.innerHeight > 0) ? this.window.innerHeight : this.screen.height) - 1;
    height = height - topOffset;
    if (height < 1) height = 1;
    if (height > topOffset) {
      $('#page-wrapper').css('min-height', (height) + 'px');
    }
  });

  var url = window.location;
  var element = $('ul.nav a').filter(function () {
    return this.href == url;
  }).addClass('active').parent();

  while (true) {
    if (element.is('li')) {
      element = element.parent().addClass('in').parent();
    } else {
      break;
    }
  }
});

$(document).on('turbolinks:load',function() {
  addFields();
  removeFields();
});

addFields = function() { 
  $('#add_fields').on('click', (even) => {
    even.preventDefault();
    let data = $('#add_fields').data('fields');
    time = new Date().getTime();
    regexp = new RegExp($('#add_fields').data('id'), 'g');
    $('.new-fields').append($('#add_fields')
    .data('fields').replace(regexp, time));
  });
}

removeFields = function() {
  $('.destroy').on('click', (even) => {
    even.preventDefault();
    $('.new-fields').hide();
    console.log(this);
  });
}
