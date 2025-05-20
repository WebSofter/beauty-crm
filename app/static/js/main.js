// deleteResource(e, '{% url 'services:category_delete' category.id %}', '{{ csrf_token }}')
const deleteResource = (e, url, token) => {
  e.preventDefault();
  if(confirm('Вы уверены?')) {
    fetch(
        //'{% url 'services:category_delete' category.id %}'
        url, {
      method: 'POST',
      headers: {
        'X-CSRFToken': token, //'{{ csrf_token }}',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: ''
    }).then(response => {
      if(response.redirected) {
        window.location.href = response.url;
      }
    });
  }
}

document.addEventListener('DOMContentLoaded', function () {
  const buttons = document.querySelectorAll('.accordion-button');

  buttons.forEach(button => {
    button.addEventListener('click', function () {
      const item = this.closest('.accordion-item');
      const content = item.querySelector('.accordion-content');
      const icon = this.querySelector('svg');

      // Toggle current item
      content.classList.toggle('hidden');
      icon.classList.toggle('rotate-180');

      // Close other items
      buttons.forEach(otherButton => {
        if (otherButton !== button) {
          const otherItem = otherButton.closest('.accordion-item');
          const otherContent = otherItem.querySelector('.accordion-content');
          const otherIcon = otherButton.querySelector('svg');

          otherContent.classList.add('hidden');
          otherIcon.classList.remove('rotate-180');
        }
      });
    });
  });
});

(function ($) {

  "use strict";

  var initPreloader = function () {
    $(document).ready(function ($) {
      var Body = $('body');
      Body.addClass('preloader-site');
    });
    $(window).load(function () {
      $('.preloader-wrapper').fadeOut();
      $('body').removeClass('preloader-site');
    });
  }

  var initSliderfeature = function () {
    var feature_swiper = new Swiper(".feature-swiper", {
      spaceBetween: 30,
      breakpoints: {
        0: {
          slidesPerView: 1,
          spaceBetween: 20,
        },
        767: {
          slidesPerView: 2,
          spaceBetween: 20,
        },
        1299: {
          slidesPerView: 3,
          spaceBetween: 20,
        },
      },
    });

  };

  var initSlider = function () {
    var swiper = new Swiper(".review-swiper", {
      slidesPerView: 3,
      spaceBetween: 30,
      freemode: true,
      pagination: {
        el: ".swiper-pagination",
        clickable: true,
      },
      breakpoints: {
        0: {
          slidesPerView: 1,
          spaceBetween: 20,
        },
        767: {
          slidesPerView: 2,
          spaceBetween: 20,
        },
        1299: {
          slidesPerView: 3,
          spaceBetween: 20,
        },
      },
    });

  };


  $(document).ready(function () {

    AOS.init({
      duration: 1200,
      once: true,
    })

    $(".youtube").colorbox({
      iframe: true,
      innerWidth: 960,
      innerHeight: 585
    });


    initPreloader();
    initSliderfeature();
    initSlider();
    // headerSticky();

  }); // End of a document

})(jQuery);