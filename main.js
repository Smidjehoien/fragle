// main.js - Electron entry point
// Transform Fragle into a native macOS/Windows/Linux app

const { app, BrowserWindow, Menu, ipcMain } = require('electron');
const path = require('path');
const isDev = require('electron-is-dev');

// Or fallback
function getIsDev() {
    return process.env.ELECTRON_DEV === 'true' || process.argv.includes('--dev');
}

const IS_DEV = getIsDev();

let mainWindow;

function createWindow() {
    mainWindow = new BrowserWindow({
        width: 1200,
        height: 800,
        minWidth: 800,
        minHeight: 600,
        webPreferences: {
            nodeIntegration: false,
            contextIsolation: true,
            preload: path.join(__dirname, 'preload.js')
        },
        icon: path.join(__dirname, 'assets', 'icon.png')
    });

    const startUrl = IS_DEV 
        ? 'http://localhost:3000'
        : `file://${path.join(__dirname, 'public', 'index.html')}`;

    mainWindow.loadURL(startUrl);

    if (IS_DEV) {
        mainWindow.webContents.openDevTools();
    }

    mainWindow.on('closed', () => {
        mainWindow = null;
    });
}

app.on('ready', () => {
    createWindow();
    createMenu();
});

app.on('window-all-closed', () => {
    // On macOS, apps stay active until user quits explicitly
    if (process.platform !== 'darwin') {
        app.quit();
    }
});

app.on('activate', () => {
    if (mainWindow === null) {
        createWindow();
    }
});

// Create application menu
function createMenu() {
    const template = [
        {
            label: '🎪 Fragle',
            submenu: [
                {
                    label: 'About Fragle',
                    click: () => {
                        if (mainWindow) {
                            mainWindow.webContents.send('show-about');
                        }
                    }
                },
                { type: 'separator' },
                {
                    label: 'Quit Fragle',
                    accelerator: 'CmdOrCtrl+Q',
                    click: () => app.quit()
                }
            ]
        },
        {
            label: 'Edit',
            submenu: [
                { role: 'undo' },
                { role: 'redo' },
                { type: 'separator' },
                { role: 'cut' },
                { role: 'copy' },
                { role: 'paste' }
            ]
        },
        {
            label: 'View',
            submenu: [
                { role: 'reload' },
                { role: 'forceReload' },
                { role: 'toggleDevTools' },
                { type: 'separator' },
                { role: 'resetZoom' },
                { role: 'zoomIn' },
                { role: 'zoomOut' },
                { type: 'separator' },
                { role: 'togglefullscreen' }
            ]
        },
        {
            label: 'Theatre',
            submenu: [
                {
                    label: '🎭 Enter Main Menu',
                    accelerator: 'CmdOrCtrl+M',
                    click: () => {
                        if (mainWindow) {
                            mainWindow.webContents.send('navigate', 'main-menu');
                        }
                    }
                },
                {
                    label: '🔮 Ask Oracle',
                    accelerator: 'CmdOrCtrl+O',
                    click: () => {
                        if (mainWindow) {
                            mainWindow.webContents.send('navigate', 'oracle');
                        }
                    }
                },
                { type: 'separator' },
                {
                    label: '🌀 Chaos Mode',
                    click: () => {
                        if (mainWindow) {
                            mainWindow.webContents.send('chaos-mode');
                        }
                    }
                }
            ]
        }
    ];

    const menu = Menu.buildFromTemplate(template);
    Menu.setApplicationMenu(menu);
}

// IPC handlers
ipcMain.on('app-ready', () => {
    mainWindow.webContents.send('app-initialized');
});

module.exports = app;
