var timer;
var slides = new Array();

//slides    FILENAME  ALT URL
slides[0] = ["images/banner1.jpg"];
slides[1] = ["images/banner2.jpg"];
slides[2] = ["images/banner3.jpg"];
slides[3] = ["images/banner4.jpg"];
slides[4] = ["images/banner5.jpg"];
slides[5] = ["images/banner6.jpg"];


function getCurrentSlide() {

  var obj = document.getElementById("hdnSlideIndex");
  return parseInt(obj.value);

}

function saveCurrentSlide(slideIndex) {

  var obj = document.getElementById("hdnSlideIndex");
  obj.value = slideIndex;

}

function NextSlide() {

  ChangeSlide(getCurrentSlide() + 1);

}

function ChangeSlide(newSlideIndex) {

  clearTimeout(timer);

  if (newSlideIndex >= slides.length || newSlideIndex < 0) {
    newSlideIndex = 0;
  }

  jQuery("#mainBody").css("background", "none");
  jQuery("#main-body-bg").fadeOut("slow", function() {
    jQuery("#main-body-bg").css("background", "url(" + slides[newSlideIndex][0] + ") center center no-repeat");
    jQuery("#main-body-bg").fadeIn("slow");
  });

  SetSlideLink(newSlideIndex);

  saveCurrentSlide(newSlideIndex);

  timer = setTimeout("NextSlide()", 4000);

}

function SetSlideLink(slideIndex) {

  if (slideIndex >= slides.length || slideIndex < 0) {
    slideIndex = 0;
  }

  jQuery("#slideOverlay").attr("alt", slides[slideIndex][1]);
  jQuery("#image-map-learnmore").attr("href", slides[slideIndex][2]);

}

jQuery(document).ready(function() {

  jQuery(document).pngFix();
  
  SetSlideLink(0);
  timer = setTimeout("NextSlide()", 7000);

});
