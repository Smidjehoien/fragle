// preload.js - Context bridge for Electron
// Safely expose IPC to renderer

const { contextBridge, ipcRenderer } = require('electron');

contextBridge.exposeInMainWorld('electron', {
    navigate: (screen) => ipcRenderer.send('navigate', screen),
    showAbout: () => ipcRenderer.send('show-about'),
    chaosMode: () => ipcRenderer.send('chaos-mode'),
    
    // Listen for navigation
    onNavigate: (callback) => {
        ipcRenderer.on('navigate', (event, screen) => callback(screen));
    },
    onChaosMode: (callback) => {
        ipcRenderer.on('chaos-mode', (event) => callback());
    }
});
