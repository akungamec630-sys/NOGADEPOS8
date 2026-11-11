const { app, BrowserWindow } = require('electron');
const path = require('path');
app.whenReady().then(() => {
  const w = new BrowserWindow({ width: 1280, height: 800, autoHideMenuBar: true });
  w.loadFile(path.join(__dirname, 'www', 'index.html'));
});
app.on('window-all-closed', () => app.quit());
