import hljs from 'highlight.js';
import xml from 'highlight.js/lib/languages/xml';
import css from 'highlight.js/lib/languages/css';
import bash from 'highlight.js/lib/languages/bash';

// Register languages
hljs.registerLanguage('xml', xml);
hljs.registerLanguage('css', css);
hljs.registerLanguage('bash', bash);

// Initialize highlight.js
hljs.highlightAll();

function initializeThemeSwitcher() {
    const themeToggle = document.getElementById('theme-toggle');
    const lightThemeCss = document.getElementById('hljs-light-theme');
    const darkThemeCss = document.getElementById('hljs-dark-theme');

    if (!themeToggle) return;

    // Function to set theme
    const setTheme = (theme) => {
        document.documentElement.setAttribute('data-theme', theme);
        if (theme === 'dark') {
            lightThemeCss.disabled = true;
            darkThemeCss.disabled = false;
        } else {
            lightThemeCss.disabled = false;
            darkThemeCss.disabled = true;
        }
        localStorage.setItem('theme', theme);
    };

    // Toggle theme on button click
    themeToggle.addEventListener('click', () => {
        const currentTheme = document.documentElement.getAttribute('data-theme') || 'light';
        const newTheme = currentTheme === 'light' ? 'dark' : 'light';
        setTheme(newTheme);
    });

    // Apply saved theme or system preference on load
    const savedTheme = localStorage.getItem('theme');
    const prefersDark = window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches;

    if (savedTheme) {
        setTheme(savedTheme);
    } else if (prefersDark) {
        setTheme('dark');
    } else {
        setTheme('light');
    }
}

// The DOM is ready after the XSLT transformation
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initializeThemeSwitcher);
} else {
    initializeThemeSwitcher();
}