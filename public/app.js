// Fragle Web UI - Main Application Logic
// Absolutely unhinged theatre orchestration

class FragleTheatre {
    constructor() {
        this.currentScreen = 'loading-screen';
        this.currentLevel = null;
        this.ws = null;
        this.chaosLevel = Math.random() * 100;
        
        this.init();
    }

    init() {
        this.setupEventListeners();
        this.simulateLoading();
    }

    simulateLoading() {
        // Animated loading with chaotic status messages
        const statuses = [
            'Reality initialization: 10%',
            'Invoking theatrical systems: 25%',
            'Destiny module loading: 40%',
            'Persona detection: 60%',
            'Free will simulation: 75%',
            'Consciousness: CRITICAL',
            'Theatre fully online: 100%'
        ];

        let index = 0;
        const interval = setInterval(() => {
            const statusEl = document.getElementById('loading-status');
            if (statusEl && index < statuses.length) {
                statusEl.textContent = statuses[index];
                index++;
            } else {
                clearInterval(interval);
                this.finishLoading();
            }
        }, 400);
    }

    finishLoading() {
        setTimeout(() => {
            this.switchScreen('main-menu');
            this.detectPersona();
            this.updateChaosLevel();
        }, 800);
    }

    detectPersona() {
        // Simple client-side persona detection based on browser signals
        const personas = ['technical', 'aggressive', 'artistic', 'curious', 'chaotic'];
        const hour = new Date().getHours();
        
        let persona = personas[Math.floor(Math.random() * personas.length)];
        
        // Late night = aggressive
        if (hour >= 22 || hour <= 5) {
            persona = 'aggressive';
        }
        // Morning = curious
        else if (hour >= 9 && hour <= 12) {
            persona = 'curious';
        }
        
        const personaDisplay = document.getElementById('persona-display');
        personaDisplay.innerHTML = `
            <p><strong>Detected Persona:</strong></p>
            <p style="color: #FFD600; font-size: 1.2rem; margin-top: 0.5rem;">${persona.toUpperCase()}</p>
            <p style="color: #909090; font-size: 0.85rem; margin-top: 0.5rem;">The theatre knows who you are.</p>
        `;
    }

    updateChaosLevel() {
        this.chaosLevel = Math.random() * 100;
        const chaosText = this.chaosLevel > 75 ? 'BEYOND' : 
                         this.chaosLevel > 50 ? 'CRITICAL' :
                         this.chaosLevel > 25 ? 'ELEVATED' : 'NOMINAL';
        
        document.getElementById('chaos-level').textContent = chaosText;
    }

    setupEventListeners() {
        // Screen navigation
        document.querySelectorAll('[data-screen]').forEach(btn => {
            btn.addEventListener('click', () => {
                this.switchScreen(btn.getAttribute('data-screen'));
            });
        });

        // Level selection
        document.querySelectorAll('.level-card').forEach(card => {
            card.addEventListener('click', () => {
                this.enterTrap(card.getAttribute('data-level'));
            });
        });

        // Oracle
        document.getElementById('oracle-btn')?.addEventListener('click', () => {
            this.switchScreen('oracle');
            this.askOracle();
        });

        document.getElementById('ask-again')?.addEventListener('click', () => {
            this.askOracle();
        });

        // About
        document.getElementById('about-btn')?.addEventListener('click', () => {
            this.switchScreen('about');
        });

        // Escape trap
        document.getElementById('escape-trap')?.addEventListener('click', () => {
            this.switchScreen('main-menu');
        });

        // Keyboard shortcuts
        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape') {
                if (this.currentScreen === 'trap-experience') {
                    this.switchScreen('main-menu');
                }
            }
        });
    }

    switchScreen(screenId) {
        // Hide current
        const current = document.getElementById(this.currentScreen);
        if (current) {
            current.classList.remove('active');
        }

        // Show new
        const next = document.getElementById(screenId);
        if (next) {
            next.classList.add('active');
            this.currentScreen = screenId;
        }
    }

    enterTrap(level) {
        this.currentLevel = level;
        this.switchScreen('trap-experience');

        // Update trap display
        document.getElementById('trap-level-display').textContent = `Level: ${level}`;

        // Fetch trap info
        fetch(`/api/theatre/${level}`)
            .then(r => r.json())
            .then(data => {
                document.getElementById('trap-info').innerHTML = `
                    <h3>${data.title}</h3>
                    <p><strong>Description:</strong> ${data.description}</p>
                    <p><strong>Silliness:</strong> ${data.silliness}</p>
                    <p><strong>Duration:</strong> ${data.duration}</p>
                    <p><strong>Experience:</strong> <em>${data.experience}</em></p>
                `;
            });

        // Start trap animation
        this.simulateTrapSequence(level);
    }

    simulateTrapSequence(level) {
        const messagesEl = document.getElementById('trap-messages');
        const progressEl = document.getElementById('progress-fill');
        const progressText = document.getElementById('progress-text');

        const trapMessages = [
            '🎭 Activating theatrical machinery...',
            '🎪 Loading persona-aware chaos vectors...',
            '🌀 Engaging reality destabilization protocols...',
            '💫 Merging consciousness with the trap...',
            '🎨 Painting existence in impossible colours...',
            '⚡ Escalating consciousness erosion...',
            '🔮 The trap becomes aware of the trap...',
            '✨ You are the trap. The trap is you.',
            '🌌 Transcendence imminent...',
            '✓ Trap sequence complete (or did it complete you?)'
        ];

        let progress = 0;
        let messageIndex = 0;

        const progressInterval = setInterval(() => {
            progress += Math.random() * 15;
            if (progress >= 100) {
                progress = 100;
                clearInterval(progressInterval);
                progressText.textContent = '✓ Trap Experience Complete';
                progressEl.style.width = '100%';
            } else {
                progressEl.style.width = progress + '%';
                progressText.textContent = Math.floor(progress) + '%';
            }
        }, 600);

        const messageInterval = setInterval(() => {
            if (messageIndex < trapMessages.length) {
                const messageDiv = document.createElement('div');
                messageDiv.className = 'message';
                messageDiv.textContent = trapMessages[messageIndex];
                messagesEl.appendChild(messageDiv);
                messagesEl.scrollTop = messagesEl.scrollHeight;
                messageIndex++;
            } else {
                clearInterval(messageInterval);
            }
        }, 500);
    }

    askOracle() {
        const oracleMessage = document.getElementById('oracle-message');
        oracleMessage.textContent = 'The Oracle is thinking...';

        fetch('/api/oracle')
            .then(r => r.json())
            .then(data => {
                setTimeout(() => {
                    oracleMessage.textContent = data.quote;
                    oracleMessage.style.animation = 'none';
                    setTimeout(() => {
                        oracleMessage.style.animation = 'oracle-glow 2s infinite';
                    }, 10);
                }, 800);
            })
            .catch(() => {
                oracleMessage.textContent = 'The Oracle has left this realm. Try again.';
            });
    }
}

// Initialize on load
document.addEventListener('DOMContentLoaded', () => {
    new FragleTheatre();
});
