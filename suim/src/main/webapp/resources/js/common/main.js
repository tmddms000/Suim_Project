 $(document).ready(function() {
	  $('.slider__slides').slick({
	    dots: true,
	    appendDots: $('.slider__dots'),
	    prevArrow: $('.slider__prev'),
	    nextArrow: $('.slider__next'),
	    slidesToShow: 4,
	  slidesToScroll: 4,
	  });
	});
	
   document.addEventListener('DOMContentLoaded', () => {

       new TypeIt('#text', {
       speed: 100,
       startDelay: 900,
       afterComplete: function (instance) { //
               instance.destroy();
           } 
       })
       .pause(1000)
       .delete(22, { delay : 1000 })
       .type('라고 고민될땐?', { delay : 1000 })
       .move(5)
       .delete(10)
       .type('지금 당장 가입해보세요. ')
       .type('<span style="color: #fa6b6f;">"쉼"</span>', { delay : 1000 })
       .go();
       
   });