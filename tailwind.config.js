/** @type {import('tailwindcss').Config} */
export default {
    mode: 'jit',
    prefix: 'tw-',
    content: ['./resources/**/*.blade.php', './resources/**/*.js', './resources/**/*.vue'],
    theme: {
        extend: {
            fontFamily: {},
        },
    },
    plugins: [require('@tailwindcss/typography')],
};
