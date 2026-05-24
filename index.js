#!/usr/bin/env node

console.log('🎭 Welcome to Fragle - Captain Rattlecode Edition!');
console.log('🧭 Initializing the chaos engine...\n');

const quotes = [
    "Only a fool pings twice.",
    "The network remembers all.",
    "Trust no CAPTCHA.",
    "Cookies are the currency of truth."
];

const randomQuote = quotes[Math.floor(Math.random() * quotes.length)];

console.log(`💬 [CRIMSON]: "${randomQuote}"`);
console.log('\n✨ Fragle system online. Ready for missions!\n');

console.log('📋 Available commands:');
console.log('  - npm run build  (Validate the app and sprinkle a little sparkle)');
console.log('  - npm run dev    (Run with nodemon)');
console.log('  - npm start      (Run normally)');
console.log('  - npm test       (Run tests)');
console.log('\n🔮 May your code be bug-free and your commits be clean!\n');
