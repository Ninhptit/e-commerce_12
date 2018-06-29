$(document).on('turbolinks:load',() => {
  activeNav();
  createSilerProduct();
  $('[data-toggle="tooltip"]').tooltip();
  $('#quantity').on('change', function() {
    console.log("test");
  })
  
});

$(document).ready(function(){
  $('[data-toggle="tooltip"]').tooltip(); 
});

var activeNav = () => {
  $('li.active').removeClass('active');
  $('a[href="' + location.pathname + '"]').closest('li').addClass('active');
}

createSilerProduct = () => {
  if(!$('div.hot-product').hasClass('active')){
    $('div.hot-product').first().addClass('active');
  }

  $('.carousel[data-type="multi"] .item').each(function(){
    var next = $(this).next();
    if (!next.length) {
      next = $(this).siblings(':first');
    }
    next.children(':first-child').clone().appendTo($(this));

    for (var i=0;i<2;i++) {
      next=next.next();
      if (!next.length) {
        next = $(this).siblings(':first');
      }
      next.children(':first-child').clone().appendTo($(this));
    }
  });
}
$('#myModal').on('shown.bs.modal', function () {
  $('#myInput').focus()
})

