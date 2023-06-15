window.addEventListener('DOMContentLoaded', event => {

    // Navbar shrink function
    var navbarShrink = function () {
        const navbarCollapsible = document.body.querySelector('#mainNav');
        if (!navbarCollapsible) {
            return;
        }
        if (window.scrollY === 0) {
            navbarCollapsible.classList.remove('navbar-shrink')
        } else {
            navbarCollapsible.classList.add('navbar-shrink')
        }

    };

    // Shrink the navbar 
    navbarShrink();

    // Shrink the navbar when page is scrolled
    document.addEventListener('scroll', navbarShrink);

    // Activate Bootstrap scrollspy on the main nav element
    const mainNav = document.body.querySelector('#mainNav');
    if (mainNav) {
        new bootstrap.ScrollSpy(document.body, {
            target: '#mainNav',
            rootMargin: '0px 0px -40%',
        });
    };

    // Collapse responsive navbar when toggler is visible
    const navbarToggler = document.body.querySelector('.navbar-toggler');
    const responsiveNavItems = [].slice.call(
        document.querySelectorAll('#navbarResponsive .nav-link')
    );
    responsiveNavItems.map(function (responsiveNavItem) {
        responsiveNavItem.addEventListener('click', () => {
            if (window.getComputedStyle(navbarToggler).display !== 'none') {
                navbarToggler.click();
            }
        });
    });

});

const containerFluid = document.querySelector('.header');
const image = containerFluid.querySelector('.logo');

function applyFixedPosition() {
if (window.innerWidth >= 1399) {
    image.style.position = 'fixed';
    image.style.top = '15px';
} else {
    image.style.position = '';
    image.style.top = '';
}
}

// Apply the fixed position when the document loads
applyFixedPosition();

containerFluid.addEventListener('mouseenter', applyFixedPosition);

containerFluid.addEventListener('mouseleave', applyFixedPosition);

// Update the fixed position when the window is resized
window.addEventListener('resize', applyFixedPosition);



