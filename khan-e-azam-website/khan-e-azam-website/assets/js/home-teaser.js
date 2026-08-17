(function () {
  'use strict';

  var LAUNCH_TARGET = new Date('2026-08-25T19:00:00Z').getTime();
  var reduceMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

  function pad2(n) {
    return String(n).padStart(2, '0');
  }

  function remaining() {
    var diff = Math.max(0, LAUNCH_TARGET - Date.now());
    return {
      days: Math.floor(diff / 86400000),
      hours: Math.floor((diff / 3600000) % 24),
      minutes: Math.floor((diff / 60000) % 60),
      seconds: Math.floor((diff / 1000) % 60)
    };
  }

  function initCountdown() {
    var daysEl = document.querySelector('[data-countdown="days"]');
    var hoursEl = document.querySelector('[data-countdown="hours"]');
    var minutesEl = document.querySelector('[data-countdown="minutes"]');
    var secondsEl = document.querySelector('[data-countdown="seconds"]');
    if (!daysEl || !hoursEl || !minutesEl || !secondsEl) return;

    function tick() {
      var t = remaining();
      daysEl.textContent = pad2(t.days);
      hoursEl.textContent = pad2(t.hours);
      minutesEl.textContent = pad2(t.minutes);
      secondsEl.textContent = pad2(t.seconds);
    }

    tick();
    window.setInterval(tick, 1000);
  }

  function initHeroSlides() {
    var slides = document.querySelectorAll('.hero-slide');
    var dots = document.querySelectorAll('.hero-slide-dot');
    if (!slides.length) return;

    var currentIndex = 0;
    var intervalMs = 6500;

    function showSlide(index) {
      currentIndex = index;
      slides.forEach(function (slide, i) {
        var active = i === index;
        slide.classList.toggle('is-active', active);
        if (active) {
          var img = slide.querySelector('.hero-slide-img');
          if (img) {
            img.style.animation = 'none';
            void img.offsetWidth;
            img.style.animation = '';
          }
        }
      });
      dots.forEach(function (dot, i) {
        dot.classList.toggle('is-active', i === index);
        dot.setAttribute('aria-current', i === index ? 'true' : 'false');
      });
    }

    function nextSlide() {
      showSlide((currentIndex + 1) % slides.length);
    }

    dots.forEach(function (dot, i) {
      dot.addEventListener('click', function () {
        showSlide(i);
      });
    });

    showSlide(0);
    window.setInterval(nextSlide, intervalMs);
  }

  function initHeroVideo() {
    var video = document.querySelector('.hero-video');
    if (!video) return;
    video.muted = true;
    video.playsInline = true;
    var playPromise = video.play();
    if (playPromise && typeof playPromise.catch === 'function') {
      playPromise.catch(function () { /* autoplay blocked */ });
    }
  }

  function initExperienceVideo() {
    var video = document.querySelector('.experience-video');
    if (!video) return;
    video.muted = true;
    video.playsInline = true;
    video.loop = true;
    var playPromise = video.play();
    if (playPromise && typeof playPromise.catch === 'function') {
      playPromise.catch(function () { /* autoplay blocked */ });
    }
  }

  function initExperienceParallax() {
    if (reduceMotion) return;
    var frame = document.querySelector('.experience-visual');
    var media = document.querySelector('.experience-video');
    if (!frame || !media) return;

    function onScroll() {
      var rect = frame.getBoundingClientRect();
      var vh = window.innerHeight;
      var start = vh;
      var end = -rect.height;
      var progress = (rect.top - start) / (end - start);
      progress = Math.min(1, Math.max(0, progress));
      var y = -8 + progress * 16;
      media.style.transform = 'translate3d(0, ' + y + '%, 0)';
    }

    window.addEventListener('scroll', onScroll, { passive: true });
    onScroll();
  }

  function initReveal() {
    var items = document.querySelectorAll('.reveal');
    if (!items.length) return;

    if (reduceMotion || !('IntersectionObserver' in window)) {
      items.forEach(function (el) {
        el.classList.add('is-visible');
      });
      return;
    }

    var observer = new IntersectionObserver(
      function (entries) {
        entries.forEach(function (entry) {
          if (entry.isIntersecting) {
            entry.target.classList.add('is-visible');
            observer.unobserve(entry.target);
          }
        });
      },
      { root: null, rootMargin: '-80px 0px', threshold: 0.12 }
    );

    items.forEach(function (el) {
      observer.observe(el);
    });
  }

  function init() {
    initCountdown();
    initHeroVideo();
    initExperienceVideo();
    initHeroSlides();
    initExperienceParallax();
    initReveal();
  }

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
