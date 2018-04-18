$(document).ready(function(){
  alert('tets')
  $('#animate').css('opacity', 0);

  $('#animate').waypoint(function() {
       $('#animate').addClass('slideInRight');
    }
  }, { offset: '100%'});
});
