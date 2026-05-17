#!/usr/bin/env node
'use strict';

const path = require('path');
const fs = require('fs');
const { spawn } = require('child_process');

const binaryName = "vbct";
const executable = process.platform === 'win32' ? binaryName + '.exe' : binaryName;
const binaryPath = path.join(__dirname, 'bin', executable);

if (!fs.existsSync(binaryPath)) {
  console.error('[drb99] Binary is missing. Reinstall the package to trigger postinstall.');
  process.exit(1);
}

const child = spawn(binaryPath, process.argv.slice(2), { stdio: 'inherit' });

child.on('error', (err) => {
  console.error('[drb99] Failed to start binary:', err.message);
  process.exit(1);
});

child.on('exit', (code, signal) => {
  if (signal) {
    process.kill(process.pid, signal);
    return;
  }
  process.exit(code === null ? 1 : code);
});
